## Read the two datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset NEI data for Baltimore
baltimore_NEI <- NEI[NEI$fips=="24510",]

# Aggregate the data as shown in plot1.R
agg_emiss_Balti <- aggregate(baltimore_NEI, Emissions ~ year, FUN=sum, na.rm=TRUE)
agg_emiss_Balti


png("plot2.png", width=480, height=480, units="px", bg="transparent")

barplot(
  agg_emiss_Balti$Emissions,
  names.arg=agg_emiss_Balti$year,
  xlab="Year",
  ylab="PM2.5 Emissions (Tons)",
  main="Total PM2.5 Emissions From all Baltimore City Sources"
)

dev.off()