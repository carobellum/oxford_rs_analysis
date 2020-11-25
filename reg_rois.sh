#/bin/bash
# ------------------------------------------------------------------------------
# Script name:  reg_rois.sh
#
# Description:  Script to register standard space ROIs to native epi space
#
# Author:       Caroline Nettekoven, 2020
#
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

# Dependencies
BIDSraw=/vols/Data/ping/caro/cerebmrsi/raw
BIDSderiv=/vols/Data/ping/caro/cerebmrsi/derivatives
roi_dir=${BIDSderiv}/rois/register_these
ls ${roi_dir}/*_*.nii.gz > /vols/Data/ping/caro/cerebmrsi/bin/roi_list.txt
roiList=/vols/Data/ping/caro/cerebmrsi/bin/roi_list.txt
subjList="sub-01 sub-02  sub-03  sub-04  sub-05  sub-06  sub-07  sub-08  sub-09  sub-10  sub-11  sub-12  sub-13  sub-14  sub-15 sub-16 sub-17"
condList="adapt control"
acqList="1 2"
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

for id in ${subjList}   ; do
    for cond in ${condList} ; do
        for acq in ${acqList}   ; do
            reg=${BIDSraw}/${id}/ses-${cond}/func/${id}_ses-${cond:0:1}_task-rest_acq-${acq}_bold_smooth-5.ica/reg
            # fsl_sub invwarp -w ${reg}/example_func2standard_warp -o ${reg}/standard2example_func_warp -r ${reg}/standard
            while read roi; do
                echo Registering ${roi##*/} for ${id} ${cond} ${acq} ...
                fsl_sub applywarp \
                --in=${roi} \
                --ref=${reg}/example_func \
                --warp=${reg}/standard2example_func_warp \
                --out=${reg}/../roi/${roi##*/} \
                --interp=nn
            done < ${roiList}
        done
    done
done

# Check if file have correct dates
# ls -l ${BIDSraw}/*/ses-*/func/*_task-rest_acq-*_bold_smooth-5.ica/roi/*.nii.gz  | awk '{print $7}' | grep "30"
# ls -l /Users/CN/Documents/Projects/Joystick_Cereb_MRS/raw/*/ses-*/func/*_ses-c_task-rest_acq-?_bold_smooth-5.ica/roi/ | awk '{print $6}' | grep "30"

# Check if correct amount of files (should be a multiple of 34)
# ls -l /Users/CN/Documents/Projects/Joystick_Cereb_MRS/raw/*/ses-*/func/*_ses-c_task-rest_acq-?_bold_smooth-5.ica/roi/*.nii.gz | wc