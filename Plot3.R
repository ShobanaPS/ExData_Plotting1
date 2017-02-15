# read data
data <- read.delim("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
# create a subset of data from 1/2/2007 and 2/2/2007 only
data_subset <- subset(data, Date == "1/2/2007"| Date == "2/2/2007")
# Use Data and Time columns to create a newDate column of type POSIXlt
data_subset$DateTime <- paste(data_subset$Date,data_subset$Time)
data_subset$newDate <- strptime(data_subset$DateTime, format = "%d/%m/%Y %H:%M:%S")
# Add a new column to for the short form of day
data_subset$Day <- weekdays(data_subset$newDate, abbreviate = TRUE)

# set graphics device as png file called Plot3.png
png("Plot3.png")

# Create Plot 
plot(data_subset$newDate, data_subset$Sub_metering_1, type = "l", xlab = "", ylab = "Energy Sub Metering", col = "black")
lines(data_subset$newDate, data_subset$Sub_metering_2, col = "red")
lines(data_subset$newDate, data_subset$Sub_metering_3, col = "blue")

#Add legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red","blue"), lty = c(1,1,1), lwd = c(2.5,2.5,2.5))

# Turn off png as graphic device
dev.off()