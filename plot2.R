library(sqldf)

date1 <- "'1/2/2007'"
date2 <- "'2/2/2007'"
inFile <- "household_power_consumption.txt"

query <- paste("select * from file where Date =", date1, "or Date =", date2)

twoDays <- read.csv.sql(inFile, sql = query, sep = ";")
twoDays$Date <- as.Date(twoDays$Date, format = "%d/%m/%Y")
twoDays$Time <- strptime(paste(twoDays$Date, twoDays$Time),
                        format = "%Y-%m-%d %H:%M:%S")

png(filename = "plot2.png", width = 480, height = 480)
with(twoDays,
     plot(Time, Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)"))
dev.off()