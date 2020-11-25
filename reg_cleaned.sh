#/bin/bash
# ------------------------------------------------------------------------------
# Script name:  reg_cleaned.sh
#
# Description:  Script to smooth and register fix-cleaned data to standard space
#
# Author:       Caroline Nettekoven, 2020
#
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# Convert smoothing kernel from FWHM to sigma with formula Sigma = FWHM / 2.35482004503

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
            
            
            
            clean=${BIDSraw}/${ID}/ses-${COND}/func/${ID}_ses-${COND:0:1}_task-rest_acq-${ACQ}_bold_no_smooth.ica
            reg=${BIDSraw}/${ID}/ses-${COND}/func/${ID}_ses-${COND:0:1}_task-rest_acq-${ACQ}_bold_smooth-5.ica
            
            if [[ -f ${clean}/filtered_func_data_clean.nii.gz ]] && [[ ! -f ${clean}/${clean}/filtered_func_data_clean_smooth5.nii.gz ]]; then #this line checks if fix has been run at threshold 20 before; if the file does not exist, it will run fix
                
                echo Smoothing ${ID} ${COND} ${ACQ} ...
                
                fslmaths ${clean}/filtered_func_data_clean -s 2.1233 ${clean}/filtered_func_data_clean_smooth5
                
                
                echo Registering ${ID} ${COND} ${ACQ} ...
                
                fsl_sub  \
                applywarp \
                --in=${clean}/filtered_func_data_clean_smooth5 \
                --ref=$FSLDIR/data/standard/MNI152_T1_2mm_brain \
                --warp=${reg}/reg/example_func2standard_warp \
                --out=${clean}/filtered_func_data_clean_smooth5_std
                
            else echo "Fix has not yet finished OR data has already been registered. Moving on to next scan. ------------------";
            fi
            
        done
    done
done
