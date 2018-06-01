# getting data

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",temp)
unzip(temp)
unlink(temp)


# reading data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# aggregating and plotting data

emissions <- aggregate(Emissions ~ year, NEI, sum)
emissions

png('plot1.png')

barplot(height=emissions$Emissions, 
        names.arg=emissions$year,
        xlab="years", 
        ylab='total emission',
        main='Total emission  at different years',
        col = 'black')

dev.off()