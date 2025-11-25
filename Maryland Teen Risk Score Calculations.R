install.packages("writexl")
install.packages("scales")

library(dplyr)
library(readxl)
library(writexl)
library(ggplot2)

# Load Data --------------------------------------------------------------

df <- read.csv("maryland_teen_health.csv")

# Select indicators ------------------------------------------------------

indicators <- c(
  "teen_birth_rate",
  "poverty_rate",
  "hs_dropout_rate",
  "juvenile_arrests",
  "unemployment_rate"
)

# Z-score Standardization ------------------------------------------------

df <- df %>%
  mutate(across(
    all_of(indicators),
    ~ scale(.)[,1],
    .names = "{.col}_z"
  ))

# Composite Index --------------------------------------------------------

df <- df %>%
  rowwise() %>%
  mutate(teen_risk_index = mean(c_across(ends_with("_z")), na.rm = TRUE)) %>%
  ungroup()

# Quintiles --------------------------------------------------------------

df <- df %>%
  mutate(quintile = ntile(teen_risk_index, 5))

# Export for ArcGIS ------------------------------------------------------

write.csv(df, "maryland_teen_health_index_export.csv", row.names = FALSE)
