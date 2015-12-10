library(sqldf)

date1 <- "'1/2/2007'"
date2 <- "'2/2/2007'"
inFile <- "household_power_consumption.txt"

query <- paste("select * from file where Date =", date1, "or Date =", date2)

twoDays <- read.csv.sql(inFile, sql = query, sep = ";")
twoDays$Date <- as.Date(twoDays$Date, format = "%d/%m/%Y")
twoDays$Time <- strptime(paste(twoDays$Date, twoDays$Time),
                         format = "%Y-%m-%d %H:%M:%S")

png(filename = "plot4.png", width = 480, height = 480)
par(mfcol = c(2,2))

with(twoDays,
     plot(Time, Global_active_power,
          type = "l",
          xlab = "",
          ylab = "Global Active Power"))

with(twoDays,
     plot(Time, Sub_metering_1,
          type = "l",
          xlab = "",
          ylab = "Energy sub metering"))
with(twoDays, lines(Time, Sub_metering_2, col = "red"))
with(twoDays, lines(Time, Sub_metering_3, col = "blue"))
legend("topright",
       lty = 1,
       lwd = 1.5,
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n")

with(twoDays,
     plot(Time, Voltage,
          type = "l",
          xlab = "datetime",
          ylab = "Voltage"))

with(twoDays,
     plot(Time, Global_reactive_power,
          type = "l",
          xlab = "datetime"))
dev.off()