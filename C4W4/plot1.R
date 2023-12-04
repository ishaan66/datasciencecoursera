# Read the data
emissions <- readRDS("summarySCC_PM25.rds")

# Create a bar plot for total PM2.5 emissions from all sources for each year
png("plot1.png", width=800, height=600)

barplot(tapply(emissions$Emissions, emissions$year, sum), 
        main="Total PM2.5 Emissions in the United States (1999-2008)",
        xlab="Year",
        ylab="Total PM2.5 Emissions (tons)")

dev.off()