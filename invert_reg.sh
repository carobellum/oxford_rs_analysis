#!/bin/bash
# ------------------------------------------------------------------------------
# Script name:  invert_reg.sh
#
# Description:  Invert registration
#
# Author:       Caroline Nettekoven, 2020
#
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# Options
# ------------------------------------------------------------------------------
BIDSraw=/vols/Data/ping/caro/cerebmrsi/raw
subjList="sub-01 sub-02  sub-03  sub-04  sub-05  sub-06  sub-07 sub-08  sub-09  sub-10  sub-11  sub-12  sub-13  sub-14  sub-15 sub-16 sub-17"
condList="adapt control"
acqList="1 2"
for id in ${subjList}   ; do
    for cond in ${condList} ; do
        for acq in ${acqList}   ; do
            
            reg=${BIDSraw}/${id}/ses-${cond}/func/${id}_ses-${cond:0:1}_task-rest_acq-${acq}_bold_smooth-5.ica/reg
            
            fsl_sub -q short.q invwarp -w ${reg}/highres2standard_warp.nii.gz -o ${reg}/standard2highres_warp.nii.gz -r ${reg}/highres
            
        done
    done
done
