#different packages to import data with

#read SAS files
require(sas7bdat)
## Loading required package: sas7bdat
setwd("/mnt/Projects/SMART_P/Datasets/2016September")
aya <- read.sas7bdat(file = "ayameas_07oct16.sas7bdat", debug = FALSE)
aya[aya == ""] <- NA


#read xls or xlsx
#install.packages("readxl")
#this version of readxl reads 1000 rows ahead to guess data types instead of 100 rows ahead in Hadley's cran package
devtools::install_github("bhive01/readxl")
library("readxl")

datain <- read_excel("I:/Projects/TREAT/Data Management/Reports/Enrollment Reports/data/Demographics_002.xlsx")
