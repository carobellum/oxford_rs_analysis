#!/bin/bash
# ------------------------------------------------------------------------------
# Script name:  design_ss_rest_melodic.sh
#
# Description:  Script to write design file for single session melodic ica
#
# Author:       Caroline Nettekoven, 2020
#
# ------------------------------------------------------------------------------

# definitions
workDir=/vols/Data/ping/caro/cerebmrsi/bin/designs/ss_designs

# specify the subjects
subjList="sub-01 sub-02  sub-03  sub-04  sub-05  sub-06  sub-07  sub-08  sub-09  sub-10  sub-11  sub-12  sub-13  sub-14  sub-15 sub-16 sub-17"
# subjList="sub-01"

condList="adapt control"


for id in ${subjList} ; do

    for cond in ${condList} ; do

      echo "preparing design file for subject ${id} session ${cond} ---------------"

      # prepare the .fsf file based on the template
      cp $workDir/ss_template.fsf $workDir/${id}_ses-${cond:0:1}.fsf
      sed -i "s/XXX/"${id}"/g" $workDir/${id}_ses-${cond:0:1}.fsf
      sed -i "s/YYY/ses-"${cond}"/g" $workDir/${id}_ses-${cond:0:1}.fsf
      sed -i "s/ZZZ/ses-"${cond:0:1}"/g" $workDir/${id}_ses-${cond:0:1}.fsf

      # run the .fsf design in feat
     # feat $workDir/${id}_ses-${cond:0:1}.fsf

      echo " "

  done

done


# If you want to use MELODIC and not FEAT, you need to pull up each GUI and load the .fsf file
# sub-01_ses-a.fsf
