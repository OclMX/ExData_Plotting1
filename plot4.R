
# moving away from deployer. line plots with a datetime
# x axis seems to have issues group by day of week.
# And creating seperate sequences.
# the issue was with the data. I selected from 1-2 thru 2-2.
# too many zeros it appears in that subset.
# library(dplyr)

fileName <- "./household_power_consumption.txt"
powerConsumption <- read.table(fileName, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
filteredData <- powerConsumption[powerConsumption$Date %in% c("1/2/2007","2/2/2007") ,]

#Convert fields to datetime and numeric

dtGAP <- strptime(paste(filteredData$Date, filteredData$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
globalActivePower <- as.numeric(filteredData$Global_active_power)
subMetering1 <- as.numeric(filteredData$Sub_metering_1)
subMetering2 <- as.numeric(filteredData$Sub_metering_2)
subMetering3 <- as.numeric(filteredData$Sub_metering_3)
Voltage <- as.numeric(filteredData$Voltage)
globalReactivePower <- as.numeric(filteredData$Global_reactive_power)

png("plot4.png", width=480, height=480)

par(mfrow = c(2, 2)) 

plot(dtGAP, globalActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.2)

plot(dtGAP, Voltage, type="l", xlab="datetime", ylab="Voltage")

plot(dtGAP, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(dtGAP, subMetering2, type="l", col="red")
lines(dtGAP, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

plot(dtGAP, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
dev.cur()



