library(shiny)
library(shinydashboard)
library(DT)
library(googleVis)
library(dplyr)
library(ggplot2)
library(tidyr)


df = read.csv('data/data.csv',stringsAsFactors = F)
questions = read.csv('data/questions.csv',stringsAsFactors = F)

df <- df %>% mutate(Percentage = Greater_Risk_Data_Value)
df <- df %>% mutate(YEAR = as.character(YEAR))
grade_levels = c("Total", "9th", "10th", "11th", "12th")
df <- df %>% mutate(Grade = factor(Grade,
                            levels = grade_levels))
gender_levels = c('Total','Female','Male')
df <- df %>% mutate(Sex = factor(Sex,
                          levels = gender_levels))
