#Loading Libraries

library(dplyr)
library(ggplot2)

#Loading Data
NEI = readRDS("summarySCC_PM25.rds")
SCC = readRDS("Source_Classification_Code.rds")
NEI_TBL=tbl_df(NEI)

#Filetering Data
VEHICLE=grepl("vehicle", SCC$Short.Name, ignore.case = T)
SCC_V=SCC[VEHICLE,]$SCC
NEI_VEHICLE=NEI_TBL[NEI_TBL$SCC %in% SCC_V,]
NEI_VEHICLE=filter(NEI_VEHICLE, fips == "24510")

#Grouping data
NEI_VEHICLE_GROUP=group_by(NEI_VEHICLE, year)
mean_year=summarize(NEI_VEHICLE_GROUP, mean(Emissions))
names(mean_year)=c("Year", "Emissions")

#Ploting the data
png(file="plot5.png")
with(mean_year, barplot(Emissions, names.arg= Year, xlab="Year", ylab="Vehicle PM2.5 source mean Emissions",
                        main="Vehicle PM2.5 Emissions in Baltimore City"))
dev.off()
