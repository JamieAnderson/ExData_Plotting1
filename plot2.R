#Read-in First Row
date_df <- read.table("household_power_consumption.txt",sep=";",header=T,nrows=2075259,colClasses = c("factor", rep("NULL", 8)),comment.char = "")
#Find only the rows of the whole data set I will need
rows_needed <- which(date_df$Date=="1/2/2007" | date_df$Date =="2/2/2007")

#Read in all 9 rows, for the rows_needed
data <- read.table("household_power_consumption.txt",sep=";",header=T,colClasses = c("factor", "factor",rep("numeric",7)),skip=rows_needed[1]-1,nrows=length(rows_needed),na.strings = c("NA","?"),comment.char = "")
rm(date_df,rows_needed)

#Needed to rename Columns
colnames(data) <- colnames(read.csv("household_power_consumption.txt",sep=";",nrows=1,header=T))

#Merge and Format Dates and Times
data$Date <- strptime(paste(data$Date,data$Time),"%d/%m/%Y %H:%M:%S")
data$Time <- NULL

#Create and Save Plot
png(file="plot2.png")
plot(data$Date,data$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="",cex.lab=.6,cex.axis=0.6)
dev.off()