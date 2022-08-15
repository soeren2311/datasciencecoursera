# Subset of the NEI-Dataset which corresponds to vehicles
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]

# Subset the vehicles NEI data to Baltimore's fip
baltimoreVehiclesNEI <- vehiclesNEI[vehiclesNEI$fips=="24510",]

png("plot5.png",width=480,height=480,units="px",bg="transparent")

# library(ggplot2)

ggp <- ggplot(baltimoreVehiclesNEI,aes(factor(year),Emissions)) +
  geom_bar(stat="identity",fill="blue",width=0.65) +
  theme_bw() +guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM 2.5* Emission (10^5 Tons)")) + 
  labs(title=expression("PM2.5* Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

print(ggp)

dev.off()