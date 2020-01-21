# Input: pre1.csv
# Output: data.csv

raw = read.csv('data/pre1.csv',stringsAsFactors = F)

questions = c('H23','H24','H25','H26','H68','H69','QNOWT',
            'H79','QNPA0DAY','QNPA7DAY','H83','H80','H81',
            'H88') 

# H23: During the past 12 months, have you ever been bullied on school property?
# H24: During the past 12 months, have you ever been electronically bullied? (Count being
# bullied through texting, Instagram, Facebook, or other social media.)
# 
# H25: During the past 12 months, did you ever feel so sad or hopeless almost every day for two
# weeks or more in a row that you stopped doing some usual activities?
# H26: During the past 12 months, did you ever seriously consider attempting suicide?
# 
# H68: Described themselves as slightly or very overweight
# H69: Were not trying to lose weight (Were trying to lose weight???)
# QNOWT: Were overweight
# 
# H79: Were physically active at least 60 minutes per day on 5 or more days (???)
# QNPA0DAY: Were not physically active for a total of at least 60 minutes on at least 1 day
# QNPA7DAY: Were not physically active at least 60 minutes per day on all 7 days
# H83: Did not play on at least one sports team
# 
# H80: Watched television 3 or more hours per day
# H81: Played video or computer games or used a computer 3 or more hours per day

# H88: Did not get 8 or more hours of sleep


library(dplyr)
data <- raw %>%
  filter(! is.na(raw$Greater_Risk_Data_Value),
         QuestionCode %in% questions,
         LocationAbbr %in% state.abb | LocationAbbr == 'XX')

write.csv(data,file='data/data.csv',row.names=F)

