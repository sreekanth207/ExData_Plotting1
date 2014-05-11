## Reading Relevent house
house <- read.table('household_power_consumption.txt', header = T, sep = ';', stringsAsFactors = F, na.strings = '?', skip = 66636, nrow = 2880)

colnames(house) <- c('Date', 'Time', 'Global_active_power', 'Global_reactive_power', 'Voltage', 'Global_intensity', 'Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3')

## Merging Date and Time columns into one vector
datetime <- strptime(paste(house$Date, house$Time, sep=' '), format = '%d/%m/%Y %H:%M:%S')

## Build a new house frame with only the required house for plot 4
house <- data.frame(datetime, house[, c(3:5,7:9)])

## Draw the histogram of plot 4 in a png file
png('plot4.png', bg = 'transparent')
### Set days names to english
Sys.setlocale(category = "LC_TIME", locale = "en_GB.UTF-8")
par(mfrow=c(2,2))

with(house,{
  ### First Graph
  plot(Global_active_power ~ datetime, type = 'l', xlab = '', ylab = 'Global Active Power')
  
  ### Second graph. No need to specify xlabel and ylabel
  plot(Voltage ~ datetime, type = 'l')
  
  ### Third Graph
  plot(Sub_metering_1 ~ datetime, col = c('black', 'red', 'blue'), type = 'l', xlab = '', ylab = 'Energy sub metering')
  lines(Sub_metering_2 ~ datetime, col = 'red')
  lines(Sub_metering_3 ~ datetime, col = 'blue')
  legend('topright', bty = 'n', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col=c('black', 'red', 'blue'), lty = 1, lwd = 1, cex=0.95)
  
  ### Fourth Graph. No need to specify xlabel and ylabel
  plot(Global_reactive_power ~ datetime, type = 'l')
}
)
dev.off()