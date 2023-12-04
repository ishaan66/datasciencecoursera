# Load the NEI & SCC data frames
NEI <- data.table::as.data.table(x = readRDS("summarySCC_PM25.rds"))
SCC <- data.table::as.data.table(x = readRDS("Source_Classification_Code.rds"))

# Subset coal combustion-related NEI data
combustionRelated <- grepl("comb", SCC[, SCC.Level.One], ignore.case = TRUE)
coalRelated <- grepl("coal", SCC[, SCC.Level.Four], ignore.case = TRUE)
combustionSCC <- SCC[combustionRelated & coalRelated, SCC]
combustionNEI <- NEI[NEI[, SCC] %in% combustionSCC]

png("plot4.png", width = 800, height = 600)

# Load necessary libraries
library(ggplot2)

ggplot(combustionNEI, aes(x = factor(year), y = Emissions / 1e5)) +
  geom_bar(stat = "identity", fill = "#FF9999", width = 0.75) +
  labs(x = "Year", y = expression("Total PM"[2.5] * " Emission (10^5 Tons)")) +
  labs(title = expression("PM"[2.5] * " Coal Combustion Source Emissions Across US from 1999-2008")) +
  theme_minimal()

dev.off()
