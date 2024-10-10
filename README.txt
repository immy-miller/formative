#  README file including instructions to create and activate conda environment

	# creating environment

# check conda downloaded
conda --version

# setting source for packages 
conda config --add channels conda-forge
conda config --set channel_priority strict

# activate conda
conda activate

# create new environment called formative
conda create -n  formative

# activate formative environment 
conda activate formative

# install necesary packages
conda install r-base=4.4.1
conda install r-tidyverse=2.0.0

# check packages installed correctly
conda list

	# sharing environment set up

# set up environment that only includes the packages explicitly installed 
conda export --from-history > formative.yml
