# Input: pre1.csv
# Output: data.csv & questions.csv

library(dplyr)

raw = read.csv('data/pre1.csv',stringsAsFactors = F)

questions <- raw %>%
  select(Topic,TopicId,Subtopic,SubTopicID,
         ShortQuestionText,QuestionCode,
         Greater_Risk_Question,Description,
         Lesser_Risk_Question,) %>%
  unique()

write.csv(questions,file='data/questions.csv',row.names=F)

data <- raw %>%
  filter(LocationAbbr %in% state.abb | LocationAbbr == 'XX') %>%
  select(YEAR,LocationAbbr,LocationDesc,ShortQuestionText,
         Greater_Risk_Data_Value,Greater_Risk_Low_Confidence_Limit,
         Greater_Risk_High_Confidence_Limit,
         Lesser_Risk_Data_Value,Lesser_Risk_Low_Confidence_Limit,
         Lesser_Risk_High_Confidence_Limit,
         Sample_Size,Sex,Grade,Race,GeoLocation,
         TopicId,SubTopicID,QuestionCode)
         

write.csv(data,file='data/data.csv',row.names=F)

