# Load the NEI & SCC data frames
SCC <- data.table::as.data.table(x = readRDS("Source_Classification_Code.rds"))
NEI <- data.table::as.data.table(x = readRDS("summarySCC_PM25.rds"))

# Gather the subset of the NEI data which corresponds to vehicles
condition <- grepl("vehicle", SCC[, SCC.Level.Two], ignore.case = TRUE)
vehiclesSCC <- SCC[condition, SCC]
vehiclesNEI <- NEI[NEI[, SCC] %in% vehiclesSCC, ]

# Subset the vehicles NEI data by each city's fip and add city name
vehiclesBaltimoreNEI <- vehiclesNEI[fips == "24510", ]
vehiclesBaltimoreNEI[, city := "Baltimore City"]

vehiclesLANEI <- vehiclesNEI[fips == "06037", ]
vehiclesLANEI[, city := "Los Angeles"]

# Combine data.tables into one data.table
bothNEI <- rbind(vehiclesBaltimoreNEI, vehiclesLANEI)

png("plot6.png", width = 800, height = 600)

# Load necessary libraries
library(ggplot2)

ggplot(bothNEI, aes(x = factor(year), y = Emissions, fill = city)) +
  geom_bar(aes(fill = year), stat = "identity") +
  facet_grid(scales = "free", space = "free", . ~ city) +
  labs(x = "Year", y = expression("Total PM"[2.5] * " Emission (Kilo-Tons)")) +
  labs(title = expression("PM"[2.5] * " Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008")) +
  theme_minimal()

dev.off()
