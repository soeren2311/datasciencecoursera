# Aggregate using sum the Baltimore emissions data by year
agg_emiss_Balti <- aggregate(baltimore_NEI, Emissions ~ year, FUN=sum, na.rm=TRUE)
png("plot3.png",width=480,height=480,units="px",bg="transparent")

## ggplot2 is used
library(ggplot2)

## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
## variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 

ggp <- ggplot(baltimore_NEI, aes(factor(year), Emissions, fill=type)) +
  geom_bar(stat= "identity") +
  facet_grid(.~type, scales = "free", space="free") + 
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))

print(ggp)

dev.off()