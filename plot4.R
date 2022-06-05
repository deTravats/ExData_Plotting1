## Read data
unzip("exdata_data_household_power_consumption.zip", 
      exdir = "/Users/Louis/Learning Project/household")
setwd(dir = "/Users/Louis/Learning Project/household")
house <- read.table(file = "household_power_consumption.txt", 
                    header = TRUE, sep = ";", na.strings = "?")

## Change Date to the correct format & subset by Feb 1st + Feb 2nd
library(dplyr)
house$Date <- as.Date(house$Date, format = "%d/%m/%Y")
house_Feb <- filter(house, Date == "2007-02-01" | Date == "2007-02-02")

## Concatenate Date & Time
house_Feb$Date <- paste(house_Feb$Date, house_Feb$Time)
house_Feb$Date <- as.POSIXct(house_Feb$Date)

## Make the 2x2 canvas

par(mfcol = c(2, 2))

## Generate the 1st plot 
with(house_Feb, plot(Date, Global_active_power, xlab = "", 
                     ylab = "Global Active Power", type = "l"))

## Generate the 2nd plot
with(house_Feb, plot(Date, Sub_metering_1, xlab = "", 
                     ylab = "Energy sub metering", type = "l"))
with(house_Feb, lines(Sub_metering_2~Date, col = "red"))
with(house_Feb, lines(Sub_metering_3~Date, col = "blue"))
with(house_Feb, legend("topright", col = c("black", "red", "blue"), 
                       legend = c("Sub_metering_1", "Sub_metering_2", 
                                  "Sub_metering_3"), lty = 1, lwd = 1,
                       box.col = "white", cex = 0.60))

## Generate the 3rd plot
with(house_Feb, plot(Date, Voltage, xlab = "datetime", type = "l"))

## Generate the 4th plot
with(house_Feb, plot(Date, Global_reactive_power, 
                     xlab = "datetime", type = "l"))

## Generate de PNG file
dev.copy(png, file = "/Users/Louis/Learning Project/household/plot4.png",
         height = 480, width = 480)
dev.off()