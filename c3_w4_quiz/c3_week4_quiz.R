###### Course_3_week4 - Quiz - Sören Nonnengart

rm(list=ls()) 

path <- "/Users/sorennonnengart/Coursera/Data_science/tasks/course_3_Data_cleaning/week4_quiz"
setwd(path)
getwd()

# does the data exists?
if (!file.exists("quiz")) {
  dir.create("quiz")
}

## Question 1 Apply strsplit() to split all the names of the data frame on the characters "wgtp". 
## What is the value of the 123 element of the resulting list?

# download data and save as Q1
urlfile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(urlfile, destfile = "./quiz/Q1.csv", method="curl")
list.files("./quiz")
Q1 <- read.csv("./quiz/Q1.csv")

### 1)
Q1_colnames <- names(Q1)
strsplit(Q1_colnames, "^wgtp")[[123]]


## Question 2: Remove the commas from the GDP numbers in millions of dollars and 
## average them. What is the average?

# First download the data and save as Q2
urlfile_2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(urlfile_2, destfile = "./quiz/Q2.csv", method="curl")
list.files("./quiz")
Q2 <- read.csv("./quiz/Q2.csv", nrow = 190, skip = 4)

## Remove all NA's and give the used variables a name
Q2 <- Q2[,c(1, 2, 4, 5)]
colnames(Q2) <- c("c_code", "rank", "country", "gdp")
Q2

### Remove the commas from the GDP numbers in millions of dollars and average them. What is the average?
Q2$gdp <- as.integer(gsub(",", "", Q2$gdp))
mean(Q2$gdp, na.rm = T)


## 3) In the data set from Question 2 what is a regular expression that would allow 
## you to count the number of countries whose name begins with "United"? Assume that the 
## variable with the country names in it is named countryNames. How many countries begin with United? 
Q2$country[grep("^United", Q2$country)]


## 4 Match the data based on the country shortcode. Of the countries for which the end of the fiscal 
## year is available, how many end in June?

## first download and load the datasets
Url_GDPq4 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(Url_GDPq4, destfile = "./quiz/Q4_GDP.csv", method="curl")
list.files("./quiz")

Url_EDUq4 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(Url_EDUq4, destfile = "./quiz/Q4_Edu.csv", method="curl")
list.files("./quiz")

## setwd()
setwd("/Users/sorennonnengart/Coursera/Data_science/tasks/course_3_Data_cleaning/week4_quiz/quiz")
getwd()

## Read the datasets
Q4_GDP <- read.csv("Q4_GDP.csv", skip = 5, nrows = 190) 
Q4_GDP <- Q4_GDP[,c(1, 2, 4, 5)] 
colnames(Q4_GDP) <- c("CountryCode", "rank", "country", "gdp")
## read Edu.csv
Q4_Edu <- read.csv("Q4_Edu.csv")


## Merge the dataset
Q4_Merge <- merge(Q4_GDP, Q4_Edu, by = 'CountryCode')

FiscalJune <- grep("Fiscal year end: June", Q4_Merge$`Special Notes`)
NROW(FiscalJune)
Q4_Merge


## 5) Use the following code to download data on Amazon's stock price and get the times the data was sampled.
library(quantmod)
library(lubridate)
amzn = getSymbols("AMZN", auto.assign=FALSE)
sampleTimes = index(amzn)

amzn2012 <- sampleTimes[grep("^2012", sampleTimes)]
NROW(amzn2012)

NROW(amzn2012[weekdays(amzn2012) == "Monday"])
