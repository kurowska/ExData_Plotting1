#define the file
thefile <- "./data/household_power_consumption.txt"

#read the file
thedata <- read.table(thefile, header=TRUE, sep=";", na.string="?")

#subset data to contain only the important period
subset_data <- subset(thedata, Date %in% c("1/2/2007","2/2/2007"))
rm(thedata)

#open a png device
png("plot2.png", width=480, height=480)

#get Global_active_power, use as.numeric(), because R says it's not numeric
global_active_power <- as.numeric(subset_data$Global_active_power)

#get date and time columns into 1 variable with strptime
date_time <- strptime(paste(subset_data$Date, subset_data$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

plot(date_time, global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

#close the device
dev.off()