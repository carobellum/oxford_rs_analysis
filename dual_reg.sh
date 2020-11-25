#/bin/bash
# ------------------------------------------------------------------------------
# Script name:  dual_reg.sh
#
# Description:  Script to run dual regression after group melodic
#
# Author:       Caroline Nettekoven, 2020
#
# ------------------------------------------------------------------------------
# Options
nsub=17
dim=25
# ------------------------------------------------------------------------------
# Pathways:
#BIDSderiv = folder where the data is
BIDSraw=/vols/Data/ping/caro/cerebmrsi/raw
BIDSderiv=/vols/Data/ping/caro/cerebmrsi/derivatives
#Path to design files
matfile=/vols/Data/ping/caro/cerebmrsi/bin/designs/dr_sub${n_sub}.mat
confile=/vols/Data/ping/caro/cerebmrsi/bin/designs/dr_sub${n_sub}.con
# Path to input
mel_local=/Users/CN/Documents/Projects/Joystick_Cereb_MRS/derivatives/gica/sub${n_sub}/dim${dim}_s5/ # toggle with mel_cluster, depending on where you're working (cluster or local)
# mel_cluster=/vols/Data/ping/caro/cerebmrsi/derivatives/gica/sub${n_sub}/dim${dim}_s5
groupICA=${BIDSderiv}/gica/sub${n_sub}/dim${dim}_s5
inputfiles=/vols/Data/ping/caro/cerebmrsi/bin/input_gica_s5_sub${n_sub}.txt

# Path to output folder
outfolder=${BIDSderiv}/dr/sub${n_sub}/dim${dim}_s5



fsl_sub -m abe dual_regression ${groupICA}/melodic_IC 1 $matfile $confile 1 ${outfolder} `cat $inputfiles`


