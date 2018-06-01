# getting data

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",temp)
unzip(temp)
unlink(temp)


# reading data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# aggregating and plotting data

baltimore.motor <- subset(NEI, fips == '24510' & type == 'ON-ROAD')
balt.motor.emissions <- aggregate(Emissions ~ year, baltimore.motor, sum)
balt.motor.emissions

library(ggplot2)

png('plot5.png')

ggplot(balt.motor.emissions, aes(factor(year),Emissions)) +
  geom_bar(stat = 'identity') +
  xlab("years") +
  ylab("total emission") +
  ggtitle('Total emission from motor vehicles in Baltimore, MD at various years')

dev.off()





