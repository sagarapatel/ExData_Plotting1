
# Read text data first 80000 rows for quick processing
epc <- read.table('./R Data/C4W1A1/data household_power_consumption/household_power_consumption.txt', header = TRUE, sep = ';', nrow = 80000)

# Merge Date and Time into one Column
epc$Date_Time <- paste(epc$Date, epc$Time) 
epc$Date_Time <- strptime(epc$Date_Time, "%d/%m/%Y %H:%M:%S")
epc$Date <- as.Date(epc$Date, '%d/%m/%Y')

# Selected dates
selected_epc <- subset(epc, Date >= '2007-02-01' & Date <= '2007-02-02')

# Convert factors into numbers
# Sub_metering_3 is already numbers
selected_epc$Sub_metering_1 <- as.numeric(as.character(selected_epc$Sub_metering_1))
selected_epc$Sub_metering_2 <- as.numeric(as.character(selected_epc$Sub_metering_2))
selected_epc$Voltage <- as.numeric(as.character(selected_epc$Voltage))
selected_epc$Global_active_power <- as.numeric(as.character(selected_epc$Global_active_power))
selected_epc$Global_reactive_power <- as.numeric(as.character(selected_epc$Global_reactive_power))

# Plot charts into two rows and two columns
par(mfrow = c(2,2))

# Plot 1st Graph
plot(selected_epc$Date_Time, selected_epc$Global_active_power, xlab = '', ylab = 'Global Active Power' , type = 'l')

# Plot 2nd Graph
with(selected_epc, plot(Date_Time, Voltage, xlab = 'datetime', ylab = 'Voltage', type = 'l'))

# Plot 3rd Graph
with(selected_epc, plot(Date_Time, Sub_metering_1, xlab = '', ylab = 'Energy sub metering', type = 'n'))

lines(selected_epc$Date_Time, selected_epc$Sub_metering_1, type="l")
lines(selected_epc$Date_Time, selected_epc$Sub_metering_2, type="l", col = 'red')
lines(selected_epc$Date_Time, selected_epc$Sub_metering_3, type="l", col = 'blue')

legend('topright', pch = 151, col=c('black','red','blue'), legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), bty = 'n', cex = 0.8)

# Plot 4th Graph
with(selected_epc, plot(Date_Time, Global_reactive_power, xlab = 'datetime', type = 'l', cex.axis = 0.8))

# Export to png file
# Graphs are by default 480 x 480 pixel in size
dev.copy(png, './R Data/C4W1A1/plot4.png')
dev.off()