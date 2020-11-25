#!/bin/bash
# --------------------------------------------------
# Script name:  crosscorr_melodic_local.sh
#
# Description:  Script to cross correlate group melodic ouputs with the networks from the PNAS 2009 paper
#
# Author:       Caroline Nettekoven, 2020
#
# ------------------------------------------------------------------------------
n_sub=17
thr=0.2
dim=25
# ------------------------------------------------------------------------------
BIDSderiv=/Users/CN/Documents/Projects/Joystick_Cereb_MRS/derivatives

mel_local=${BIDSderiv}/gica/sub${n_sub}/dim${dim}_s5 # Path to output folder

PNASmaps=/Users/CN/Documents/Projects/Joystick_Cereb_MRS/derivatives/rois/RS_masks_literature
fslcc -t ${thr} ${PNASmaps}/PNAS_Smith09_rsn10.nii.gz ${mel_local}/melodic_IC.nii.gz > ${mel_local}/labels_pnas_${dim}_s5.txt

HardwickMaps=/Users/CN/Documents/Projects/Joystick_Cereb_MRS/derivatives/rois/hardw_stacked.nii.gz
fslcc -t ${thr} ${HardwickMaps} ${mel_local}/melodic_IC.nii.gz > ${mel_local}/labels_hardw_${dim}_s5.txt


