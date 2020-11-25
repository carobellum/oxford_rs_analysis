#/bin/bash
# ------------------------------------------------------------------------------
# Script name:  prep_rois.sh
#
# Description:  Script to prepare standard space ROIs
#
# Author:       Caroline Nettekoven, 2020
#
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

# Dependencies
BIDSderiv_local=/Users/CN/Documents/Projects/Joystick_Cereb_MRS/derivatives
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
atlas=${BIDSderiv_local}/rois/Cerebellum-MNIsegment

# Extract rois from atlas
upper_limit=`fslstats ${atlas} -R | awk '{print $2}'`
for i in $(seq 1 $upper_limit); do
    echo $i;
    fslmaths -dt int ${atlas} -thr ${i} -uthr ${i} -bin ${atlas}_`zeropad ${i} 2`
done

# Stack extracted roi masks
fslmerge -t ${atlas}_stacked `ls ${atlas}_??.nii.gz`
