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
plot(relevantData$timestamp, relevantData$Global_active_power, type='l',xlab="", ylab = "Global Activity Power(kilowatts)")
dev.copy(png, file="plot2.png")
dev.off()
