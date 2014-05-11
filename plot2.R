## Reading Relevent house
house <- read.table('household_power_consumption.txt', header = T, sep = ';', stringsAsFactors = F, na.strings = '?', skip = 66636, nrow = 2880)

colnames(house) <- c('Date', 'Time', 'Global_active_power', 'Global_reactive_power', 'Voltage', 'Global_intensity', 'Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3')

## Merging Date and Time columns into one vector
datetime <- strptime(paste(house$Date, house$Time, sep = ' '), format = '%d/%m/%Y %H:%M:%S')

## Build a new house frame with only the required house for plot 2
house <- data.frame(datetime, house[,3:3])

## Name the columns appropriately
colnames(house) <- c('datetime', 'Global_Active_power')

## Draw plot 2 in a png file
png('plot2.png', bg = 'transparent')
### Set days names to english
Sys.setlocale(category = "LC_TIME", locale = "en_GB.UTF-8")
with(house,
     ### xlabel is the default label
     plot(datetime, Global_Active_power, type = 'l', ylab = 'Global Active Power (kilowatts)', xlab = '')
)
dev.off()