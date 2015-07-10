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

#  Step 4:  Convert the three Sub metering variables to a numerics
power.ss$Sub_metering_1 <- as.numeric(power.ss$Sub_metering_1)
power.ss$Sub_metering_2 <- as.numeric(power.ss$Sub_metering_2)
power.ss$Sub_metering_3 <- as.numeric(power.ss$Sub_metering_3)

#  Step 5:  Create the required plot
png(file="plot3.png", width = 480, height = 480,
    units = "px")

with(power.ss, plot(date.time, Sub_metering_1, type="n", 
                    xlab="", ylab="Energy sub metering"))
with( power.ss, lines(date.time, Sub_metering_1, col="black"))
with( power.ss, lines(date.time, Sub_metering_2, col="red"))
with( power.ss, lines(date.time, Sub_metering_3, col="blue"))
leg.text <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
leg.col <- c("black", "red", "blue")
legend("topright", leg.text, col=leg.col, lty=1)
dev.off()
