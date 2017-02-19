## load the text file into data frame..
power <- read.csv("household_power_consumption.txt", sep=";", head= TRUE, stringsAsFactors = FALSE)
## cretae a vector of dates to work with..
dtv <- as.Date(c("2007-02-01", "2007-02-02"))
library(dplyr)
## Filter the data for the given dates..
fdf <- filter(power, as.Date(Date, "%d/%m/%Y") %in% as.Date(dtv))
##Create a date/time into a new column in data frame..
fdf <- mutate(fdf, newdate = as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))

## fdf_subM <- gather(fdf, sub_meter, meterReading, as.numeric(Sub_metering_1:Sub_metering_3))
## plot (as.numeric(fdf$Global_active_power)~newdate,fdf, type = "l", xlab = "", ylab = "Global active power (kilowatts)")
## library (readr)
## library (readr)
## fdf_subM <- mutate(fdf_subM, sub_meter = parse_number(sub_meter))

# Create a vector of the colors needed.. 
png(filename = "plot4.png",width=480, height=480, units="px", bg="white")

par(mfcol = c(2,2))

#first square [1,1] is filled.
plot (as.numeric(fdf$Global_active_power)~newdate,fdf, type = "l", xlab = "", ylab = "Global active power (kilowatts)")

#filled second instance.. [1,2] is filled.
plot(x=fdf$newdate, y=as.numeric(fdf$Sub_metering_1),  ylim= c(0, 40), ylab = "Energy Sub metereing", xlab = "", type = "l")
lines(y=as.numeric(fdf$Sub_metering_2), x=fdf$newdate, col=c1[2], lwd=2.5)
lines(y=as.numeric(fdf$Sub_metering_3), x=fdf$newdate, col=c1[3], lwd=2.5)
legend("topright", col=c1, c("Sub_Metering_1", "Sub_Metereing_2", "Sub_Metering_3"), cex= 0.70, lty=c(1), lwd=c(2.5))

#right top square.. 
plot (as.numeric(fdf$Voltage)~newdate,fdf, type = "l", xlab = "datetime", ylab = "Voltage")

#bottom right square ..
# As such from the diagram no xlab and ylap are not set.since I used fdf$
plot (as.numeric(fdf$Global_reactive_power)~newdate,fdf, type = "l", xlab = "datetime", ylab = "Global Reactive Power")


dev.off()