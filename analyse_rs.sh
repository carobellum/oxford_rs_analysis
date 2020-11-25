#/bin/bash
# ------------------------------------------------------------------------------
# Script name:  analyse_rs.sh
#
# Description:  Script to analyse resting-state fMRI data from 3T Cerebellar MRSI study
#
# Author:       Caroline Nettekoven, 2020
#
# ------------------------------------------------------------------------------
# Navigate to folder where code is located:
cd /Users/CN/Documents/Projects/Joystick_Cereb_MRS/Analysis/rs_code/
# T1 processing: already done for this dataset.
# Fmap processing: already done for this dataset
# Sbref processing
sbref_processing.sh
# Sbref inspection
sbref_inspection.sh

# Run single subject ICA without smoothing (for fix-cleaning)
generate_ss_design.sh
# Run single subject ICA with smoothing of 5 FWHM (for registration after fix-cleaning)
generate_ss_design_s5.sh

# Run fix
run_fix_mflag.sh

# Smoothing and registering
smooth_and_register_cleaned.sh

# Generate inputlist
generate_inputlist.sh
# Group melodic
melodic_commandline.sh


# Copy group components
copy_gicas.sh
# Inspect group components
inspect_gicas.sh
# Correlate components with RSN maps
crosscorr_gicas.sh
crosscorr_gicas_local.sh # correlates components with RSN maps locally
# Copy label files to cluster
copy_labelfiles.sh

# Dual regression
dual_reg.sh

# Generate datasets
stack_data.sh
# Generate group mask for networks
generate_groupmask.sh
# Run randomise (first need to generate design file and upload it)
run_randomise.sh
# Inspect results
inspect_results.sh








