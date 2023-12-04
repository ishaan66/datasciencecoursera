# Load the NEI & SCC data frames
NEI <- data.table::as.data.table(x = readRDS("summarySCC_PM25.rds"))
SCC <- data.table::as.data.table(x = readRDS("Source_Classification_Code.rds"))

# Gather the subset of the NEI data which corresponds to vehicles
condition <- grepl("vehicle", SCC[, SCC.Level.Two], ignore.case = TRUE)
vehiclesSCC <- SCC[condition]
vehiclesNEI <- NEI[NEI[, SCC] %in% vehiclesSCC[, SCC], ]

# Subset the vehicles NEI data to Baltimore's fip
baltimoreVehiclesNEI <- vehiclesNEI[fips == "24510"]

png("plot5.png", width = 800, height = 600)

# Load necessary libraries
library(ggplot2)

ggplot(baltimoreVehiclesNEI, aes(x = factor(year), y = Emissions)) +
  geom_bar(stat = "identity", fill = "#FF9999", width = 0.75) +
  labs(x = "Year", y = expression("Total PM"[2.5] * " Emission (10^5 Tons)")) +
  labs(title = expression("PM"[2.5] * " Motor Vehicle Source Emissions in Baltimore from 1999-2008")) +
  theme_minimal()

dev.off()
