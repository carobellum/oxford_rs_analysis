#/bin/bash
# ------------------------------------------------------------------------------
# Script name:  get_network_strength.sh
#
# Description:  Script to extract network strength.
#
# Author:       Caroline Nettekoven, 2020
#
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# Options
network=9
dim=50
thresh=3
# ------------------------------------------------------------------------------
if [[ ! -f /Users/CN/Documents/Projects/Joystick_Cereb_MRS/derivatives/gica/sub17/dim${dim}_s5/groupmask_n${network}_thr${thresh}.nii.gz ]]; then
    echo Creating mask...
    # Create mask:
    fslroi \
    /Users/CN/Documents/Projects/Joystick_Cereb_MRS/derivatives/gica/sub17/dim${dim}_s5/melodic_IC \
    /Users/CN/Documents/Projects/Joystick_Cereb_MRS/derivatives/gica/sub17/dim${dim}_s5/groupmask_n`zeropad ${network} 2`_thr${thresh} \
    0 -1 0 -1 0 -1 $(( ${network} - 1 )) 1
    fslmaths \
    /Users/CN/Documents/Projects/Joystick_Cereb_MRS/derivatives/gica/sub17/dim${dim}_s5/groupmask_n`zeropad ${network} 2`_thr${thresh} \
    -thr ${thresh} \
    -bin \
    /Users/CN/Documents/Projects/Joystick_Cereb_MRS/derivatives/gica/sub17/dim${dim}_s5/groupmask_n`zeropad ${network} 2`_thr${thresh}
fi

dr_img=/Users/CN/Documents/Projects/Joystick_Cereb_MRS/derivatives/dr/sub17/dim${dim}_s5/dr_stage2_ic`zeropad $(( ${network} - 1 )) 4`.nii.gz
mask=/Users/CN/Documents/Projects/Joystick_Cereb_MRS/derivatives/gica/sub17/dim${dim}_s5/groupmask_n`zeropad ${network} 2`_thr3.nii.gz
output=/Users/CN/Documents/Projects/Joystick_Cereb_MRS/derivatives/dr/sub17/dim${dim}_s5/strength_n`zeropad ${network} 2`.txt
# ------------------------------------------------------------------------------
fslmeants -i ${dr_img} -m ${mask} > ${output}

# To check mask image and dr image visually:
fsleyes -std ${mask} -dr 0 1 -cm green -a 50 ${dr_img} -dr 4 15 -cm red-yellow &
fsleyes -std /Users/CN/Documents/Projects/Joystick_Cereb_MRS/derivatives/gica/sub17/dim${dim}_s5/melodic_IC -dr 4 15 -cm red-yellow &



