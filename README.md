# ChemShell Scripts
These are shell scripts for running QM/MM calculations in DL_ChemShell. They rely on specific directory structures and filename conventions, and probably won't work if you don't use them in conjunction with various other scripts for processing PDB files, as well as the gromacs.sh script in my other repository. 

These are quite crude at the moment and need polishing. 

# chm_opt_snapshot
This sets up a QM/MM calculation directly from an MD snapshot. The user is prompted for various files, which specify ChemShell input options and other job details. 

# chm_opt_general
This sets up a QM/MM calculation from another completed QM/MM calculation. Again, the user is prompted for various files, which specify ChemShell input options and other job details. The psf file (needed for chemshell) is generated from scratch every time.

At a later date I will merge these two, remove some redundant options and resolve compatibility issues.
