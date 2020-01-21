library(shiny)
library(shinydashboard)
library(DT)
library(googleVis)
library(dplyr)


df = read.csv('data/data.csv')

# make a list here to reduce runtime
question <- unique(df$QuestionCode)

# need to list choices based on question
year <- unique(df$YEAR)
