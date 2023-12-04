# Read the data
emissions <- readRDS("summarySCC_PM25.rds")

# Filter data for Baltimore City
baltimore_emissions <- emissions[emissions$fips == "24510", ]

# Create a bar plot for total PM2.5 emissions in Baltimore City from 1999 to 2008
png("plot2.png", width=800, height=600)

barplot(tapply(baltimore_emissions$Emissions, baltimore_emissions$year, sum),
        main="Total PM2.5 Emissions in Baltimore City (1999-2008)",
        xlab="Year",
        ylab="Total PM2.5 Emissions (tons)")

dev.off()