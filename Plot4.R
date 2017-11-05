
#---------------------------- Plot 4 ----------------------------#

# Download the dataset from the web
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
path = getwd()
fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="./dataProject.zip", method="wininet")
unzip(zipfile="dataProject.zip")
rm(path, fileUrl)

# Load the dataset
electric = read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")
# Change "Date" to date variable
electric$Date = as.Date(x=electric$Date, format="%d/%m/%Y")

# Filter Date according to directions
library(dplyr)
electric = filter(electric, Date=="2007-02-01" | Date=="2007-02-02")
# Change "Global_active_power" to numeric variable
electric$Global_active_power = as.numeric(as.character(electric$Global_active_power))

# Change the working directory
setwd("D:/FRANCISCO MARQUEZ M/ESTUDIOS/COURSERA/Johns Hopkins University/Data Science Specialization/4. Exploratory Data Analysis/Week_1/Project/ExData_Plotting1")

# Other changes
library(lubridate)
install.packages("chron")
library(chron)

# Creating "DateTime" variable
electric$Date = as.Date(x=electric$Date, format="%d/%m/%Y", tz="COT")
electric$Time = chron(times=electric$Time)
electric$DateTime = paste(electric$Date,electric$Time)
electric$DateTime = as.POSIXct(electric$DateTime,format="%Y-%m-%d %H:%M:%S")
electric$Sub_metering_1 = as.numeric(as.character(electric$Sub_metering_1))
electric$Sub_metering_2 = as.numeric(as.character(electric$Sub_metering_2))
electric$Voltage = as.numeric(as.character(electric$Voltage))
electric$Global_active_power = as.numeric(as.character(electric$Global_active_power))
electric$Global_reactive_power = as.numeric(as.character(electric$Global_reactive_power))

# locale language
Sys.getlocale(category="LC_TIME")    #<-get the actual language
# [1] "Spanish_Peru.1252"
Sys.setlocale(category="LC_TIME", locale="English")    #<-set "english" language


# Building Plot4
png("Plot4.png", width=480, height=480)
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

# Graph 1
plot(x=electric$DateTime, y=electric$Global_active_power,
     xlab="", ylab="Global Active Power", ylim=c(0,6), type="l")
# Graph 2
plot(x=electric$DateTime, y=electric$Voltage,
     xlab="DateTime", ylab="Voltage", type="l")
# Graph 3
plot(x=electric$DateTime, y=electric$Sub_metering_1,
     xlab="", ylab="Energy sub metering", ylim=c(0,38),col="black", type="l")
lines(x=electric$DateTime, electric$Sub_metering_2,col="red")
lines(x=electric$DateTime, electric$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), 
       c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),
       lty=c(1,1), lwd=c(1,1))
# Graph 4
plot(x=electric$DateTime, y=electric$Global_reactive_power, 
     xlab="DateTime", ylab="Global_reactive_power", type="l")
dev.off()






