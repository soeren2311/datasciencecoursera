# Load the NEI & SCC data frames.

## create a path to the folder where the data is located
path <- "/Users/sorennonnengart/Coursera/Data_science/Datensätze/c4week4/exdata_data_NEI_data"

## set the path 
setwd(path)
getwd()
## check if those files are in my current working directory 
dir() ## --> Yes, they are

## read the two datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Aggregate the sum for each year over the total emissions by year
agg_emissions <- aggregate(NEI, Emissions ~ year, FUN=sum, na.rm=TRUE)
agg_emissions

png("plot1.png", width=480, height=480, units="px", bg="transparent")

## barplot
barplot(
  (agg_emissions$Emissions)/10^6,
  names.arg=agg_emissions$year,
  xlab="Year",
  ylab="PM2.5 Emissions (10^6 Tons)",
  main="Total PM2.5 Emissions From All US Sources"
)

dev.off()