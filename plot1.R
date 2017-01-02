#define the file
thefile <- "./data/household_power_consumption.txt"

#read the file
thedata <- read.table(thefile, header=TRUE, sep=";", na.string="?")

#subset data to contain only the important period
subset_data <- subset(thedata, Date %in% c("1/2/2007","2/2/2007"))
rm(thedata)

#open a png device
png("plot1.png", width=480, height=480)

#plot Global_active_power as a histogram, use as.numeric(), because R says it's not numeric
global_active_power <- as.numeric(subset_data$Global_active_power)
hist(global_active_power, col="red",main="Global Active Power", xlab="Global Active Power (kilowatts)")

#close the device
dev.off()