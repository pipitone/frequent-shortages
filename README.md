# Frequent Canadian Drug Shortages 

This is a short R script that computes the number of actual drug shortages by
ATC code. See `analysis.R` for more details.

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

## Datasets included with this project
The following datasets are included in this repository: 

- An extract of the **Health Canada Drug Product Database** which is available at: 
https://www.canada.ca/en/health-canada/services/drugs-health-products/drug-products/drug-product-database/what-data-extract-drug-product-database.html

- An extract of the **Drug Shortages Canada** database, available at: https://drugshortagescanada.ca

## Contact

For more information, contact me: jon@pipitone.ca, or file an issue. 