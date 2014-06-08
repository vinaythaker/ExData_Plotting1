library(data.table)
library(lubridate)

# define the column classes 
col <- c(rep("character", 2), rep("numeric", 7))

#Read the file as a data.table
dt1 <- fread ("household_power_consumption.txt", colClasses=col, header=TRUE, sep=";", stringsAsFactors=FALSE, na.strings=c("?"), showProgress=FALSE)

#Convert the time column from character to a posix data time
dt1$Date1 <- mdy(dt1$Date)

#merging data for the Feb 1 2007 & Feb 2 2007
dt2 <- rbind(subset(dt1, Date1 == mdy("02-01-2007")), subset(dt1, Date1 == mdy("02-02-2007")))

# formatting the columns. appears to be a defect in data.table
dt2$DateTime <- mdy_hms(paste(dt2$Date,dt2$Time, sep= " "))
dt2$Global_active_power <- as.numeric(dt2$Global_active_power)
dt2$Global_reactive_power <- as.numeric(dt2$Global_reactive_power)
dt2$Voltage <- as.numeric(dt2$Voltage)
dt2$Global_intensity <- as.numeric(dt2$Global_intensity)
dt2$Sub_metering_1 <- as.numeric(dt2$Sub_metering_1)
dt2$Sub_metering_2 <- as.numeric(dt2$Sub_metering_2)
dt2$Sub_metering_3 <- as.numeric(dt2$Sub_metering_3)

# open the PNG file
png(filename="plot2.png",width=480,height=480)

# Create Plot2
#Plot2
par(font.lab=1, cex.lab=0.8, cex.axis=0.8, pty="s", family="sans")
plot(x=dt2$DateTime, y=dt2$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

# turn of the device and save the file
dev.off()