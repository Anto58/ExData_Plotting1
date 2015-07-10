##  Code to create Plot 3

# Note that I have used the lubridate function dmy_hms to create the 
#  date.time variable, and the year(), month() and day functions
#  to subset the data

install.packages("lubridate")
library(lubridate)

#  The complete dataset was downloaded to my Desktop/Coursera/directory

#  Step 1:  Read in the data
power <- read.table("~/Desktop/Coursera/household_power_consumption.txt", 
                    header=TRUE, sep=";", stringsAsFactors=FALSE)

#  Step 2:  Create the date time variable
power$date.time <- dmy_hms(paste(power$Date, power$Time))

#  Step 3:  Subset the data to select records for the required dates
power.ss <- power[year(power$date.time) ==2007&
                        month(power$date.time) ==2&
                        day(power$date.time) %in% c(1, 2),]

#  Step 4:  Convert the variables that will be used in the
#  plots to numerics
power.ss$Global_active_power <- as.numeric(power.ss$Global_active_power)
power.ss$Sub_metering_1 <- as.numeric(power.ss$Sub_metering_1)
power.ss$Sub_metering_2 <- as.numeric(power.ss$Sub_metering_2)
power.ss$Sub_metering_3 <- as.numeric(power.ss$Sub_metering_3)
power.ss$Voltage <- as.numeric(power.ss$Voltage)
power.ss$Global_reactive_power <- as.numeric(power.ss$Global_reactive_power)

#  Step 5:  Create the required plot
png(file="plot4.png", width = 480, height = 480,
    units = "px")

par(mfrow=c(2,2))

#  Top left plot
with(power.ss, plot(date.time, Global_active_power, type="n", 
                    xlab="", ylab="Global Active Power (kilowatts)"))
with( power.ss, lines(date.time, Global_active_power))

#  Top right plot
with(power.ss, plot(date.time, Voltage, type="n",
                    xlab="datetime", ylab="Voltage"))
with(power.ss, lines(date.time, Voltage))

#  Bottom left plot
with(power.ss, plot(date.time, Sub_metering_1, type="n", 
                    xlab="", ylab="Energy sub metering"))
with( power.ss, lines(date.time, Sub_metering_1, col="black"))
with( power.ss, lines(date.time, Sub_metering_2, col="red"))
with( power.ss, lines(date.time, Sub_metering_3, col="blue"))
leg.text <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
leg.col <- c("black", "red", "blue")
legend("topright", leg.text, col=leg.col, lty=1, bty="n")

#  Bottom right plot
with(power.ss, plot(date.time, Global_reactive_power, type="n", 
                    xlab="datetime", ylab="Global_reactive_power"))
with( power.ss, lines(date.time, Global_reactive_power))

dev.off()

