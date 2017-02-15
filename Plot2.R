# read data
data <- read.delim("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
# create a subset of data from 1/2/2007 and 2/2/2007 only
data_subset <- subset(data, Date == "1/2/2007"| Date == "2/2/2007")
# Use Data and Time columns to create a newDate column of type POSIXlt
data_subset$DateTime <- paste(data_subset$Date,data_subset$Time)
data_subset$newDate <- strptime(data_subset$DateTime, format = "%d/%m/%Y %H:%M:%S")
# Add a new column to for the short form of day
data_subset$Day <- weekdays(data_subset$newDate, abbreviate = TRUE)

# set graphics device as png file called Plot2.png
png("Plot2.png")

# Create Plot 
plot(data_subset$newDate, data_subset$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# Turn off png as graphic device
dev.off()