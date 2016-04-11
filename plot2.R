library(dplyr)
# read table downloaded to your local directory
hpc_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
# convert date to as.Date format
hpc_data$Date <- as.Date(hpc_data$Date, format = "%d/%m/%Y")
# extract data for 2007-2-1 adn 2007-02-02 
hpc_data_July <- filter(hpc_data,hpc_data$Date == "2007-02-01" | hpc_data$Date == "2007-02-02")
# convert downloaded data into numeric format
hpc_data_July$Global_active_power <- as.numeric(as.character(hpc_data_July$Global_active_power))
ylabel <- "Global Active Power (kilowatts)"
# xlabel <- "Frequency"
# main_title <- "Global Active Power"
# set up x data for plot: first combine date and time to measurement time
hpc_data_July <- transform(hpc_data_July, meas_time=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
x_data <- hpc_data_July$meas_time
y_data <- hpc_data_July$Global_active_power
par(mfrow= c(1,1))
plot(x_data,y_data,type = "l",xlab = "", ylab = ylabel)
# copy to png device and store in local directory
dev.copy(png, file = "plot2.png", width = 480,height = 480)
dev.off()