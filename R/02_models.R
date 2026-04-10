library(readr)
library(dplyr)
library(broom)

dat <- read_csv("data_derived/analysis_dataset.csv")

fit_crude <- glm(
  child_obesity ~ gdm,
  data = dat,
  family = binomial()
)

fit_adj <- glm(
  child_obesity ~ gdm + maternal_age + prepreg_bmi + parity + child_sex,
  data = dat,
  family = binomial()
)

res_crude <- tidy(fit_crude, exponentiate = TRUE, conf.int = TRUE)
res_adj   <- tidy(fit_adj, exponentiate = TRUE, conf.int = TRUE)

write_csv(res_crude, "output/tables/model_crude.csv")
write_csv(res_adj, "output/tables/model_adj.csv")
