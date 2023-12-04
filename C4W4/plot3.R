# Read the data
emissions <- readRDS("summarySCC_PM25.rds")

# Filter data for Baltimore City
baltimore_emissions <- emissions[emissions$fips == "24510", ]

# Load necessary libraries
library(ggplot2)

# Create a ggplot for changes in PM2.5 emissions by source type in Baltimore City
png("plot3.png", width=800, height=600)

ggplot(baltimore_emissions, aes(x = year, y = Emissions, fill = type)) +
  geom_bar(stat = "identity") +
  labs(title = "Changes in PM2.5 Emissions by Source Type in Baltimore City (1999-2008)",
       x = "Year",
       y = "Total PM2.5 Emissions (tons)",
       fill = "Source Type") +
  theme_minimal()

dev.off()
