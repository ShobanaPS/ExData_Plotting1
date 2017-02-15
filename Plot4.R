# read data for rows 66638 through to 69,517 which have data for 1/2/2007 & 2/2/2007
data <- read.delim("household_power_consumption.txt", header = FALSE, sep = ";", na.strings = "?", skip = 66637, nrows = 2880)
headers <- read.delim("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?",nrows = 2)
names(data) <- names(headers)

# Use Data and Time columns to create a newDate column of type POSIXlt
data$DateTime <- paste(data$Date,data$Time)
data$newDate <- strptime(data$DateTime, format = "%d/%m/%Y %H:%M:%S")
# Add a new column to for the short form of day
data$Day <- weekdays(data$newDate, abbreviate = TRUE)

# set graphics device as png file called Plot4.png
png("Plot4.png")

# Divide panels into matrix of 2 rows and 2 columns to accommodate 4 plots
par(mfrow = c (2,2))

# Plot #1
plot(data$newDate, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# Plot #2 
plot(data$newDate, data$Voltage, type = "l", xlab = "dateTime", ylab = "Voltage")

#Plot 3
plot(data$newDate, data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy Sub Metering", col = "black")
lines(data$newDate, data$Sub_metering_2, col = "red")
lines(data$newDate, data$Sub_metering_3, col = "blue")

#Add legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red","blue"), lty = c(1,1,1), lwd = c(2.5,2.5,2.5), bty = "n")

# Plot # 4
plot(data$newDate, data$Global_reactive_power, type = "l", xlab = "dateTime", ylab = "Global_reactive_power")

# Turn off png as graphic device
dev.off()
