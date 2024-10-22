library(tidyverse)
library(haven)

DEMO_D <- read_xpt('./data/original/DEMO_D.XPT') #read in xpt

#create tibble ontaining participant ID , gender, age and ethnicity

demo_d_tb <- tibble(
  seqn = DEMO_D$SEQN,
  gender = DEMO_D$RIAGENDR,
  age = DEMO_D$RIDAGEYR,
  ethnicity = DEMO_D$RIDRETH1
)

#read in BMX_D.csv data and clean names
BMX_D.csv <- read_csv('./data/original/BMX_D.csv')

BMX_D.csv <- BMX_D.csv |> 
  janitor::clean_names()

#merge the data and reformat
bmx_demo <- left_join(BMX_D.csv, demo_d_tb, by = 'seqn')

bmx_demo <- bmx_demo |> 
  relocate(c(gender, age, ethnicity), .after = seqn)

#read in in sample data
in_sample <- read_csv('./data/derived/sample.csv')
in_sample <- in_sample |> 
  janitor::clean_names()

#merge in sample data and reformat
bm_demo <- left_join(bmx_demo, in_sample, by = 'seqn')

bm_demo <- bm_demo |> 
  rename(in_sample = insample) |> 
  relocate(in_sample, .after = seqn)

#create obesity variable
bm_demo <- bm_demo |> 
  mutate(
    obesity = ifelse(bmxbmi >= 30, 1, 0))

#summarise the data
bm_demo |> 
  group_by(obesity) |> 
  summarise(mean(in_sample))
bm_demo |> 
  group_by(gender) |> 
  summarise(mean(in_sample))
bm_demo |> 
  group_by(age > (16*12)) |> 
  summarise(max(bmxht, na.rm=TRUE))
