## Reading house
house <- read.table('household_power_consumption.txt', header = T, sep = ';', stringsAsFactors = F, na.strings = '?', skip = 66636, nrow = 2880)

colnames(house) <- c('Date', 'Time', 'Global_active_power', 'Global_reactive_power', 'Voltage', 'Global_intensity', 'Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3')

## Merging Date and Time columns into one vector
datetime <- strptime(paste(house$Date, house$Time, sep = ' '), format = '%d/%m/%Y %H:%M:%S')

## Build a new house frame with only the required data
house <- data.frame(datetime, house[, 7:9])



## Draw the histogram of plot 3 in a png file
png('plot3.png', bg = 'transparent')
### Set days names to english
Sys.setlocale(category = "LC_TIME", locale = "en_GB.UTF-8")
with(house,{
  plot(Sub_metering_1 ~ datetime, col = c('black', 'red', 'blue'), type='l', xlab='', ylab='Energy sub metering')
  lines(Sub_metering_2 ~ datetime, col = 'red')
  lines(Sub_metering_3 ~ datetime, col = 'blue')
  legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col=c('black', 'red', 'blue'), lty = 1, lwd = 1)
}
)
dev.off()