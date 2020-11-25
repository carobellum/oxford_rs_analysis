#!/bin/bash
# --------------------------------------------------
# Script name:  generate_groupmask.sh
#
# Description:  Script to generate group mask for network for randomise
#
# Author:       Caroline Nettekoven, 2020
#
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# SETTINGS
# ------------------------------------------------------------------------------
nsub=17
dim=50
mel=sub${n_sub}/dim${dim}_s5
maskthreshold=3
# ------------------------------------------------------------------------------
# Set fixed parameters
nets=networks_of_interest.txt
melpath=/vols/Data/ping/caro/cerebmrsi/derivatives/gica/${mel}

for n in `cat ${melpath}/${nets} | awk '{print $1}'`; do
    n=${n%%,*}
    echo ${n}
    component=$(( ${n}-1 ))
    
    fslroi ${melpath}/melodic_IC  ${melpath}/groupmask_n${n}_thr${maskthreshold} 0 -1 0 -1 0 -1 ${component} 1
    fslmaths  ${melpath}/groupmask_n${n}_thr${maskthreshold}  -thr ${maskthreshold} -bin ${melpath}/groupmask_n${n}_thr${maskthreshold}
done

