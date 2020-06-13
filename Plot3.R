#Loading Libraries

library(dplyr)
library(ggplot2)

#Loading Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEI_TBL=tbl_df(NEI)

#Filtering the data
NEI_FIL=filter(NEI_TBL, fips == "24510")
rm(NEI_TBL)

#Summarizing data
NEI_FIL=group_by(NEI_FIL, year, type)
mean_year=as.data.frame(summarize(NEI_FIL, mean(Emissions)))
mean_year
names(mean_year)=c("Year", "Type", "Emissions")

#Creating the plot 
png(file = "plot3.png")
g <- ggplot(mean_year, aes(Year, Emissions, color = Type))
g <- g + geom_line() + xlab("Year") + ylab("Mean Total PM2.5 Emissions") + 
  ggtitle('Total mean PM2.5 Emissions by year in Baltimore City')
print(g)
dev.off()

