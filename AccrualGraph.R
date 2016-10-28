# Create accrual vs. expected graph 
# Author: Andrew Borst
# Created: 02/10/2016
# Last Updated: 10/26/2016 

# 1) Create function to graph expected vs actual accrualGraph
# 2) Import data
# 3) Call function

accrualGraph = function(ondate, startdate, enddate=Sys.Date(), expmnth) {
  #install pacakges (if not installed) and load
  packages <- c("ggplot2", "scales")
  if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
    install.packages(setdiff(packages, rownames(installed.packages())))  
  }  
  require(ggplot2)
  require(scales)
  
  #Build monthly buckets of actual accrual
  mnths = seq(startdate, enddate, by="month")
  
  # create variables of the week and month of each observation:
  enroll <- data.frame(ondate)
  enroll$Month <- as.Date(cut(as.Date(enroll$ondate,format="%m/%d/%Y"),breaks = "month"))
  enroll$Count = 1
  
  #possible that a month would not have any enrollment, need to add months with no enrollment
  dmnth = as.Date(unique(enroll$Month))
  addmnth = mnths[!mnths %in% dmnth]
  enroll2 = enroll
  enroll2[(nrow(enroll)+1):(nrow(enroll)+length(addmnth)),"Month"] = addmnth
  enroll2[(nrow(enroll)+1):(nrow(enroll)+length(addmnth)),"Count"] = 0
  
  # sum by month and assign total for each month into Accrual vector, since month buckets
  # are summed into beginning of first month, need to move sums one month over for end-of-month
  msum = c(0,cumsum(as.vector(unlist(tapply(enroll2$Count,enroll2$Month,sum)))))
  
  mnths = append(mnths, enddate)
  acc = data.frame(mnths,msum)
  acc$accgrp="Actual"
  
  #append expected month sequence into graph data if it was passed to function
  if(!is.null(expmnth)){
    expdf = data.frame(mnths,msum=seq(from=0,to=(4.5*(nrow(acc)-1)),by=4.5),accgrp="Expected")
    acc = rbind(acc, expdf)
  }
  
  # graph by month:
  ggplot(data = acc, aes(mnths, msum,group=accgrp,colour=accgrp)) +
    geom_line(aes(linetype=accgrp)) +
    geom_point()  +
    xlab("Months") + ylab("Accrual")
    scale_fill_hue(name="Legend")  +
    theme_bw() +
    theme(legend.position=c(.9, .2))  
}

demog <- read.delim("~/R/Data/Demographics.txt")
#Code as function with arguments (on study dates, start date, end date, 
#  optional expected n per month )

ondate = as.Date(demog$ON_STUDY_DATE, format="%m/%d/%Y")
accrualGraph(ondate,startdate=as.Date("2013-06-01"),expmnth=4.5)

