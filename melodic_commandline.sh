#!/bin/bash
# ------------------------------------------------------------------------------
# Script name:  melodic_commandline.sh
#
# Description:  Runs the group melodic ICA on clean, processed data (cleaned through fix; then smoothed and registered to standard)
#
# Author:       Caroline Nettekoven, 2020
#
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
MNIstandard=/opt/fmrib/fsl/data/standard/MNI152_T1_2mm_brain_mask.nii.gz # Path to MNIstandard
# ------------------------------------------------------------------------------
# Options
dim=25 # Choose from: AUTO 50 25 15 10
wait_for_job=309039
# ------------------------------------------------------------------------------

inputfiles=/vols/Data/ping/caro/cerebmrsi/bin/input_gica_s5_sub17.txt # Path to textfile that litst paths to data
outfolder=/vols/Data/ping/caro/cerebmrsi/derivatives/gica/sub17/dim${dim}_s5 # Path to output folder

if [ "${dim}" == "AUTO" ]; then # This line checks if cleaned dataset exists and data hasn't already been registered
    echo "Running melodic with automatic dimensionality estimation"
    fsl_sub melodic -i $inputfiles -o ${outfolder} --tr=0.735 --nobet -a concat -m $MNIstandard --report --Oall #run automatic dimensionality estimation
    
    
else
    echo "Running melodic with dim ${dim}"
    fsl_sub melodic -i $inputfiles -o ${outfolder} --tr=0.735 --nobet -a concat -m $MNIstandard --report --Oall -d ${dim} #melodic command; to define the number of dimensions add -d and the number of dimensions
fi

