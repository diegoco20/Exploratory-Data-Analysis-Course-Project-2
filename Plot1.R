directory_1=getwd()
#Loading Libraries

library(dplyr)

#Loading Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEI_TBL=tbl_df(NEI)
#Grouping Data
NEI_TBL=group_by(NEI_TBL, year)
rm(NEI)

#Summarizing Data
mean_year=summarize(NEI_TBL, mean(Emissions))
mean_year=as.data.frame(mean_year)                    
names(mean_year)=c("Year", "Emissions")

#Creating Plot
png(file = "plot1.png", width = 480, height = 480)
with(mean_year, barplot(Emissions, names.arg = Year, xlab="Year", ylab="Mean PM25-PRI Emissions", main="Mean PM 25 Emissions by Year"))
dev.off()
