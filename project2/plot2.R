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
balt.emissions <- aggregate(Emissions ~ year, baltimore, sum)
balt.emissions

png('plot2.png')

barplot(height=balt.emissions$Emissions, 
        names.arg=balt.emissions$year,
        xlab="years", 
        ylab='total emission',
        main='Total emission in Baltimore, MD at different years',
        col = 'black')

dev.off()