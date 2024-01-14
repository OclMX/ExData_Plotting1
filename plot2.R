
library(dplyr)

 


fileName <- "./household_power_consumption.txt"
powerConsumption <- read.table(fileName, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

#Convert fields to datetime and numeric
powerConsumption <- powerConsumption %>%
  mutate(Global_active_power = as.numeric(Global_active_power))

powerConsumption <- powerConsumption %>%
  mutate(DateTime = strptime(
    paste(powerConsumption$Date, powerConsumption$Time, sep=" "), "%d/%m/%Y %H:%M:%S"))

powerConsumption <- powerConsumption %>%
  mutate(Date = as.Date(Date, format = "%d/%m/%Y"))


#Filter based on date
globalActivePower <- select(powerConsumption, Global_active_power, Date, DateTime) %>%
  filter(Date >= as.Date("2/1/2007", format = "%d/%m/%Y") 
         & Date <= as.Date("2/2/2007", format = "%d/%m/%Y") )

# Switch device to PNG
#png(filename = "plot2.png", width=480, height=480)

with(globalActivePower, 
     plot(DateTime, Global_active_power, 
          type="l", xlab="", ylab="Global Active Power (kilowatts)"))



# Reset to screen.
#dev.off()
dev.cur()

