# Skip the unnecessary lines and read just the data 
# for the related 2 days: 1FEB2017 & 2FEB2007 
skipped <- tail(grep("31/1/2007", readLines("household_power_consumption.txt")),1)
endrow <- tail(grep("^2/2/2007", readLines("household_power_consumption.txt")),1)
powerCons <- read.table("household_power_consumption.txt", 
                        sep = ";", skip = skipped, nrows = endrow-skipped, 
                        stringsAsFactors = F, na.strings = "?")
colnames(powerCons) <- c("Date","Time","Global_active_power","Global_reactive_power",
                         "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2",
                         "Sub_metering_3")
dateAndTime <- strptime(paste(powerCons$Date, powerCons$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
powerCons <- cbind(dateAndTime, powerCons)
png("plot2.png", width = 480, height = 480)
plot(powerCons$Global_active_power~powerCons$dateAndTime, type="l", xlab="", 
     ylab = "Global Active Power (kilowatts)")
dev.off()