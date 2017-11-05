
#---------------------------- Plot 2 ----------------------------#

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
# locale language
Sys.getlocale(category="LC_TIME")    #<-get the actual language
# [1] "Spanish_Peru.1252"
Sys.setlocale(category="LC_TIME", locale="English")    #<-set "english" language

# Building Plot2
png("Plot2.png", width=480, height=480)
plot(x=electric$DateTime, y=electric$Global_active_power, 
     type="l", xlab="", 
     ylab="Global Active Power (kilowatts)")
dev.off()

