* Run this file from the folder that contains 1-CS-data-CSV.csv
* (or set the folder with: cd "path/to/your/folder")
log using "Proj.smcl", replace
 
import delimited "1-CS-data-CSV.csv", delimiter(";") varnames(1) 

sum sprben_matlab levrage1 profitability sprat_numeric effsale maturity_years

summarize sprben_matlab levrage1 profitability sprat_numeric effsale maturity_years
histogram sprben_matlab, percent normal title("Distribution of Credit Spread")
twoway (scatter sprben_matlab levrage1)(lfit sprben_matlab levrage1),title("Credit Spread and Leverage")
twoway (scatter sprben_matlab sprat_numeric)(lfit sprben_matlab sprat_numeric), title("Credit Spread and Credit Rating")
twoway (scatter sprben_matlab profitability)(lfit sprben_matlab profitability),title("Credit Spread and Profitability")

pwcorr sprben_matlab levrage1 profitability sprat_numeric effsale maturity_years, sig

reg sprben_matlab levrage1 profitability sprat_numeric effsale maturity_years

vif

estat hettest

reg sprben_matlab levrage1 profitability sprat_numeric effsale maturity_years, robust
reg sprben_matlab levrage2 profitability sprat_numeric effsale maturity_years
reg sprben_matlab levrage1 profitability sprat_numeric effsale maturity_years ln_ta_usd
reg sprben_matlab levrage1 profitability sprat_numeric effsale maturity_years civil
reg sprben_matlab levrage1 profitability sprat_numeric effsale maturity_years callable
encode ultprnat, gen(country_id)
reg sprben_matlab levrage1 profitability sprat_numeric effsale maturity_years, vce(cluster country_id)
reg sprben_matlab levrage1 profitability sprat_numeric effsale maturity_years i.country_id, robust

log close
