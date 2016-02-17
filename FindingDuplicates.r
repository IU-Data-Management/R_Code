# Example on how to find duplicates
# Commented by RyanCook 2.17.2016
#  Vector a
a <- c(1, 1, 2, 3, 4, 5, 5, 6, 6, 7, 8, 9)
a

#  Find duplicates
d<-duplicated(a)
d

#  Index of first duplicate
anyDuplicated(a)

#  Flag duplcates
c <- 1:length(a)
for(i in 1:length(a)){
if (d[i] == "FALSE"){c[i] = 0}
else if (d[i] == "TRUE"){c[i] = 1}
}
c

#  Create a dataframe of vector, duplicate indicator, flagged values
dat <- data.frame(a, d, c)
dat

#  Pick out the duplicates
duplicates <- dat[dat$c == 1,]
duplicates
