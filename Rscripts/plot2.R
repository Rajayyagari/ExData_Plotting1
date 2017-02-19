## load the text file into data frame..
power <- read.csv("household_power_consumption.txt", sep=";", head= TRUE, stringsAsFactors = FALSE)
## cretae a vector of dates to work with..
dtv <- as.Date(c("2007-02-01", "2007-02-02"))
library(dplyr)
## Filter the data for the given dates..
fdf <- filter(power, as.Date(Date, "%d/%m/%Y") %in% as.Date(dtv))
##Create a date/time into a new column in data frame..
fdf <- mutate(fdf, newdate = as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))


## Open the PNG device..
png(filename = "plot2.png",width=480, height=480, units="px", bg="white")

## lineplot Global Active POwer vs. DateTime..
plot (as.numeric(fdf$Global_active_power)~newdate,fdf, type = "l", xlab = "", ylab = "Global active power (kilowatts)")

dev.off()
