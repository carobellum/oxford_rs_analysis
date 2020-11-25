#!/bin/bash
# --------------------------------------------------
# Script name:  crosscorr_melodic.sh
#
# Description:  Script to cross correlate group melodic ouputs with the networks from the PNAS 2009 paper
#
# Author:       Caroline Nettekoven, 2020
#
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
n_sub=15
dim=10
# ------------------------------------------------------------------------------
# for dim in 15; do

# Dependencies
nets=networks_of_interest.txt
BIDSderiv=/vols/Data/ping/caro/cerebmrsi/derivatives
echo  ----- Dim ${dim} -- Sub ${n_sub} -----
mel=sub${n_sub}/dim${dim}_s5
# Get paths from mel
melpath=${BIDSderiv}/gica/${mel}
drfolder=${BIDSderiv}/dr/sub${n_sub}/dim${dim}_s5
inputs=/vols/Data/ping/caro/cerebmrsi/bin/input_gica_s5_sub${n_sub}.txt
mkdir ${drfolder}/stacked
for n in `cat ${melpath}/${nets} | awk '{print $1}'`; do
    n=${n%%,*}
    echo ${n}
    component_no=$(( ${n}-1 ))
    component_no=`printf %04d ${component_no}`
    ls ${drfolder}/dr_stage2_ic${component_no}.nii.gz

    # Make a copy of the network of interest dataset
    copy_job=`fsl_sub \
        scp ${drfolder}/dr_stage2_ic${component_no}.nii.gz \
        ${drfolder}/stacked/Data_ic${component_no}.nii.gz`

    # For each component:
    # Generate a pre dataset
    # Generate a post dataset
    # Generate a diff dataset
    for ACQ in 1 2; do
        scans=`cat ${inputs} | grep -n "acq-${ACQ}" | sed 's/:.*//' `
        echo  "Extracting scans (acq-${ACQ}) for network ${n} in gica ${dim}:"
        for s in ${scans}; do
            s_minus_1="$((${s} - 1))" # fslroi indexing counts from 0, so subctract 1 from index s
            s_zeropadded=`zeropad ${s} 4`
            # Extract the individual sessions from the timewise concatenated component file
            roi_job=`fsl_sub -j ${copy_job} fslroi ${drfolder}/stacked/Data_ic${component_no}.nii.gz \
            ${drfolder}/stacked/Data_ic${component_no}_"acq-${ACQ}"_scan${s_zeropadded}.nii.gz \
            ${s_minus_1} 1`
            echo ${s}
        done
        # Merge all the sessions that are either pre (acq-1) or post (acq-2)
        merge_job=`fsl_sub -j ${roi_job} fslmerge -t ${drfolder}/stacked/Data_network${n}_"acq-${ACQ}".nii.gz \
        ${drfolder}/stacked/Data_ic${component_no}_"acq-${ACQ}"_scan*.nii.gz`
    done

    # Subtract the pre dataset from the post dataset to get the diff dataset
    fsl_sub -j ${merge_job} -m abe fslmaths ${drfolder}/stacked//Data_network${n}_acq-2.nii.gz \
    -sub ${drfolder}/stacked/Data_network${n}_acq-1.nii.gz \
    ${drfolder}/stacked/Data_network${n}_diff
done

# Generate a list of every subject that was used to run the melodic and dual_regressions
subjects=${inputs%*.txt}_subjectlist.txt
cat ${inputs} | grep -o "sub.*" | awk -F/ '{print $1}' | uniq > ${subjects}
# done
