# read data for rows 66638 through to 69,517 which have data for 1/2/2007 & 2/2/2007
data <- read.delim("household_power_consumption.txt", header = FALSE, sep = ";", na.strings = "?", skip = 66637, nrows = 2880)
headers <- read.delim("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?",nrows = 2)
names(data) <- names(headers)

# Use Data and Time columns to create a newDate column of type POSIXlt
data$DateTime <- paste(data$Date,data$Time)
data$newDate <- strptime(data$DateTime, format = "%d/%m/%Y %H:%M:%S")
# Add a new column to for the short form of day
data$Day <- weekdays(data$newDate, abbreviate = TRUE)

# set graphics device as png file called Plot3.png
png("Plot3.png")

# Create Plot 
plot(data$newDate, data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy Sub Metering", col = "black")
lines(data$newDate, data$Sub_metering_2, col = "red")
lines(data$newDate, data$Sub_metering_3, col = "blue")

#Add legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red","blue"), lty = c(1,1,1), lwd = c(2.5,2.5,2.5))

# Turn off png as graphic device
dev.off()