##  Code to create Plot 1

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

#  Step 4:  Convert the Global active power variable to a numeric
power.ss$Global_active_power <- as.numeric(power.ss$Global_active_power)

#  Step 5:  Create the required plot
png(file="plot1.png", width = 480, height = 480,
    units = "px")
hist(power.ss$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", col="red", yaxt="n"
)
axis(2, at=seq(0, 1200, by=200), labels=seq(0, 1200, by=200))
dev.off()
