#!/bin/bash
# ------------------------------------------------------------------------------
# Script name:  inspect_gicas.sh
#
# Description:  Copy group level components locally and inspect
#
# Author:       Caroline Nettekoven, 2020
#
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# Copy to cluster
for n_sub in 15 16 17; do
for dim in 10; do
    mel_local=/Users/CN/Documents/Projects/Joystick_Cereb_MRS/derivatives/gica/sub${n_sub}/dim${dim}_s5/
    mel_cluster=/vols/Data/ping/caro/cerebmrsi/derivatives/gica/sub${n_sub}/dim${dim}_s5 # Path to output folder

    cat ${mel_local}/labels_manual | grep "True" | awk '{print $1}' > ${mel_local}/networks_of_interest.txt
    # Text files
    scp -r ${mel_local}/networks_of_interest.txt cn:/${mel_cluster}/.
done
done
ButFMRIB1sh0m3:)
