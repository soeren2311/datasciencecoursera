rm(list=ls())

library(data.table)
library(xlsx)
library(XML)
library(curl)

## Data science - John Hopkins Unversity 
## Getting and Cleaning Data Quiz 1 (JHU) Coursera

## creating a path to my working directory
pfad <- "/Users/sorennonnengart/Coursera/Data_science/Datensätze/c3_week1"

getwd()
## set the path
setwd(pfad)
getwd()

## Question 1)

#read the dataset
df <- data.table::fread("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv")
# VAL == 24 means more than $1,000,000 --> 53
df[VAL == 24, .N]

## Or do the alternative way of loading the data
df <- read.csv("getdata_data_ss06hid.csv", na="NA", sep=",")
## How many properties are worth $1,000,000 or more? --> 53
sum(df$VAL >= 24, na.rm=TRUE) 


## Question 3)

## I now use the Excel-spreadsheet on Natural Gas Aquisition
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile = paste0(getwd(), '/getdata%2Fdata%2FDATA.gov_NGAP.xlsx'), method = "curl")
## load a subset of the excel-dataset, call it dat and use the sum-function
dat <- xlsx::read.xlsx(file = "getdata%2Fdata%2FDATA.gov_NGAP.xlsx", sheetIndex = 1, rowIndex = 18:23, colIndex = 7:15)
sum(dat$Zip*dat$Ext,na.rm=T)


## Question 4)

## I first read the XML data on Baltimore restaurants from here:
## How many restaurants have zipcode 21231? 
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- XML::xmlTreeParse(sub("s", "", fileURL), useInternal = TRUE)
rootNode <- XML::xmlRoot(doc)

zipcodes <- XML::xpathSApply(rootNode, "//zipcode", XML::xmlValue)
xmlZipcodeDT <- data.table::data.table(zipcode = zipcodes)
xmlZipcodeDT[zipcode == "21231", .N]


## Question 5)
DT <- data.table::fread("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv")

# broken down by sex. Using the data.table package, which will deliver the fastest user time?

## tapply(DT$pwgtp15,DT$SEX,mean)
counter <- 0
name <- "tapply(DT$pwgtp15, DT$SEX, mean)"
for (i in 1:100)
{
  t1 <- Sys.time()  
  tapply(DT$pwgtp15, DT$SEX, mean)
  t2 <- Sys.time()
  time <- t2 - t1
  counter <- counter + time
}
cat("The counter is: ", counter, "My name is: ", name, "\n")
## usertime: 0.09075189, 0.08379436, 0.09181309


## DT[,mean(pwgtp15), by=SEX]
counter <- 0
name <- "DT[,mean(pwgtp15), by=SEX]"
for (i in 1:100)
{
  t1 <- Sys.time()  
  DT[,mean(pwgtp15), by=SEX]
  t2 <- Sys.time()
  time <- t2-t1
  counter <- counter + time
}
cat("The counter is: ", counter, "My name is: ", name, "\n")
## Usertime: 0.1215916, 0.1197314, 0.2010942...


## mean(DT[DT$SEX==1,]$pwgtp15);mean(DT[DT$SEX==2,]$pwgtp15)
counter <- 0
name <- "mean(DT[DT$SEX==1,]$pwgtp15);mean(DT[DT$SEX==2,]$pwgtp15)"
for (i in 1:100)
{
  t1 <- Sys.time()  
  mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
  t2 <- Sys.time()
  time <- t2 - t1
  counter <- counter + time
}
cat("The counter is: ", counter, "My name is: ", name, "\n")

## usertim: 1.091544, 0.9809418, 0.8358488...


counter<- 0
name <- "sapply(split(DT$pwgtp15,DT$SEX),mean)"
for (i in 1:100)
{
  t1 <- Sys.time()  
  sapply(split(DT$pwgtp15,DT$SEX),mean)
  t2 <-Sys.time()
  time <- t2 - t1
  counter <- counter + time
}
cat("The counter is: ", counter, "My Name is: ", name, "\n")
## usertime: 0.06551576, 0.06629753, 0.06878972...


counter <- 0
name <- "mean(DT$pwgtp15, by=DT$SEX)"
for (i in 1:100)
{
  t1 <- Sys.time()  
  mean(DT$pwgtp15, by=DT$SEX)
  t2 <- Sys.time()
  time <- t2 - t1
  counter <- counter + time
}
cat("The counter is: ", counter, "My name is: ", name, "\n")
## usertime: 0.00292182, 0.003079891, 0.003038645...




