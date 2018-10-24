#!/bin/bash
# sets up optimisations for a given snapshot

function setup_snap { # The 'build' step
mkdir -p $BUILDDIR

# copy unoptimised snapshot
#cp $OPTDIR/$SNAP.gro $BUILDDIR/$SNAP\_pre.gro
# make pdb from unoptimised snapshot
#$GROMDIR/editconf -f $BUILDDIR/$SNAP\_pre.gro -o $BUILDDIR/$SNAP\_pre.pdb

# copy preoptimised snapshot
cp $OPTDIR/$SNAP\_opt.pdb $BUILDDIR/$SNAP\_pre.pdb

# remove unnescessary 'end' flag
#sed -i '/END/d'   $BUILDDIR/$SNAP\_pre.pdb

# modifications to pdb for charmm compatibility
 sed -i 's/SOL /TIP3/' 			$BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/OW /OH2/'   			$BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/HW1/H1 /'   			$BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/HW2/H2 /'   			$BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/CL /CLA/'   			$BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/CL /CLA/'   			$BUILDDIR/$SNAP\_pre.pdb	# rename chloride ions for compatibility
 sed -i 's/NA   NA/SOD SOD/'   $BUILDDIR/$SNAP\_pre.pdb	# rename sodium ions for compatibility

# delete dummy atoms
 sed -i 's/DMN/MN /'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/DCA/CAL/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i '/DM1/d'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i '/DM2/d'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i '/DM3/d'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i '/DM4/d'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i '/DM5/d'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i '/DM6/d'   $BUILDDIR/$SNAP\_pre.pdb

# fix mislabeled atoms
 sed -i 's/1HG1/HG11/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/2HG1/HG12/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/3HG1/HG13/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/1HG2/HG21/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/2HG2/HG22/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/3HG2/HG23/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/1HH1/HH11/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/2HH1/HH12/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/3HH1/HH13/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/1HH2/HH21/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/2HH2/HH22/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/3HH2/HH23/'   $BUILDDIR/$SNAP\_pre.pdb
 
 sed -i 's/1HD1/HD11/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/2HD1/HD12/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/3HD1/HD13/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/1HD2/HD21/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/2HD2/HD22/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/3HD2/HD23/'   $BUILDDIR/$SNAP\_pre.pdb
 
 sed -i 's/1HE2/HE21/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/2HE2/HE22/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/3HE2/HE23/'   $BUILDDIR/$SNAP\_pre.pdb
 
 sed -i 's/1HMA/HMA1/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/2HMA/HMA2/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/3HMA/HMA3/'   $BUILDDIR/$SNAP\_pre.pdb
 
 sed -i 's/1HMB/HMB1/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/2HMB/HMB2/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/3HMB/HMB3/'   $BUILDDIR/$SNAP\_pre.pdb
 
 sed -i 's/1HMC/HMC1/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/2HMC/HMC2/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/3HMC/HMC3/'   $BUILDDIR/$SNAP\_pre.pdb
 
 sed -i 's/1HMD/HMD1/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/2HMD/HMD2/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/3HMD/HMD3/'   $BUILDDIR/$SNAP\_pre.pdb
 
 sed -i 's/1HAA/HAA1/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/2HAA/HAA2/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/3HAA/HAA3/'   $BUILDDIR/$SNAP\_pre.pdb
 
 sed -i 's/1HAD/HAD1/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/2HAD/HAD2/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/3HAD/HAD3/'   $BUILDDIR/$SNAP\_pre.pdb
 
 sed -i 's/1HBA/HBA1/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/2HBA/HBA2/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/3HBA/HBA3/'   $BUILDDIR/$SNAP\_pre.pdb
 
 sed -i 's/1HBB/HBB1/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/2HBB/HBB2/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/3HBB/HBB3/'   $BUILDDIR/$SNAP\_pre.pdb
 
 sed -i 's/1HBC/HBC1/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/2HBC/HBC2/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/3HBC/HBC3/'   $BUILDDIR/$SNAP\_pre.pdb
 
 sed -i 's/1HBD/HBD1/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/2HBD/HBD2/'   $BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/3HBD/HBD3/'   $BUILDDIR/$SNAP\_pre.pdb
 
#sed -i 's/ OT1 /O/'   	$BUILDDIR/$SNAP\_pre.pdb
#sed -i '/ OT2 /d'   	$BUILDDIR/$SNAP\_pre.pdb
 
 sed -i 's/H1  ALA/HT1 ALA/'   	$BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/H2  ALA/HT2 ALA/'   	$BUILDDIR/$SNAP\_pre.pdb
 sed -i 's/H3  ALA/HT3 ALA/'   	$BUILDDIR/$SNAP\_pre.pdb

#reatom and reres pdb
$PDBTOOLSDIR/pdb_reatom.py $BUILDDIR/$SNAP\_pre.pdb > $BUILDDIR/reat
#$PDBTOOLSDIR/pdb_reres.py $BUILDDIR/reat > $BUILDDIR/$SNAP\_pre.pdb
cat $BUILDDIR/reat > $BUILDDIR/$SNAP\_pre.pdb
rm $BUILDDIR/reat

# setup_his_protstates
#sed -i 's/HIS/HSE/'   $BUILDDIR/$SNAP\_pre.pdb
build_his

cp $SCRPDIR/charmm_build.inp	$BUILDDIR/charmm_build.inp
cp $SCRPDIR/charmm.inp			$BUILDDIR/charmm.inp

cp $SCRPDIR/chemshell-setup.chm	$BUILDDIR/chemshell-setup.chm

sed -i "s/{SNAP}/$SNAP/"		$BUILDDIR/charmm_build.inp
sed -i "s/{SNAP}/$SNAP/"		$BUILDDIR/charmm.inp
sed -i "s/{SNAP}/$SNAP/"		$BUILDDIR/chemshell-setup.chm

cd $BUILDDIR

fix_get_segs
chmod u+x $BUILDDIR/get_segs
./get_segs

prep_charmm_build
setup_aspp_patches
setup_glup_patches

charmm < charmm_build.inp > charmm_build.out
chemsh chemshell-setup.chm

# clean up files
rm	$BUILDDIR/*.tmp
#rm	$BUILDDIR/*.gro
mkdir -p	$BUILDDIR/segments
mv PROT.pdb	$BUILDDIR/segments/
mv IONS.pdb	$BUILDDIR/segments/
mv XION.pdb $BUILDDIR/segments/
mv WA*.pdb	$BUILDDIR/segments/
mv get_segs	$BUILDDIR/segments/
}

function setup_job {
#	JOBDIR="$QMMMDIR/$JOB"
	mkdir -p $JOBDIR

# copy the generic setup files into the directory for the specific QM region
	#cp $BUILDDIR/* $JOBDIR
	cp $BUILDDIR/$SNAP.pdb	$JOBDIR
	cp $BUILDDIR/save*.chm	$JOBDIR
	cp $BUILDDIR/*.ctcl		$JOBDIR
	cp $BUILDDIR/*.inp		$JOBDIR
	cp $BUILDDIR/*.psf		$JOBDIR
	cp $BUILDDIR/*.crd		$JOBDIR
	cp $BUILDDIR/*.c		$JOBDIR
	
	cd $JOBDIR

# copy the script that defines the QM region
	cp $SCRPDIR/$PREPSCRIPT.chm		$JOBDIR/chemshell-prep.chm
	sed -i "s/{SNAP}/$SNAP/" 		$JOBDIR/chemshell-prep.chm

#cp $PRMDIR/par_all27_prot_na.prm	$JOBDIR/par_all27_prot_na.prm
#cp $PRMDIR/top_all27_prot_na		$JOBDIR/top_all27_prot_na
	
chemsh chemshell-prep.chm

#cp $SCRPDIR/auxbasis		$JOBDIR/auxbasis

cp $SCRPDIR/$JOB.chm		$JOBDIR/$JOB.chm
sed -i "s/{SNAP}/$SNAP/"	$JOBDIR/$JOB.chm

cp $SCRPDIR/sub-chemshell 	$JOBDIR/sub-chemshell
sed -i "s/{JOBNAME}/$JOB/" 	$JOBDIR/sub-chemshell

qsub -N $JOB\_$PDB sub-chemshell

# clean up files
find $JOBDIR/ -size 0 -delete
}

function fix_get_segs {
# normal segments
grep 'ATOM' $BUILDDIR/$SNAP\_pre.pdb | grep -E -v 'TIP3|CLA|CAL|MN|SOD' | head -1 | sed 's/^......//' | sed 's/.................................................................$//' | sed -r 's/\s+//g' > prot_f.tmp
PROTF="$(< prot_f.tmp)"
grep 'ATOM' $BUILDDIR/$SNAP\_pre.pdb | grep -E -v 'TIP3|CLA|CAL|MN|SOD' | tail -1 | sed 's/^......//' | sed 's/.................................................................$//' | sed -r 's/\s+//g' > prot_l.tmp
PROTL="$(< prot_l.tmp)"

grep 'ATOM' $BUILDDIR/$SNAP\_pre.pdb | grep -E 'CLA|SOD' | head -1 | sed 's/^......//' | sed 's/..................................................................$//' | sed -r 's/\s+//g' > ions_f.tmp
IONSF="$(< ions_f.tmp)"
grep 'ATOM' $BUILDDIR/$SNAP\_pre.pdb | grep -E 'CLA|SOD' | tail -1 | sed 's/^......//' | sed 's/..................................................................$//' | sed -r 's/\s+//g' > ions_l.tmp
IONSL="$(< ions_l.tmp)"

grep 'ATOM' $BUILDDIR/$SNAP\_pre.pdb | grep -E 'CAL|MN' | head -1 | sed 's/^......//' | sed 's/..................................................................$//' | sed -r 's/\s+//g' > xion_f.tmp
XIONF="$(< xion_f.tmp)"
grep 'ATOM' $BUILDDIR/$SNAP\_pre.pdb | grep -E 'CAL|MN' | tail -1 | sed 's/^......//' | sed 's/..................................................................$//' | sed -r 's/\s+//g' > xion_l.tmp
XIONL="$(< xion_l.tmp)"

echo ''
echo " Protein: $PROTF - $PROTL"
echo " Metals : $XIONF - $XIONL"
echo " Ions   : $IONSF - $IONSL"
echo ''

echo prepare_for_charmm $SNAP\_pre.pdb $PROTF $PROTL PROT PROT.pdb > $BUILDDIR/get_segs
echo prepare_for_charmm $SNAP\_pre.pdb $XIONF $XIONL XION XION.pdb >> $BUILDDIR/get_segs
echo prepare_for_charmm $SNAP\_pre.pdb $IONSF $IONSL IONS IONS.pdb >> $BUILDDIR/get_segs

#solvent segments must be length 2996 , or have less than 999 residues
#get total number of solvent water atoms
SOL_TOT="$(grep 'TIP3' $BUILDDIR/$SNAP\_pre.pdb | wc -l)"
echo $SOL_TOT | awk '{printf "%.0f\n", $1 / 2996}' > n_segs.tmp
N_SEGS="$(< n_segs.tmp)"
SOLF="$(grep 'TIP3' $BUILDDIR/$SNAP\_pre.pdb | head -1 | sed 's/^......//' | sed 's/..................................................................$//' | sed -r 's/\s+//g')"
SOLL="$(grep 'TIP3' $BUILDDIR/$SNAP\_pre.pdb | tail -1 | sed 's/^......//' | sed 's/..................................................................$//' | sed -r 's/\s+//g')"

echo " Solvent total : $SOL_TOT "
echo " Segmets needed: $N_SEGS "
echo " Atoms  : $SOLF - $SOLL"
echo ''

WAT_SEGS="$(seq 1 $N_SEGS)"
SEGF=$SOLF
for SEG in $WAT_SEGS; do	
	echo $SEGF | awk '{printf $1 + 2996}' > last.tmp
	SEGL="$(< last.tmp)"
	if [ ${SEGL} -gt ${SOLL} ]; then
		SEGL=$SOLL
	fi
	
		if [ ${SEG} -ge 10 ]; then    # because segment ids have to be 4 chars
		echo prepare_for_charmm $SNAP\_pre.pdb $SEGF $SEGL WA$SEG WA$SEG.pdb >> $BUILDDIR/get_segs
		else
		echo prepare_for_charmm $SNAP\_pre.pdb $SEGF $SEGL WAT$SEG WAT$SEG.pdb >> $BUILDDIR/get_segs
		fi
	
	echo $SEGL | awk '{printf $1 + 1}' > first.tmp
	SEGF="$(< first.tmp)"
done
}

function prep_charmm_build {
# create read and join statements for charmm script
for SEG in $WAT_SEGS; do
if [ ${SEG} -ge 10 ]; then
	echo "open read unit 10 card name \"./WA$SEG.pdb\"" >> wat_segs.tmp
	echo "read sequence pdb appe unit 10"                     	>> wat_segs.tmp
	echo "gene WA$SEG noangle nodihedral warn setup"        	>> wat_segs.tmp
	echo ''                                                  	>> wat_segs.tmp
	echo "rewind unit 10"                                    	>> wat_segs.tmp
	echo "read coor pdb resi appe unit 10"                   	>> wat_segs.tmp
	echo "close unit 10"                                     	>> wat_segs.tmp
	echo ''                                      			 	>> wat_segs.tmp
	
	echo "join WA$SEG renum" >> wat_join.tmp
else
	echo "open read unit 10 card name \"./WAT$SEG.pdb\"" >> wat_segs.tmp
	echo "read sequence pdb appe unit 10"                     	>> wat_segs.tmp
	echo "gene WAT$SEG noangle nodihedral warn setup"        	>> wat_segs.tmp
	echo ''                                                  	>> wat_segs.tmp
	echo "rewind unit 10"                                    	>> wat_segs.tmp
	echo "read coor pdb resi appe unit 10"                   	>> wat_segs.tmp
	echo "close unit 10"                                     	>> wat_segs.tmp
	echo ''                                      			 	>> wat_segs.tmp
	
	echo "join WAT$SEG renum" >> wat_join.tmp
fi
done

sed -i '/!SolventSegments/r wat_segs.tmp' $BUILDDIR/charmm_build.inp
sed -i '/!JoinStatements/r wat_join.tmp'  $BUILDDIR/charmm_build.inp
}

function setup_aspp_patches { #create aspp and glup patches
grep 'ASP' $BUILDDIR/$SNAP\_pre.pdb | sed 's/^.......................//' | sed 's/..................................................$//' | uniq > asp.tmp
RESIS="$(< asp.tmp)"
echo ''
printf ' List of Aspartates: '
echo ''
printf ' |'
for RESI in $RESIS; do
	printf " $RESI |"
done
echo '' && echo ''

for RESI in $RESIS; do
	printf " > Is ASP $RESI protonated? (y/n): "
	read ANS
		if [ ${ANS} = 'y' ]; then
			echo " Creating patch in CHARMM input file..."
			echo "patch ASPP PROT $RESI warn setup" >> aspp_patches.tmp
			#echo "AUTOgenerate ANGLes DIHEdrals" 	>> aspp_patches.tmp
		else
			sleep 0
		fi
	echo ''
done

sed -i '/!ASPPpatches/r aspp_patches.tmp' $BUILDDIR/charmm_build.inp

echo 'Appended to CHARMM script:'
cat aspp_patches.tmp && rm aspp_patches.tmp
echo ''

rm asp.tmp
}

function setup_glup_patches { #create glup and glup patches
grep 'GLU' $BUILDDIR/$SNAP\_pre.pdb | sed 's/^.......................//' | sed 's/..................................................$//' | uniq > glu.tmp
RESIS="$(< glu.tmp)"
echo ''
printf ' List of Glutamates: '
echo ''
printf ' |'
for RESI in $RESIS; do
	printf " $RESI |"
done
echo '' && echo ''

for RESI in $RESIS; do
	printf " > Is GLU $RESI protonated? (y/n): "
	read ANS
		if [ ${ANS} = 'y' ]; then
			echo " Creating patch in CHARMM input file..."
			echo "patch GLUP PROT $RESI warn setup" >> glup_patches.tmp
			#echo "AUTOgenerate ANGLes DIHEdrals"	>> glup_patches.tmp
		else
			sleep 0
		fi
	echo ''
done

sed -i '/!GLUPpatches/r glup_patches.tmp' $BUILDDIR/charmm_build.inp

echo 'Appended to CHARMM script:'
cat glup_patches.tmp && rm glup_patches.tmp
echo ''

rm glu.tmp
}

function build_his {              # Selects protonation states for histidies by editing the PDB residue labels
grep 'ATOM' $BUILDDIR/$SNAP\_pre.pdb | grep 'HIS' | sed 's/^.......................//' | sed 's/..................................................$//' | uniq > his.tmp
RESIS="$(< his.tmp)"
echo ''
printf ' List of Histidines: '
echo ''
printf ' |'
for RESI in $RESIS; do
	printf " $RESI |"
done
echo '' && echo ''

for RESI in $RESIS; do
	echo " > Please choose protonation state for HIS $RESI: "
	echo ' 1. HSD'
	echo ' 2. HSE'
	echo ' 3. HSP'
	echo ''
	printf " > Input: "
	read ps
	if [ ${ps} = '1' ]; then
		sed -i "s/HIS   $RESI/HSD   $RESI/" 	$BUILDDIR/$SNAP\_pre.pdb
		sed -i "s/HIS    $RESI/HSD    $RESI/" 	$BUILDDIR/$SNAP\_pre.pdb	
	elif [ ${ps} = '2' ]; then
		sed -i "s/HIS   $RESI/HSE   $RESI/" 	$BUILDDIR/$SNAP\_pre.pdb
		sed -i "s/HIS    $RESI/HSE    $RESI/" 	$BUILDDIR/$SNAP\_pre.pdb	
	elif [ ${ps} = '3' ]; then
		sed -i "s/HIS   $RESI/HSP   $RESI/" 	$BUILDDIR/$SNAP\_pre.pdb
		sed -i "s/HIS    $RESI/HSP    $RESI/" 	$BUILDDIR/$SNAP\_pre.pdb
	else
		sleep 0
	fi
	echo ''
	#echo "============================================================================"
	grep "A $RESI" 	$BUILDDIR/$SNAP\_pre.pdb | uniq
	grep "A  $RESI" $BUILDDIR/$SNAP\_pre.pdb | uniq
	echo ''
done

rm his.tmp
}

function pre_initialise {
GROMDIR="/cvos/shared/apps/gromacs/bin"
MAINDIR="$(pwd)"
INITDIR="$MAINDIR/geom/initial"
 MDPDIR="$MAINDIR/mdp"
 PRMDIR="$MAINDIR/param"
 PDBTOOLSDIR="/home/jdc6/bin/pdb-tools"
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

pre_initialise

echo ''
printf " > Enter system: "
read PDB

printf " > Enter snapshot: "
read SNAP

echo ''
printf " > Enter chm filename: "
read JOB

printf " >  Enter prep script: "
read PREPSCRIPT
echo ''

initialise

echo '-------------------'
echo " Gromacs Directory: $GROMDIR"
echo "   QM-MM Directory: $QMMMDIR"
echo " Scripts Directory: $SCRPDIR"
echo "   Param Directory: $PRMDIR"
echo '-------------------'
ls -l $SCRPDIR | sed 's/^.........................................//' 
echo '-------------------'
echo ''

setup_snap

setup_job

#cd $QMMMDIR

#JOB=opt_reactant
#setup_job