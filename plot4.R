library(dplyr)
# read table downloaded to your local directory
hpc_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
# convert date to as.Date format
hpc_data$Date <- as.Date(hpc_data$Date, format = "%d/%m/%Y")
# extract data for 2007-02-01 and 2007-02-02 
hpc_data_July <- filter(hpc_data,hpc_data$Date == "2007-02-01" | hpc_data$Date == "2007-02-02")
# convert downloaded data into numeric format
hpc_data_July$Global_active_power <- as.numeric(as.character(hpc_data_July$Global_active_power))
hpc_data_July$Voltage <- as.numeric(as.character(hpc_data_July$Voltage))
hpc_data_July$Global_reactive_power <- as.numeric(as.character(hpc_data_July$Global_reactive_power))
hpc_data_July$Sub_metering_1 <- as.numeric(as.character(hpc_data_July$Sub_metering_1))
hpc_data_July$Sub_metering_2 <- as.numeric(as.character(hpc_data_July$Sub_metering_2))
hpc_data_July$Sub_metering_3 <- as.numeric(as.character(hpc_data_July$Sub_metering_3))
# set up appropriate labels
ylabel1 <- "Global Active Power (kilowatts)"
ylabel3 <- "Energy Sub metering"
ylabel2 <- "Voltage"
ylabel4 <- "Global Reactive Power"

xlabel34 <- "datetime"

# set up x data for plot: first combine date and time to measurement time
hpc_data_July <- transform(hpc_data_July, meas_time=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
x_data <- hpc_data_July$meas_time
y_data1 <- hpc_data_July$Global_active_power
y_data2 <- hpc_data_July$Voltage
y_data3 <- hpc_data_July$Sub_metering_1
y_data4 <- hpc_data_July$Global_reactive_power

# set up grid for plot
par(mfrow= c(2,2))
# SET UP first PLOT
plot(x_data,y_data1,type = "l",xlab = "", ylab = ylabel1)
# set up voltage plot
plot(x_data,y_data2,type = "l",xlab = "", ylab = ylabel2)
# set up sub metering plot
plot(x_data,y_data3,type = "l",xlab = xlabel34, ylab = ylabel3)
# add other sub metering plots
lines(x_data, hpc_data_July$Sub_metering_2, col = "red")
lines(x_data, hpc_data_July$Sub_metering_3, col = "blue")
# add legend
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))
# plot gloabl reactive power data
plot(x_data,y_data4,type = "l",xlab = xlabel34, ylab = ylabel4)
# copy to png device and store in local directory
dev.copy(png, file = "plot4.png", width = 480,height = 480)
dev.off()