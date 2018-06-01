# getting data

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",temp)
unzip(temp)
unlink(temp)


# reading data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# aggregating and plotting data

baltimore <- subset(NEI, fips == '24510')
balt.emissions <- aggregate(Emissions ~ year + type, baltimore, sum)
balt.emissions


library(ggplot2)

png('plot3.png')

ggplot(balt.emissions, aes(factor(year),Emissions, fill=type)) +
  geom_bar(stat = 'identity') +
  facet_grid(. ~ type) +
  xlab("years") +
  ylab("total emission") +
  ggtitle('Total emission in Baltimore, MD by type at different years') +
  theme(axis.text.x = element_text(angle = 60, hjust = 1)) #rotating xlab for clearer view

dev.off()





