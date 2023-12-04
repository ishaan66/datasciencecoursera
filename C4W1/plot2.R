library(data.table)
library(ggplot2)

# Read in data from file and subset for specified dates
df <- data.table::fread(input = "household_power_consumption.txt", na.strings = "?")

# Convert Global_active_power to numeric
df[, Global_active_power := as.numeric(Global_active_power)]

# Create a POSIXct date capable of being filtered and graphed by time of day
df[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02
df <- df[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

# Save line plot to PNG file
png("plot2.png", width = 480, height = 480)

# Plot Global_active_power over time
ggplot(df, aes(x = dateTime, y = Global_active_power)) +
  geom_line() +
  labs(title = "Global Active Power Over Time",
       x = "Datetime", y = "Global Active Power (kilowatts)")

# Close PNG device
dev.off()
