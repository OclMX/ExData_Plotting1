
library(dplyr)

 


fileName <- "./household_power_consumption.txt"
powerConsumption <- read.table(fileName, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

powerConsumption <- powerConsumption[powerConsumption$Date %in% c("1/2/2007","2/2/2007") ,]

#Convert fields to datetime and numeric
powerConsumption <- powerConsumption %>%
  mutate(Global_active_power = as.numeric(Global_active_power))

powerConsumption <- powerConsumption %>%
  mutate(DateTime = strptime(
    paste(powerConsumption$Date, powerConsumption$Time, sep=" "), "%d/%m/%Y %H:%M:%S"))

powerConsumption <- powerConsumption %>%
  mutate(Date = as.Date(Date, format = "%d/%m/%Y"))


# Switch device to PNG
png(filename = "plot2.png", width=480, height=480)
lstDateTime = powerConsumption$DateTime
lstGlobalActivePower = powerConsumption$Global_active_power

plot(lstDateTime, lstGlobalActivePower, 
          type="l", xlab="", ylab="Global Active Power (kilowatts)")



# Reset to screen.
dev.off()
dev.cur()

