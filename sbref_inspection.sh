#!/bin/bash
# ------------------------------------------------------------------------------
# Script name:  sbref_processing.sh
#
# Description:  Script to inspect processed Sbref
#
# Author:       Caroline Nettekoven, 2020
#
# ------------------------------------------------------------------------------
# Pathways:
#BIDSraw = folder where the raw fieldmaps are
#BIDSderiv = folder where the processed fieldmaps need to be sent to

BIDSraw=/vols/Data/ping/caro/cerebmrsi/raw
BIDSderiv=/vols/Data/ping/caro/cerebmrsi/derivatives

#number of subjects = folder names in BIDS
subjList="sub-01 sub-02  sub-03  sub-04  sub-05  sub-06  sub-07  sub-08  sub-09  sub-10  sub-11  sub-12  sub-13  sub-14  sub-15 sub-16 sub-17"
# subjList="sub-01"

condList="adapt control"

acqList="1 2"




for ID in ${subjList} ; do

    for COND in ${condList} ; do

        for ACQ in ${acqList} ; do

            echo "------ Checking SBREF for subject ${ID} session ${COND} acq ${ACQ} ----------------------"

            #variable for sbref
            SBREFderiv=$BIDSderiv/${ID}/ses-${COND}/func/${ID}_ses-${COND:0:1}_task-rest_acq-${ACQ}_sbref.nii.gz
            #variable for sbref processed directory
            SBREFdir=$BIDSderiv/${ID}/ses-${COND}/func/rest_sbref_acq-${ACQ}

            fsleyes $SBREFderiv -cm greyscale ${SBREFdir}.anat/T2_biascorr.nii.gz -cm greyscale ${SBREFdir}.anat/T2_biascorr_brain.nii.gz -cm blue-lightblue &
        done

    done

    echo "subject ${ID} checked "

done
