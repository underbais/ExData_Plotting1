# getting data

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",temp)
unzip(temp)
unlink(temp)


# reading data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# aggregating and plotting data

balt.la.motor <- subset(NEI, (fips == '24510' | fips =='06037') & type == 'ON-ROAD')
balt.la.motor.emissions <- aggregate(Emissions ~ year+fips, balt.la.motor, sum)
balt.la.motor.emissions$fips <- gsub('24510','Baltimore',balt.la.motor.emissions$fips)
balt.la.motor.emissions$fips <- gsub('06037','Los Angeles',balt.la.motor.emissions$fips)
balt.la.motor.emissions

library(ggplot2)

png('plot6.png')

ggplot(balt.la.motor.emissions, aes(factor(year),Emissions)) +
  facet_grid(.~fips) +
  geom_bar(stat = 'identity') +
  xlab("years") +
  ylab("total emission") +
  ggtitle('Total emission from motor vehicles in Baltimore, MD and Los Angeles, CA at various years')

dev.off()





