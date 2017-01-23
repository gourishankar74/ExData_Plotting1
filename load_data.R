load_data <- function(){
  
  filename <- "household_power_consumption.txt"
  # Download data, if not there
  if (!file.exists(filename)) { 
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","dataset.zip",method="curl")
    unzip("dataset.zip") 
  }
  
  data <- read.table(filename,
                     header=TRUE,
                     sep=";",
                     colClasses = c("character", "character", rep("numeric",7)),
                     na.strings ="?")
  
  # convert date and time variables to Date/Time classes respectively
  data$Time <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
  data$Date <- as.Date(data$Date, "%d/%m/%Y")
  # only use data from the dates 2007-02-01 and 2007-02-02
  dates <- as.Date(c("2007-02-01", "2007-02-02"), "%Y-%m-%d")
  df <- subset(data, Date %in% dates)
  
  return(df)
}