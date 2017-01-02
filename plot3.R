#define the file
thefile <- "./data/household_power_consumption.txt"

#read the file
thedata <- read.table(thefile, header=TRUE, sep=";", na.string="?")

#subset data to contain only the important period
subset_data <- subset(thedata, Date %in% c("1/2/2007","2/2/2007"))
rm(thedata)

#open a png device
png("plot3.png", width=480, height=480)

#get sub_metering variables, use as.numeric(), because R says it's not numeric
sub_metering1 <- as.numeric(subset_data$Sub_metering_1, na.rm = TRUE)
sub_metering2 <- as.numeric(subset_data$Sub_metering_2, na.rm = TRUE)
sub_metering3 <- as.numeric(subset_data$Sub_metering_3, na.rm = TRUE)

#get date and time columns into 1 variable with strptime
date_time <- strptime(paste(subset_data$Date, subset_data$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

#make the first plot
with(subset_data,{
        plot(date_time, sub_metering1, type="l", xlab="", ylab="Energy sub metering")
#add data to the plot
        lines(date_time, sub_metering2, type="l", col="red")
        lines(date_time, sub_metering3, type="l", col="blue")
})
#add legend 
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, col=c("black","red","blue"))

#close the device
dev.off()