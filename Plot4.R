#Loading Libraries

library(dplyr)
library(ggplot2)

#Loading Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEI_TBL=tbl_df(NEI)
NEI_SCC <- merge(NEI, SCC, by="SCC")


#Filtering the data
NEI_SCC_COAL <- grepl("coal", NEI_SCC$Short.Name, ignore.case=TRUE)
COAL <- NEI_SCC[NEI_SCC_COAL, ]

by_year <- COAL[, list(emissions=sum(Emissions)), by=c("year")]
by_year$year = as.numeric(as.character(by_year$year))
by_year$emissions = as.numeric(as.character(by_year$emissions))


#Creating the plot 
ggplot(data=by_year, aes(x=year, y=emissions)) + geom_line() + 
  geom_point() + ggtitle("Emissions from Coal Sources in the US")