library(shiny)
library(shinydashboard)
library(DT)
library(googleVis)
library(dplyr)


df = read.csv('data/data.csv',stringsAsFactors = F)
questions = read.csv('data/questions.csv',stringsAsFactors = F)

df <- df %>% mutate(Percentage = Greater_Risk_Data_Value)
df <- df %>% mutate(YEAR = as.character(YEAR))

