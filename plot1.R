
library(dplyr)


fileName <- "./household_power_consumption.txt"
powerConsumption <- read.table(fileName, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

#Convert fields to datetime
powerConsumption <- powerConsumption %>%
  mutate(Date = as.Date(Date, format = "%d/%m/%Y"))

powerConsumption <- powerConsumption %>%
  mutate(Global_active_power = as.numeric(Global_active_power))



globalActivePower <- select(powerConsumption, Global_active_power, Date) %>%
  filter(Date >= as.Date("2/1/2007", format = "%d/%m/%Y") 
         & Date <= as.Date("2/2/2007", format = "%d/%m/%Y") )


# Switch device to PNG
png(filename = "plot1.png", width=480, height=480)
hist(globalActivePower$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

# Reset to screen.
dev.off()
dev.cur()
