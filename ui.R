dashboardPage(
  dashboardHeader(title = 'Youth Risk Behariors'),
  dashboardSidebar(
    sidebarUserPanel(name='Ting Yan'),
    sidebarMenu(
      menuItem('Map',tabName = 'map', icon = icon("map")),
      menuItem('Trend',tabName = 'trend', 
                 icon = icon("chart-line")),
      menuItem('Contingency',tabName = 'contingency', 
               icon = icon("table")),
      menuItem('Data',tabName = 'data', 
               icon = icon("database")),
      menuItem('About',tabName = 'about', 
               icon = icon("question"))
    ),
    selectizeInput(inputId = "topic_s",
                   label = "Select Topic",
                   choices = unique(questions$Topic)),
    selectizeInput(inputId = "subtopic_s",
                   label = "Select Subtopic",
                   choices = unique(questions$Subtopic)),
    selectizeInput(inputId = "question_s",
                   label = "Select Question",
                   choices = unique(questions$ShortQuestionText))
  ),
  dashboardBody(
    tabItems(
      tabItem( 
        tabName = 'map',
        fluidRow(
          box(width = 4, height = 90,status = "primary", solidHeader = TRUE,
              selectizeInput(inputId = "year_s",
                         label = "Select Year",
                         choices = sort(unique(df$YEAR),decreasing = T)
          )),
          box(width = 4, height = 90,status = "primary", solidHeader = TRUE,
              selectizeInput(inputId = "gender_s",
                         label = "Select Gender",
                         choices = c('Total','Male','Female')
          )),
          box(width = 4, height = 90,status = "primary", solidHeader = TRUE,
              selectizeInput(inputId = "grade_s",
                         label = "Select Grade",
                         choices = c('Total','12th','11th','10th','9th')
          ))
        ),
        fluidRow(box(htmlOutput("map"),width = 12)),
        fluidRow(box(htmlOutput("histogram"),width = 12))
      ), # end of tabItem - map
      tabItem(
        tabName = 'trend'
      ), # end of tabItem -trend
      tabItem(
        tabName = 'contingency'
      ), # end of tabItem - contingency
      tabItem(
        tabName = 'data'
      ), # end of tabItem - data
      tabItem(
        tabName = 'about'
      ) # end of tabItem - about
    ) # end of tabItems
  ) # end of dashboardBody
) # end of dashboardPage

