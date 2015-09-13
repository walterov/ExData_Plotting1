library(data.table)
library(datasets)

## Download data file
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile(tmpdir = "./")
download.file(url, temp, mode="wb")
## Create vector with Column names
variables=c("Date","Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", 
            "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
## Read data from downloaded zip file
## Only read the data for the two days required for this plot
elecData=read.table(unz(temp, "household_power_consumption.txt"), 
                    header = TRUE, 
                    col.names = variables, 
                    check.names = TRUE, 
                    skip = 66636, nrows = 2880, sep = ";")
unlink(temp)    ## Close the file connection
## Convert Data and Time to Data/Time data type
x = paste(elecData$Date,elecData$Time)
elecData$DateTime = strptime(x, "%d/%m/%Y %H:%M:%S")
## Create plot
par(cex.main = 3/4)
par(cex.lab = 3/4)
par(cex.axis = 3/4)
hist(elecData$Global_active_power, col = "red", main= "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
## Copy Histogram to a PNG file
dev.copy(device  = png, file = "plot1.png", width = 480, height = 480)                       
dev.off()      ## Close the PNG device
