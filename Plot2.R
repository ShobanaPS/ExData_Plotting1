# read data for rows 66638 through to 69,517 which have data for 1/2/2007 & 2/2/2007
data <- read.delim("household_power_consumption.txt", header = FALSE, sep = ";", na.strings = "?", skip = 66637, nrows = 2880)
headers <- read.delim("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?",nrows = 2)
names(data) <- names(headers)

# Use Data and Time columns to create a newDate column of type POSIXlt
data$DateTime <- paste(data$Date,data$Time)
data$newDate <- strptime(data$DateTime, format = "%d/%m/%Y %H:%M:%S")
# Add a new column to for the short form of day
data$Day <- weekdays(data$newDate, abbreviate = TRUE)

# set graphics device as png file called Plot2.png
png("Plot2.png")

# Create Plot 
plot(data$newDate, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# Turn off png as graphic device
dev.off()