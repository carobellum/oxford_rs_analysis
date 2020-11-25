#!/bin/bash
# ------------------------------------------------------------------------------
# Script name:  inspect_gicas.sh
#
# Description:  Copy group level components locally
#
# Author:       Caroline Nettekoven, 2020
#
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# Options
n_sub=17
# ------------------------------------------------------------------------------
BIDSderiv=/vols/Data/ping/caro/cerebmrsi/derivatives/
smooth=5
for dim in AUTO 10 15 25 50; do
    mel_cluster=${BIDSderiv}/gica/sub${n_sub}/dim${dim}_s${smooth} # Path to output folder
    if [[ ! -d /Users/CN/Documents/Projects/Joystick_Cereb_MRS/derivatives/gica/sub${n_sub}/dim${dim}_s${smooth} ]]; then
    scp -r cn:/${mel_cluster}/ /Users/CN/Documents/Projects/Joystick_Cereb_MRS/derivatives/gica/sub${n_sub}/.
    fi
done

ls raw/sub-*/ses-*/func/*5.ica/filtered_func_data_clean.nii.gz

BIDSraw_local=/Users/CN/Documents/Projects/Joystick_Cereb_MRS/raw
subjList="sub-01 sub-02  sub-03  sub-04  sub-05  sub-06  sub-07  sub-09  sub-10  sub-11  sub-12  sub-13  sub-14  sub-15 sub-16 sub-17"
condList="adapt control"
acqList="1 2"
for id in ${subjList}   ; do
    for cond in ${condList} ; do
        for acq in ${acqList}   ; do


            # fsl_sub invwarp -w ${reg}/example_func2standard_warp -o ${reg}/standard2example_func_warp -r ${reg}/standard

            n_rois=`ls ${BIDSraw_local}/${id}/ses-${cond}/func/${id}_ses-${cond:0:1}_task-rest_acq-${acq}_bold_smooth-5.ica/roi  | wc | awk '{print $1}'`
            if [[ ! "$n_rois" = "9" ]]; then
                echo ${id}
            fi

        done
    done
done
