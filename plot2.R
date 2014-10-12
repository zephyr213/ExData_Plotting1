# define some critical dates
Date1 <- as.Date("2007-02-01")
Date2 <- as.Date("2007-02-02")
Date3 <- as.Date("2007-02-03")

# read first column to determine the rows needed to import
data0 <- read.table("./household_power_consumption.txt", header = TRUE, sep=";", 
                    colClasses = c("character",rep("NULL",8)))
data0["Date"] <- as.Date(data0$Date, "%d/%m/%Y")

rowhead <- match(Date1, data0$Date)
rowend <- match(Date3, data0$Date) - 1

nrow <- rowend - rowhead + 1  # total rows to read
nrow0 <- length(data0[data0$Date==Date1 | data0$Date==Date2,1])

if (nrow != nrow0)  print("Error!")  # Make sure the dates are consecutive in the column

# Now read the first line to extract names of data frame
data1 <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", 
                    stringsAsFactors = FALSE, nrows = 1)
name <- names(data1)

# Reading the rows needed for the 2 days
mydata <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", 
                     stringsAsFactors = FALSE, nrows = nrow, col.names = name, skip = rowhead - 1)
# make new Date/Time class from Date and Time
mydata["DateTime"] <- paste(mydata$Date, mydata$Time)
mydata$DateTime <- strptime(mydata$DateTime, "%d/%m/%Y %H:%M:%S")

# Now start ploting plot2.png

png(filename = "./plot2.png",
    width = 480,
    height = 480,
    units = "px")
plot(mydata$DateTime, mydata$Global_active_power, 
     type = "n", 
     main = NULL, xlab = "", 
     ylab = "Global Active Power (kilowatts)" )
lines(mydata$DateTime, mydata$Global_active_power)
dev.off()