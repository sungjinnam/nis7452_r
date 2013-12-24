#load raw data
raw.tweets <- read.csv(file='data//1_tweets.csv', header=TRUE, stringsAsFactors=FALSE, 
                       col.names=c('id', 'week', 'date', 'time', 'contents', 'category'), 
                       colClasses=c('numeric', 'factor', 'character', 'character', 'character', 'character'));
raw.tweets$date <- as.Date(raw.tweets$date, format="%m/%d/%y")
raw.tweets$time <- as.POSIXct(raw.tweets$time, format="%H:%M:%S")
raw.tweets$category <- as.factor(gsub(" $", "", raw.tweets$category))

#graph
library('reshape2')
library('ggplot2')

freq.week <- data.frame(do.call(cbind, tapply(raw.tweets$week, raw.tweets$category, table)))
freq.week$week <- rownames(freq.week)
freq.week.melt <- melt(freq.week)
ggplot(data=freq.week.melt, aes(x=week, y=value, color=variable, group=variable, fill=variable)) + geom_area(position='stack') + 
  theme(text = element_text(family="Apple SD Gothic Neo"))
