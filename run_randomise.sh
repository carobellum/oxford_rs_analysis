#------------------------------------------------------------------------------
# SETTINGS
#------------------------------------------------------------------------------
n_sub=17
dim=50
#------------------------------------------------------------------------------
permutations=5000
clusterthresh=2.3
thr=3
#------------------------------------------------------------------------------
# Set fixed parameters
mel=dim${dim}_s5
nets=networks_of_interest.txt
BIDSderiv=/vols/Data/ping/caro/cerebmrsi/derivatives
melpath=${BIDSderiv}/gica/sub${n_sub}/${mel}
data=${BIDSderiv}/dr/sub${n_sub}/${mel}/stacked
designfolder=${BIDSderiv}/../bin/designs/randomise_designs/

results=${BIDSderiv}/results/randomise${n_sub}_dim-${mel:3:2}_mask-${thr}_thr-${clusterthresh:0:1}${clusterthresh:2:2}_`date +%Y%m%d`

# #------------------------------------------------------------------------------
# # Create results
if [ -d "${results}" ]; then echo "Directory "${results}" exists."
else echo "Directory "${results}" does not exist. Created directory ${results}."; mkdir "${results}"
fi
# #------------------------------------------------------------------------------
# # Run randomise
#
# for n in `cat ${melpath}/${nets} | awk '{print $1}'`; do
for n in `cat ${melpath}/${nets} | awk '{print $1}'`; do
    n=${n%%,*}
    echo ${n}
    component=$(( ${n}-1 ))
    # maskimage=${melpath}/melodic_IC_c${component}_bin
    
    if [ "${maskimage}" == "MNI" ]; then
        maskimage=/opt/fmrib/fsl/data/standard/MNI152_T1_2mm_brain_mask.nii.gz
    else
        maskimage=${melpath}/groupmask_n${n}_thr${thr}
    fi
    
    ls ${data}/Data_network${n}_*.nii.gz ${maskimage}.nii.gz
    
    randomise \
    -i ${data}/Data_network${n}_diff.nii.gz \
    -o ${results}/PairedT_network${n}_diff \
    -d ${designfolder}/randomise${n_sub}.mat \
    -t ${designfolder}/randomise${n_sub}.con \
    -e ${designfolder}/randomise${n_sub}.grp \
    -m ${maskimage} \
    -n ${permutations} \
    -c ${clusterthresh} \
    -T \
    -x
    
    
    randomise \
    -i ${data}/Data_network${n}_acq-2.nii.gz \
    -o ${results}/PairedT_network${n}_post \
    -d ${designfolder}/randomise${n_sub}.mat \
    -t ${designfolder}/randomise${n_sub}.con \
    -e ${designfolder}/randomise${n_sub}.grp \
    -m ${maskimage} \
    -n ${permutations} \
    -c ${clusterthresh} \
    -T \
    -x
    
    
    randomise \
    -i ${data}/Data_network${n}_acq-1.nii.gz \
    -o ${results}/PairedT_network${n}_pre \
    -d ${designfolder}/randomise${n_sub}.mat \
    -t ${designfolder}/randomise${n_sub}.con \
    -e ${designfolder}/randomise${n_sub}.grp \
    -m ${maskimage} \
    -n ${permutations} \
    -c ${clusterthresh} \
    -T \
    -x
    
done
