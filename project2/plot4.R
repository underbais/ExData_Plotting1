# getting data

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",temp)
unzip(temp)
unlink(temp)


# reading data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# aggregating and plotting data

coal.scc <- SCC[grepl('Coal',SCC$EI.Sector),]
coal.data <- subset(NEI, SCC == coal.scc$SCC)
coal.emissions <- aggregate(Emissions ~ year, coal.data, sum)

library(ggplot2)

png('plot4.png')

ggplot(coal.emissions, aes(factor(year),Emissions)) +
  geom_bar(stat = 'identity') +
  xlab("years") +
  ylab("total emission") +
  ggtitle('Total emission from coal combustion in Baltimore, MD at various years')

dev.off()





