#define the file
thefile <- "./data/household_power_consumption.txt"

#read the file
thedata <- read.table(thefile, header=TRUE, sep=";", na.string="?")

#subset data to contain only the important period
subset_data <- subset(thedata, Date %in% c("1/2/2007","2/2/2007"))
rm(thedata)

#get sub_metering variables, use as.numeric(), because R says it's not numeric
sub_metering1 <- as.numeric(subset_data$Sub_metering_1, na.rm = TRUE)
sub_metering2 <- as.numeric(subset_data$Sub_metering_2, na.rm = TRUE)
sub_metering3 <- as.numeric(subset_data$Sub_metering_3, na.rm = TRUE)

global_active_power <- as.numeric(subset_data$Global_active_power)
global_reactive_power <- as.numeric(subset_data$Global_reactive_power)
voltage <- as.numeric(subset_data$Voltage)

#get date and time columns into 1 variable with strptime
date_time <- strptime(paste(subset_data$Date, subset_data$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

#open a png device
png("plot4.png", width=480, height=480)

par(mfrow = c(2, 2)) 

plot(date_time, global_active_power, type="l", xlab="", ylab="Global Active Power", cex=0.2)

plot(date_time, voltage, type="l", xlab="datetime", ylab="Voltage")

plot(date_time, sub_metering1, type="l", ylab="Energy Submetering", xlab="")
lines(date_time, sub_metering2, type="l", col="red")
lines(date_time, sub_metering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"), bty="o")

plot(date_time, global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

#close the device
dev.off()
