library(lubridate)
library(dplyr)
library(readr)
library(rdrugshortages) # devtools::install_github("pipitone/rdrugshortages")

# set to TRUE to download fresh copies of the Drug Shortages Canada Database and the
# Health Canada Drug Product Databse
if (F) {
  rdrugshortages::dsc_search() %>%
      select_if(~ !is.list(.x)) %>%
      write_csv('data/dsc.csv')
  
  rdrugshortages::dpd_load(data_dir="data/", download=T)
}

# Load the Drug Shortages Canada database (DSC)
dsc.orig = read_csv('data/dsc.csv')

# Load the Health Canada Drug Product database
dpd = rdrugshortages::dpd_load(data_dir="data/", download=F)

# Time period over which to consider shortages
time_period = interval(ymd('2018-01-01'), ymd('2020-01-01'))

# Merge the drug shortages with the Drug Product Database by DIN
# We do this because the Drug Shortages Canada database often has messy data in
# many of the drug product fields (e.g. it can have repeated values, such as
# "ORAL ORAL" under drug_route, or extra characters which makes aggregating
# difficult.)
#
dsc = dpd$drug %>%
  inner_join(dpd$ther, by="DRUG_CODE") %>% 
  inner_join(dpd$route, by="DRUG_CODE") %>%
  select(din = DRUG_IDENTIFICATION_NUMBER, 
         dpd_atc_num = TC_ATC_NUMBER, 
         dpd_atc_descr = TC_ATC, 
         dpd_route = ROUTE_OF_ADMINISTRATION, 
         dpd_brand_name = BRAND_NAME) %>% 
  distinct(din, .keep_all = TRUE) %>%
  right_join(dsc.orig, by=c("din"))

# Group all shortages that have started in the study time period
# by ATC code AND route of administration.
#
# We also compute the number of shortages of each ATC. 
shortages = dsc %>% 
  filter(type.label == 'shortage', 
         status %in% c("resolved", "active_confirmed"), 
         actual_start_date %within% time_period) %>%
  group_by(dpd_atc_num, dpd_route) %>%
  summarise(atc_description = paste0(unique(dpd_atc_descr), collapse = ", "), 
            brand_names = paste0(unique(dpd_brand_name), collapse=", "), 
            num_shortages = n()) %>%
  ungroup() %>%
  arrange(desc(num_shortages)) %>%
  mutate(cumulative_num_shortages = cumsum(num_shortages), 
         cumulative_percent_total = round(cumulative_num_shortages / sum(num_shortages)*100,1))
write_csv(shortages, "shortages_by_atc_and_route.csv")
