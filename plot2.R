#First read the data file
library(dplyr)
df <- read.table("household_power_consumption.txt",sep = ";",header = TRUE,
                 colClasses = c("character","character",rep("numeric",7)),na.strings = "?")


#filter the data based on 1st and 2nd of Feb 2007 only
df2<- filter(df,Date=="1/2/2007" | Date=="2/2/2007")

#combine dates and times into one column (overwriting time column as otherwise a date would be implied)
df2$Time <- paste(df2$Date,df2$Time,sep=" ")

#Add correct date information to the time column
df2$Time <- as.POSIXct(df2$Time, format="%d/%m/%Y %H:%M:%S")

#open the png device with the specified dimensions
png(filename = "Plot2.png",width = 480,height = 480)

#create a linechart
with(df2,plot(Global_active_power~Time,type="n",ylab = "Global Active Power (kilowatts)",
              xlab=""))
with(df2,lines(Global_active_power~Time))

#close the device
dev.off()