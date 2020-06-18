
#Librabies 
library(dplyr)
library(ggplot2)

#Loading Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC = readRDS("Source_Classification_Code.rds")
NEI_TBL=tbl_df(NEI)
rm(NEI)
head(NEI_TBL)
rm(NEI_TBL)

#Filtering data
NEI_FIL=filter(NEI_TBL, fips=="24510" | fips=="06037")
NEI_GROUP=group_by(NEI_FIL, year, fips)
mean_year=summarize(NEI_GROUP, mean(Emissions))
names(mean_year)=c("year", "City", "Emissions")
mean_year$City[mean_year$City=="24510"]="Baltimore"
mean_year$City[mean_year$City=="06037"]="Los Angeles"

#Ploting 
png(file="plot6.png")
g= ggplot(data=mean_year, aes(x=factor(year), y=Emissions, fill=City))
g+geom_bar(stat="identity")+labs(title="Mean PM2.5 Emissions by City")
dev.off()
