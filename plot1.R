library(dplyr)
#First read the data file
df <- read.table("household_power_consumption.txt",sep = ";",header = TRUE,
                 colClasses = c("character","character",rep("numeric",7)),na.strings = "?")
#Convert Date column to date format
df$Date <- as.Date(df$Date, "%d/%m/%Y")

#filter the data based on 1st and 2nd of Feb 2007 only
df2<- filter(df,Date=="2007/02/01" | Date=="2007/02/02")
#Convert Time to time class
df2$Time <- as.POSIXlt(df2$Time, format="%H:%M:%S")

#open the png device with the specified dimensions
png(filename = "Plot1.png",width = 480,height = 480)

#create a histogram
with(df2,hist(Global_active_power,col="red",
              main = "Global Active Power",
              xlab="Global Active Power (kilowatts)"))
#close the device
dev.off()




