# The next step is to subset coal combustion related NEI data

combust_related <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coal_related <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coal_combust <- (combust_related & coal_related)
combust_SCC <- SCC[coal_combust,]$SCC
combust_NEI <- NEI[NEI$SCC %in% combust_SCC,]



png("plot4.png", width=480, height=480, units="px", bg="transparent")

library(ggplot2)

### gg-plot 
ggp <- ggplot(combust_NEI, aes(factor(year),Emissions/10^5)) +
  geom_bar(stat="identity", fill="green", width=0.5) +
  labs(x="year", y=expression("Total PM 2.5* Emission (10^5 Tons)")) + 
  labs(title=expression("PM2.5* Coal Combustion Source Emissions Across US from 1999-2008"))

print(ggp)

dev.off()