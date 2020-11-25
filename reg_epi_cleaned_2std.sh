#!/bin/bash
# ------------------------------------------------------------------------------
# Script name:  reg_epi_cleaned_2std.sh
#
# Description:  Registers cleaned epi data to 2mm standard
#
# Author:       Caroline Nettekoven, 2020
#
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# Dependencies
BIDSraw=/vols/Data/ping/caro/cerebmrsi/raw
subjList="sub-01 sub-02  sub-03  sub-04  sub-05  sub-06  sub-07  sub-08  sub-09  sub-10  sub-11  sub-12  sub-13  sub-14  sub-15 sub-16 sub-17"
condList="adapt control"
acqList="1 2"
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

for ID in ${subjList}   ; do
    for COND in ${condList} ; do
        for ACQ in ${acqList}   ; do
            
            
            echo Registering ${ID} ${COND} ${ACQ} ...
            clean=${BIDSraw}/${ID}/ses-${COND}/func/${ID}_ses-${COND:0:1}_task-rest_acq-${ACQ}_bold_no_smooth.ica
            reg=${BIDSraw}/${ID}/ses-${COND}/func/${ID}_ses-${COND:0:1}_task-rest_acq-${ACQ}_bold_smooth-5.ica
            
            if [[ ! -f ${clean}/filtered_func_data_clean.nii.gz ]]; then #this line checks if fix has been run at threshold 20 before; if the file does not exist, it will run fix
                echo echo Registering ${ID} ${COND} ${ACQ} ...
                
                fsl_sub  \
                applywarp \
                --in=${clean}/filtered_func_data_clean \
                --ref=$FSLDIR/data/standard/MNI152_T1_2mm_brain \
                --warp=${reg}/reg/example_func2standard_warp \
                --out=${clean}/filtered_func_data_clean_std
                
            else echo " Fix folder already exists for subject ${ID} session ${COND} acquisition ${ACQ} ------------------";
            fi
            
        done
    done
done

# started at 14:31 14:42
