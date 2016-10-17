#read SAS files
require(sas7bdat)
## Loading required package: sas7bdat
setwd("/mnt/Projects/SMART_P/Datasets/2016September")
aya <- read.sas7bdat(file = "ayameas_07oct16.sas7bdat", debug = FALSE)
aya[aya == ""] <- NA


#read xls or xlsx
install.packages("readxl")
library("readxl")

datain <- read_excel("I:/Projects/TREAT/Data Management/Reports/Enrollment Reports/data/Demographics_002.xlsx")
