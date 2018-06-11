
# Read text data first 80000 rows for quick processing
epc <- read.table('./R Data/C4W1A1/data household_power_consumption/household_power_consumption.txt', header = TRUE, sep = ';', nrow = 80000)

# Merge Date and Time into one Column
epc$Date_Time <- paste(epc$Date, epc$Time) 
epc$Date_Time <- strptime(epc$Date_Time, "%d/%m/%Y %H:%M:%S")
epc$Date <- as.Date(epc$Date, '%d/%m/%Y')

# Selected dates
selected_epc <- subset(epc, Date >= '2007-02-01' & Date <= '2007-02-02')

# Convert factor into numeric
selected_epc$Global_active_power <- as.numeric(as.character(selected_epc$Global_active_power))

# Plot a line Graph for two days
with(selected_epc, plot(Date_Time, Global_active_power, xlab = '', ylab = 'Global Active Power (kilowatt)' , type = 'l'))

# Export to png file
# Graphs are by default 480 x 480 pixel in size
dev.copy(png, './R Data/C4W1A1/plot2.png')
dev.off()
