# Frequent Canadian Drug Shortages 

This is a short R script that computes the number of actual drug shortages by
[ATC code](https://www.whocc.no/atc_ddd_index/). See `analysis.R` for more details.

## Installation
You will need the following R libraries: 

 - `tidyverse` (specifically the `readr`, `dplyr`, and `lubridate` packages)
 
 - [`rdrugshortages`](https://github.com/pipitone/rdrugshortages)
 
 `rdrugshortages` is a personal project to make accessing the Drug Shortages
 Canada database easy. You can install this via
 `devtools:install_github('pipitone/rdrugshortages')`.

## Running 
Simply source the `analysis.R` script while in the project directory. It will
load the data and produce an output CVS file.

## Method

The R script has inline comments which you can refer to for more details.

Here are the steps in my analysis: 

1. From the Health Canada Drug Product Database (DPD), I get a list of each DIN
   and the associated ATC code, ATC description, and brand name. This is
   necessary because the data provided by the Drug Shortages Canada (DSC)
   database is often messy when it comes to ancillary details like these. 

1. Merge the DPD data into the Drug Shortages Canada dataset by Drug
   Identification Number (DIN. 

1. Filter shortage reports so that we only include actual and resolved shortage
   reports that had a start date within our study period (Jan 2018 - Jan 2020). 

1. Group the shortage reports by [ATC code](https://www.whocc.no/atc_ddd_index/)
   AND route of administration. Tally the number of shortages in each group. 

1. Sort the groups by number of shortages, and calculate the cumulative number
   and percent of total shortages. 

## Datasets included with this project
The following datasets are included in this repository: 

- An extract of the **Health Canada Drug Product Database** which is available at: 
https://www.canada.ca/en/health-canada/services/drugs-health-products/drug-products/drug-product-database/what-data-extract-drug-product-database.html

- An extract of the **Drug Shortages Canada** database, available at: https://drugshortagescanada.ca

## Contact

For more information, contact me: jon@pipitone.ca, or file an issue. 
