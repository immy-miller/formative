library(tidyverse)
library(haven)

DEMO_D <- read_xpt('./data/original/DEMO_D.XPT') #read in xpt

#create tibble

demo_d_tb <- tibble(
  seqn = DEMO_D$SEQN,
  gender = DEMO_D$RIAGENDR,
  age = DEMO_D$RIDAGEYR,
  ethnicity = DEMO_D$RIDRETH1
)

BMX_D.csv <- read_csv('./data/original/BMX_D.csv')

demo_d_tb <- demo_d_tb |> 
  janitor::clean_names()

BMX_D.csv <- BMX_D.csv |> 
  janitor::clean_names()


bmx_demo <- left_join(BMX_D.csv, demo_d_tb, by = 'seqn')

bmx_demo <- bmx_demo |> 
  relocate(c(gender, age, ethnicity), .after = seqn)

in_sample <- read_csv('./data/derived/sample.csv')
in_sample <- in_sample |> 
  janitor::clean_names()

bm_demo <- left_join(bmx_demo, in_sample, by = 'seqn')

bm_demo <- bm_demo |> 
  rename(in_sample = insample) |> 
  relocate(in_sample, .after = seqn)

bm_demo <- bm_demo |> 
  mutate(
    obesity = ifelse(bmxbmi >= 30, 1, 0))

nrow(bm_demo |> 
  filter(obesity == 0))
nrow(bm_demo |> 
      filter(in_sample == 0) )
