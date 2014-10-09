#Download and read raw data

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.csv(unz(temp, "household_power_consumption.txt"), header = TRUE, sep = ";", na.strings="?")
unlink(temp)



#Go to the tidy data
data <- within(data, { timestamp=paste(Date, Time) })
data$timestamp <- strptime(data$timestamp, "%d/%m/%Y %H:%M:%S")

relevantData <- subset(data, timestamp > strptime("31/01/2007 23:59:59", "%d/%m/%Y %H:%M:%S") & timestamp < strptime("03/02/2007 00:00:00", "%d/%m/%Y %H:%M:%S"))

#Plot data
par(mar=c(4,10,2,4))
plot(relevantData$timestamp, relevantData$Sub_metering_1, type='l',xlab="", ylab = "Energy sub metering")
lines(relevantData$timestamp, relevantData$Sub_metering_2, col='red', type='l', ylab = "Energy sub metering")
lines(relevantData$timestamp, relevantData$Sub_metering_3, col='blue', type='l', ylab = "Energy sub metering")
legend('topright',lty=c(1,1),lwd=c(2.5,2.5), c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), col=c("black","red","blue"))
dev.copy(png, file="plot3.png")
dev.off()
