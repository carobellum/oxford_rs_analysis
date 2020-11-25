# oxford_rs_analysis
#### Code to conduct network analysis on resting-state fMRI data written as part of my DPhil studies in Oxford 2016-2020



## Usage
1. Start by looking through the analyse_rs.sh script.
   
   - This script lists all necessary steps for pre-processing the resting-state data (betting, registration, cleaning, etc.) and conducting statistical analysis on the derived networks with randomise.
   - However, depending on the requirements of your data and the recommendations for your sequence parameters, some scripts will likely need some tweaking.
  
2. Work your way through the steps in analyse_rs.sh by tweaking the parameters and checking your output as you go along.
   
   - For each step, there are scripts provided with which you can check your processed output.
   - Adjust the visualisation parameters according to the requirements of your data (e.g. the fsleyes display range flag -dr is ideally set to 0 300 for the T1-weighted images and 0 3000 for T2*-weighted images in my dataset).
  
3. There are additional scripts with which you can analyse resting-state networks further, for example to relate network strength to behavioural change or neurochemical data. These are not listed in the master script (analyse_rs.sh) script, so have a look through the repository.



> Note: Be careful with the -m flag when FIX-cleaning. In my experience this massively reduces cerebellar contribution to group networks, potentially because the hand-labelled FIX training data did not include cerebellar regions and therefore wrongly labels most of cerebellar components as noise. If you care about cerebellar signal (which you should of course :P), then take caution with using that flag. Try running FIX with and without the flag and compare the group-level components, especially in inferior areas. Also, turning off slice-timing correction seems to be an issue for FIX, even if the TR is very low (which is when some people recommend turning off slice timing corrections and just using temporal derivatives). Turning it off resulted in FIX not being able to detect multiband artefacts as noise and led to many multiband artefacts in the group-level components.

If any scripts seem to be missing or something goes wrong, have a look at the FSL mailing list (https://www.jiscmail.ac.uk/cgi-bin/webadmin?A0=fsl), the fsleyes documentation (https://users.fmrib.ox.ac.uk/~paulmc/fsleyes/userdoc/latest/), or feel free to email me.

Happy analysing!

![Beautiful cerebellar network](resting_state_icon.png)




