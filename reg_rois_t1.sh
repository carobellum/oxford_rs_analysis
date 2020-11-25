#!/bin/bash
# ------------------------------------------------------------------------------
# Script name:  reg_rois_t1.sh
#
# Description:  Script to register standard space ROIs to native T1 space
#
# Author:       Caroline Nettekoven, 2020
#
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# Paths
BIDSraw=/vols/Data/ping/caro/cerebmrsi/raw
BIDSderiv=/vols/Data/ping/caro/cerebmrsi/derivatives
# ------------------------------------------------------------------------------
# Specify ROIs
roi_dir=${BIDSderiv}/rois/register_these/to_t1
ls ${roi_dir}/*_*.nii.gz > /vols/Data/ping/caro/cerebmrsi/bin/roi_list_to_t1.txt
roiList=/vols/Data/ping/caro/cerebmrsi/bin/roi_list_to_t1.txt
# ------------------------------------------------------------------------------


subjList="sub-01 sub-02  sub-03  sub-04  sub-05  sub-06  sub-07 sub-08  sub-09  sub-10  sub-11  sub-12  sub-13  sub-14  sub-15 sub-16 sub-17"
condList="adapt control"
for id in ${subjList}   ; do
    for cond in ${condList} ; do
        
        reg=${BIDSraw}/${id}/ses-${cond}/func/${id}_ses-${cond:0:1}_task-rest_acq-1_bold_smooth-5.ica/reg
        
        while read roi; do
            echo Registering ${roi##*/} for ${id} ${cond} ...
            fsl_sub applywarp \
            --in=${roi} \
            --ref=${reg}/highres \
            --warp=${reg}/standard2highres_warp \
            --out=${BIDSderiv}/${id}/ses-${cond}/anat/rois/${roi##*/} \
            --interp=nn
        done < ${roiList}
    done
done


