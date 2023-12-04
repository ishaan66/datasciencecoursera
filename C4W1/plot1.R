library(data.table)

# Read in data from file and subset for specified dates
df <- fread("household_power_consumption.txt", na.strings = "?")
df[, Global_active_power := as.numeric(Global_active_power)]
df[, Date := as.Date(Date, format = "%d/%m/%Y")]
df <- df[Date %in% c("2007-02-01", "2007-02-02")]

# Save histogram plot to PNG file
png("plot1.png", width = 480, height = 480)

# Plot histogram
hist(df$Global_active_power, main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")

# Manually set y-axis labels without scientific notation
yt <- pretty(table(df$Global_active_power))
axis(2, at = yt, labels = formatC(yt, format = "d"))

# Close PNG device
dev.off()

