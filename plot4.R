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
png(filename = "Plot4.png",width = 480,height = 480)

#set the paramteris for the plot window
par(mfrow=c(2,2))

#topleft plot
with(df2,plot(Global_active_power~Time,type="n",ylab = "Global Active Power (kilowatts)",
              xlab=""))
with(df2,lines(Global_active_power~Time))

#topright plot
with(df2,plot(Voltage~Time,type="n",ylab = "Voltage",
              xlab="datetime"))
with(df2,lines(Voltage~Time))

#bottom left plot

with(df2,plot(Sub_metering_1~Time,type="n",ylab = "Energy sub metering",
              xlab=""))
with(df2,lines(Sub_metering_1~Time))
with(df2,lines(Sub_metering_2~Time,col="Red"))
with(df2,lines(Sub_metering_3~Time,col="Blue"))
legend(x="topright",lty=1,
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("Black","Red","Blue"),bty = "n")

#bottom right plot
with(df2,plot(Global_reactive_power~Time,type="n",
              xlab="datetime"))
with(df2,lines(Global_reactive_power~Time))


#close the device
dev.off()