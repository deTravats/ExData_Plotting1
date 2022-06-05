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

## Generate the histogram 
hist(house_Feb$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

## Generate de PNG file
dev.copy(png, file = "/Users/Louis/Learning Project/household/plot1.png",
         height = 480, width = 480)
dev.off()