library(dplyr)
# read table downloaded to your local directory
hpc_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
# convert date to as.Date format
hpc_data$Date <- as.Date(hpc_data$Date, format = "%d/%m/%Y")
# extract data for 2007-2-1 adn 2007-02-02 
hpc_data_July <- filter(hpc_data,hpc_data$Date == "2007-02-01" | hpc_data$Date == "2007-02-02")
# convert downloaded data into numeric format
hpc_data_July$Global_active_power <- as.numeric(as.character(hpc_data_July$Global_active_power))
xlabel <- "Global Active Power (kilowatts)"
ylabel <- "Frequency"
main_title <- "Global Active Power"
# construct histogram
hist(hpc_data_July$Global_active_power,main = main_title,col="red",xlab = xlabel)
# copy to png device and store in local directory
dev.copy(png, file = "plot1.png", width = 480,height = 480)
dev.off()