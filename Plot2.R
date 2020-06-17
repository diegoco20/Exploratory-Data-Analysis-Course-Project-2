#Loading Libraries

library(dplyr)

#Loading Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEI_TBL=tbl_df(NEI)

#Filtering the data
NEI_FIL=filter(NEI_TBL, fips == "24510")
rm(NEI_TBL)

#Summarizing data
NEI_FIL=group_by(NEI_FIL, year)
mean_year=as.data.frame(summarize(NEI_FIL, mean(Emissions)))
names(mean_year)=c("Year", "Emissions")

#Creating Plot
png(file = "plot2.png", width = 480, height = 480)
with(mean_year, barplot(Emissions, names.arg = Year, xlab="Year", ylab="Mean emissions from PM2.5", 
                        main="Mean total Emissions from PM2.5 in Baltimore City"))
dev.off()
