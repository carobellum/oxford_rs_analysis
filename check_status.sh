#!/bin/bash
# ------------------------------------------------------------------------------
# Script name:  run_process_after_qstat.sh
#
# Description:  Script to run several processes consecutively overnight,
#               without the need to manually start after preceding process
#               has finished.
#
# Author:       Caroline Nettekoven, 2020
#
# ------------------------------------------------------------------------------
# Pathways:
BIDSraw=/vols/Data/ping/caro/cerebmrsi/raw
BIDSderiv=/vols/Data/ping/caro/cerebmrsi/derivatives
fix_dir=/home/fs0/edmond/scratch/bin/fix/fix/fix
fix_training_data=/home/fs0/edmond/scratch/bin/fix/fix/training_files/UKBiobank.RData
ID="sub-12"
COND="adapt"
acqList="1 2"
# --------------------------- Check if job finihed -----------------------------
job_running=1
while [[ ! ${job_running} == 0 ]]; do
    job_running=`qstat | wc | awk '{print $1}'`
    echo .
    sleep 1200
done
echo Jobs have finished.
