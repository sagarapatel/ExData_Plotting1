
# Read text data first 80000 rows for quick processing
epc <- read.table('./R Data/C4W1A1/data household_power_consumption/household_power_consumption.txt', header = TRUE, sep = ';', nrow = 80000)

# Change Date column into Date format
epc$Date <- as.Date(epc$Date, '%d/%m/%Y')

# Selected dates
selected_epc <- subset(epc, Date >= '2007-02-01' & Date <= '2007-02-02')

# Convert factors into numbers
selected_epc$Global_active_power <- as.numeric(as.character(selected_epc$Global_active_power))

# Create Histogram using base plotting system
hist(selected_epc$Global_active_power, col = 'red', main = 'Global Active Power', xlab = 'Global Active Power (kilowatts)')

# Export to png file
# Graphs are by default 480 x 480 pixel in size
dev.copy(png, './R Data/C4W1A1/plot1.png')
dev.off()

