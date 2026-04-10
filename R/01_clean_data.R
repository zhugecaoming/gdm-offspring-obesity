library(readr)
library(dplyr)

dat <- read_csv("data_raw/gdm_cohort.csv")

dat2 <- dat %>%
  filter(!is.na(gdm), !is.na(child_bmi_z)) %>%
  mutate(
    gdm = as.integer(gdm),
    child_obesity = if_else(child_bmi_z >= 1.645, 1L, 0L),
    maternal_age_grp = case_when(
      maternal_age < 25 ~ "<25",
      maternal_age < 35 ~ "25-34",
      TRUE ~ ">=35"
    ),
    prepreg_bmi_grp = case_when(
      prepreg_bmi < 18.5 ~ "Underweight",
      prepreg_bmi < 24 ~ "Normal",
      prepreg_bmi < 28 ~ "Overweight",
      TRUE ~ "Obesity"
    )
  )

write_csv(dat2, "data_derived/analysis_dataset.csv")