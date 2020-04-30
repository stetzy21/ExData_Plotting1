library(data.table)
library(dplyr)

# set working directory
setwd("C:/Users/hernandez/Desktop/R_Scripts/ExData_Plotting1")

filename = "exdata_data_household_power_consumption.zip"

# download the file if it doesn't exist
if(!file.exists(filename)){
    fileURL = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileURL, filename, method = "curl")
}

# if the file doesn't exist, unzip the file
if(!file.exists("household_power_consumption.txt")){
    unzip(filename)    
}

# read in the data
powerconsumption <- fread("household_power_consumption.txt", na.strings = "?")

# Convert the first column to the date class, scond column to DateTime, and filter the data for the specified data range & 
powerconsumption <- powerconsumption %>% mutate(Date = as.Date(Date, format = "%d/%m/%Y")) %>%
    mutate(Time = as.POSIXct(strptime(paste(Date, Time), format = "%Y-%m-%d %H:%M:%S")))
filteredData <- subset(powerconsumption, Date >= "2007-02-01" & Date <= "2007-02-02")


#open up the graphics device
png(filename = "plot2.png", units = "px", width = 480, height = 480)

# generate the plot
with(filteredData, plot(Time, Global_active_power, type="l", xlab="",
                        ylab = "Global Active Power (kilowatts)"))

#close the graphics device
dev.off()