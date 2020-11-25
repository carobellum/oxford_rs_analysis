#!/bin/bash
# ------------------------------------------------------------------------------
# Script name:  generate_inputlist.sh
#
# Description:  Creates the list of ss data files for group melodic
#
# Author:       Caroline Nettekoven, 2020
#
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# Options
smooth=5
# ------------------------------------------------------------------------------
BIDSraw=/vols/Data/ping/caro/cerebmrsi/raw

ls ${BIDSraw}/sub-*/ses-*/func/sub-*_ses-?_task-rest_acq-?_bold_no_smooth.ica/filtered_func_data_clean_smooth${smooth}_std.nii.gz \
    > /vols/Data/ping/caro/cerebmrsi/bin/input_gica_s${smooth}.txt # Path to textfile that litst paths to data
