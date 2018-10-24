#!/bin/bash
# sets up generic chemshell job

function setup_snap {	# generates segment pdb files for charmm to stitch together and make a psf from

mkdir -p $BUILDDIR/segments		# makes the directory

# copies the input geometry and a pdb file from which to source residues
cp $RESULT_DIR/$RESULT_GEOM.c $BUILDDIR/starting_geometry.c
cp $RESULT_DIR/$RESIDUES.pdb  $BUILDDIR/pdb_residues.pdb

# makes pdb file from starting geometry to use with charmm-build
echo "read_pdb  file= ./pdb_residues.pdb coords=dummy.coords"				 > $BUILDDIR/getresult-chemshell
echo "write_pdb file= ./starting_geometry.pdb coords=./starting_geometry.c" >> $BUILDDIR/getresult-chemshell
cd $BUILDDIR && chemsh $BUILDDIR/getresult-chemshell && rm $BUILDDIR/dummy.coords

# generates segments from starting geometry for charmm-build step
cd $BUILDDIR && fix_get_segs && chmod u+x $BUILDDIR/get_segs && ./get_segs	# get segments from pdb

# moves segment pdbs to subdirectory for easy editing
mv $BUILDDIR/*.pdb $BUILDDIR/segments/
mv $BUILDDIR/segments/starting_geometry.pdb $BUILDDIR/starting_geometry.pdb
mv $BUILDDIR/segments/pdb_residues.pdb 		$BUILDDIR/pdb_residues.pdb

# insert a pause here to if you want to
# manually edit the pdbs before the build step

# cleans up files from segment generation
rm $BUILDDIR/*.tmp
rm $BUILDDIR/get_segs
rm $BUILDDIR/getresult-chemshell
}

function build_snap {	# runs charmm_build to make a useable psf

cd $BUILDDIR	# need to change to the directory for the charmm script to work properly

# copies charmm_build script from specified directory
# so it should already have all the nescessary patches
# in it for asp glu and disu
cp  $PRBDIR/charmm_build.inp		$BUILDDIR/segments/charmm_build.inp		# charmm build script that stitches together segments
cp $SCRPDIR/charmm.inp				$BUILDDIR/charmm.inp					# no idea why this is nescessary, but it is sourced by setup script
cp $SCRPDIR/chemshell-setup.chm		$BUILDDIR/chemshell-setup.chm			# setup script

# replace this with the snapshot number in the script so it works properly as a variable
sed -i "s/{SNAP}/$SNAP/"		$BUILDDIR/segments/charmm_build.inp
sed -i "s/{SNAP}/$SNAP/"		$BUILDDIR/charmm.inp
sed -i "s/{SNAP}/$SNAP/"		$BUILDDIR/chemshell-setup.chm

# run the charmm build script to finally get the psf
cd $BUILDDIR/segments/ && charmm < charmm_build.inp > charmm_build.out && cd $BUILDDIR

# copies all the files charmm made to the working directory
mv  $BUILDDIR/segments/$SNAP.pdb $BUILDDIR/$SNAP.pdb						# probably unimportant
mv  $BUILDDIR/segments/$SNAP.psf $BUILDDIR/$SNAP.psf						# important
mv  $BUILDDIR/segments/$SNAP.crd $BUILDDIR/$SNAP.crd						# probably unimportant

# runs the chemshell setup step
chemsh chemshell-setup.chm

}

function  setup_job {	# runs the prep script to define QM region etc and submits the job
	mkdir -p $JOBDIR

# copy the generic setup files into the directory for the specific QM region
cp $RESULT_DIR/$RESULT_GEOM.c	$JOBDIR/$SNAP.c	# name input geometry after snapshot for compatibility and so it has same name as psf
cp $BUILDDIR/$SNAP.pdb			$JOBDIR # made by the build step
cp $BUILDDIR/*.psf				$JOBDIR	# made by the build step
cp $BUILDDIR/*.crd				$JOBDIR # made by the build step
cp $BUILDDIR/save*.chm			$JOBDIR # made by setup script
cp $BUILDDIR/*.ctcl				$JOBDIR # made by setup script
cp $BUILDDIR/*.inp				$JOBDIR	# generic

# copy over transition mode if this is relevant
if [ ${ANS} = y ]; then 
cp $RESULT_DIR/$RESULT_MODE.c	$JOBDIR/tsmode_input.c
fi
	
cd $JOBDIR	# now in job directory

# copy the prep script
cp $SCRPDIR/$PREPSCRIPT.chm	    $JOBDIR/chemshell-prep.chm
sed -i "s/{SNAP}/$SNAP/" 		$JOBDIR/chemshell-prep.chm	# replace this with the snapshot number in the script so it works properly as a variable
	
# run prep script that defines QM region
chemsh chemshell-prep.chm

# copy over the script that defines the actual job
cp $SCRPDIR/$JOB.chm		$JOBDIR/$JOB.chm
sed -i "s/{SNAP}/$SNAP/"	$JOBDIR/$JOB.chm				# replace this with the snapshot number in the script so it works properly as a variable

# copy over the torque submission script
cp $SCRPDIR/sub-chemshell 	$JOBDIR/sub-chemshell
sed -i "s/{JOBNAME}/$JOB/" 	$JOBDIR/sub-chemshell			# sets jobname variable which points chemshell to relevant files

# submit the job
qsub -N $JOB\_$PDB sub-chemshell
}

function fix_get_segs {	# called by setup_snap to get appropriate pdb segments
# normal segments
grep 'ATOM' $BUILDDIR/starting_geometry.pdb | grep -E -v 'TIP3|CLA|CAL|MN|SOD' | head -1 | sed 's/^......//' | sed 's/.................................................................$//' | sed -r 's/\s+//g' > prot_f.tmp
PROTF="$(< prot_f.tmp)"
grep 'ATOM' $BUILDDIR/starting_geometry.pdb | grep -E -v 'TIP3|CLA|CAL|MN|SOD' | tail -1 | sed 's/^......//' | sed 's/.................................................................$//' | sed -r 's/\s+//g' > prot_l.tmp
PROTL="$(< prot_l.tmp)"

grep 'ATOM' $BUILDDIR/starting_geometry.pdb | grep -E 'CLA|SOD' | head -1 | sed 's/^......//' | sed 's/.................................................................$//' | sed -r 's/\s+//g' > ions_f.tmp
IONSF="$(< ions_f.tmp)"
grep 'ATOM' $BUILDDIR/starting_geometry.pdb | grep -E 'CLA|SOD' | tail -1 | sed 's/^......//' | sed 's/.................................................................$//' | sed -r 's/\s+//g' > ions_l.tmp
IONSL="$(< ions_l.tmp)"

grep 'ATOM' $BUILDDIR/starting_geometry.pdb | grep -E 'CAL|MN' | head -1 | sed 's/^......//' | sed 's/.................................................................$//' | sed -r 's/\s+//g' > xion_f.tmp
XIONF="$(< xion_f.tmp)"
grep 'ATOM' $BUILDDIR/starting_geometry.pdb | grep -E 'CAL|MN' | tail -1 | sed 's/^......//' | sed 's/.................................................................$//' | sed -r 's/\s+//g' > xion_l.tmp
XIONL="$(< xion_l.tmp)"

echo ''
echo " Protein: $PROTF - $PROTL"
echo " Metals : $XIONF - $XIONL"
echo " Ions   : $IONSF - $IONSL"
echo ''

echo prepare_for_charmm starting_geometry.pdb $PROTF $PROTL PROT PROT.pdb > $BUILDDIR/get_segs
echo prepare_for_charmm starting_geometry.pdb $XIONF $XIONL XION XION.pdb >> $BUILDDIR/get_segs
echo prepare_for_charmm starting_geometry.pdb $IONSF $IONSL IONS IONS.pdb >> $BUILDDIR/get_segs

#solvent segments must be length 2996 , or have less than 999 residues
#get total number of solvent water atoms

SOL_TOT="$(grep 'TIP3' $BUILDDIR/starting_geometry.pdb | wc -l)"
echo $SOL_TOT | awk '{printf "%.0f\n", $1 / 2996}' > n_segs.tmp
N_SEGS="$(< n_segs.tmp)"
SOLF="$(grep 'ATOM' $BUILDDIR/starting_geometry.pdb | grep 'TIP3' | head -1 | sed 's/^......//' | sed 's/.................................................................$//' | sed -r 's/\s+//g')"
SOLL="$(grep 'ATOM' $BUILDDIR/starting_geometry.pdb | grep 'TIP3' | tail -1 | sed 's/^......//' | sed 's/.................................................................$//' | sed -r 's/\s+//g')"

echo " Solvent total : $SOL_TOT "
echo " Segmets needed: $N_SEGS "
echo " Atoms  : $SOLF - $SOLL"
echo ''

WAT_SEGS="$(seq 1 $N_SEGS)"
SEGF=$SOLF
for SEG in $WAT_SEGS; do	
	echo $SEGF | awk '{printf $1 + 2996}' > last.tmp
	SEGL="$(< last.tmp)"
	if [ ${SEGL} -ge ${SOLL} ]; then
		SEGL=$SOLL
	fi
	
		if [ ${SEG} -ge 10 ]; then    # because segment ids have to be 4 chars
		echo prepare_for_charmm starting_geometry.pdb $SEGF $SEGL WA$SEG WA$SEG.pdb >> $BUILDDIR/get_segs
		else
		echo prepare_for_charmm starting_geometry.pdb $SEGF $SEGL WAT$SEG WAT$SEG.pdb >> $BUILDDIR/get_segs
		fi
	
	echo $SEGL | awk '{printf $1 + 1}' > first.tmp
	SEGF="$(< first.tmp)"
done
}

## INITIALISATION OF VARIABLES ##

function pre_initialise {
GROMDIR="/cvos/shared/apps/gromacs/bin"
MAINDIR="$(pwd)"
INITDIR="$MAINDIR/geom/initial"
 MDPDIR="$MAINDIR/mdp"
 PRMDIR="$MAINDIR/param"
}

function initialise {
  SYSDIR="$MAINDIR/$PDB"
 SNAPDIR="$SYSDIR/$SNAP"
SCRPDIR="$SYSDIR/scripts"
  OPTDIR="$SNAPDIR/opt"
 QMMMDIR="$SNAPDIR/qm-mm"
BUILDDIR="$QMMMDIR/$JOB/build"
  JOBDIR="$QMMMDIR/$JOB"
}

## MAIN PROGRAMME ##

pre_initialise

echo ''
echo ' +-general-info------------------------------------------------'
printf " |   System: " && read PDB
printf " | Snapshot: " && read SNAP
echo ' +--------------------------------------------------------------'
echo ''
printf " > read a transition mode? (y/n): "
read ANS
echo ''
echo ' +-input-geometry-info------------------------------------------'
printf " | Full path: " && read RESULT_DIR
printf " |    Output: " && read RESULT_GEOM
if [ ${ANS} = y ]; then 
printf " |   TS-Mode: " && read RESULT_MODE 
fi
echo ' +--------------------------------------------------------------'
echo ''
echo ' +-PSF-info-----------------------------------------------------'
printf " |   Full path to charmm_build.inp: " && read PRBDIR
printf " |  PDB from which to get resiudes: " && read RESIDUES
echo ' +--------------------------------------------------------------'
echo ''
echo ' +-new-job-info-------------------------------------------------'
printf " |    chm file: " && read JOB
printf " | prep script: " && read PREPSCRIPT
echo ' +--------------------------------------------------------------'

initialise

####CHECK CONDITION FOR DIRECTORIES EXISTING

echo ''
echo '-------------------'
echo " Gromacs Directory: $GROMDIR"
echo "   QM-MM Directory: $QMMMDIR"
echo " Scripts Directory: $SCRPDIR"
echo "   Param Directory: $PRMDIR"
echo '-------------------'
echo " Chemshell job script should reference SNAP.psf, and input.c"
echo ''

####CHECK CONDITION FOR BUILD SETUP
setup_snap

####CHECK CONDITION FOR SEG SUCCESS
build_snap

####CHECK CONDITION FOR BUILD SUCCESS
setup_job