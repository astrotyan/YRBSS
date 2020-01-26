dashboardPage(
  dashboardHeader(title = 'Youth Risk Behariors'),
  dashboardSidebar(
    sidebarMenu(
      menuItem('Map',tabName = 'map', icon = icon("map")),
      menuItem('Trend',tabName = 'trend', 
                 icon = icon("chart-line")),
      menuItem('Correlation',tabName = 'correlation', 
               icon = icon("table")),
      menuItem('About',tabName = 'about', 
               icon = icon("question"))
    ),
    selectizeInput(inputId = "topic_s",
                   label = "Select Topic",
                   choices = sort(unique(questions$Topic))),
    selectizeInput(inputId = "subtopic_s",
                   label = "Select Subtopic",
                   choices = sort(unique(questions$Subtopic))),
    selectizeInput(inputId = "question_s",
                   label = "Select Question",
                   choices = sort(unique(questions$ShortQuestionText))),
    textOutput("description")
  ),
  dashboardBody(
    tabItems(
      tabItem( 
        tabName = 'map',
        fluidRow(
        #   box(title = 'Description', width = 12, 
        #       solidHeader = TRUE, status = "primary",
        #       textOutput("description")),
          box(width = 4, height = 90,status = "primary", solidHeader = TRUE,
              selectizeInput(inputId = "year_s",
                         label = "Select Year",
                         choices = sort(unique(df$YEAR),decreasing = T)
          )),
          box(width = 4, height = 90,status = "primary", solidHeader = TRUE,
              selectizeInput(inputId = "gender_s",
                         label = "Select Gender",
                         choices = gender_levels
          )),
          box(width = 4, height = 90,status = "primary", solidHeader = TRUE,
              selectizeInput(inputId = "grade_s",
                         label = "Select Grade",
                         choices = grade_levels
          )),
          tabBox(tabPanel('Map',htmlOutput("map")),
                 tabPanel('Histogram',plotOutput("histogram")),
                 tabPanel('Boxplot',plotOutput('boxplot')),
                 width = 12)
        ) # end of fluidRow
      ), # end of tabItem - map
      tabItem(
        tabName = 'trend',
        fluidRow(
          box(width = 4, height = 90,status = "primary", solidHeader = TRUE,
              selectizeInput(inputId = "state_c",
                             label = "Select State",
                             choices = sort(unique(df$LocationDesc)),
                             selected = 'United States'
              )),
          box(width = 4, height = 90,status = "primary", solidHeader = TRUE,
              selectizeInput(inputId = "gender_c",
                            label = "Select Gender",
                            choices = gender_levels
              )),
          box(width = 4, height = 90,status = "primary", solidHeader = TRUE,
              selectizeInput(inputId = "grade_c",
                            label = "Select Grade",
                            choices = grade_levels
              )),
          tabBox(tabPanel('Trend', plotOutput('bar')),
                 tabPanel('By Gender', plotOutput('bar_gender')),
                 tabPanel('By Grade', plotOutput('bar_grade')),
                 width = 12)
        ) # end of fluidRow
      ), # end of tabItem -trend
      tabItem(
        tabName = 'correlation',
        fluidRow(
          box(width = 4, height = 100,status = "primary", solidHeader = TRUE,
              selectizeInput(inputId = "topic_r",
                         label = "Select Topic",
                         choices = sort(unique(questions$Topic)))),
          box(width = 4, height = 100,status = "primary", solidHeader = TRUE,
              selectizeInput(inputId = "subtopic_r",
                         label = "Select Subtopic",
                         choices = sort(unique(questions$Subtopic)))),
          box(width = 4, height = 100,status = "primary", solidHeader = TRUE,
              selectizeInput(inputId = "question_r",
                         label = "Select Question",
                         choices = sort(unique(questions$ShortQuestionText)))),
          box(width = 12,textOutput("description_r")),
          box(width = 3, height = 90,status = "primary", solidHeader = TRUE,
              selectizeInput(inputId = "state_r",
                             label = "Select State",
                             choices = sort(unique(df$LocationDesc)),
                             selected = 'United States'
              )),
          box(width = 3, height = 90,status = "primary", solidHeader = TRUE,
              selectizeInput(inputId = "year_r",
                             label = "Select Year",
                             choices = sort(unique(df$LocationDesc)),
                             selected = sort(unique(df$YEAR),decreasing = T)
              )),
          box(width = 3, height = 90,status = "primary", solidHeader = TRUE,
              selectizeInput(inputId = "gender_r",
                             label = "Select Gender",
                             choices = gender_levels
              )),
          box(width = 3, height = 90,status = "primary", solidHeader = TRUE,
              selectizeInput(inputId = "grade_r",
                             label = "Select Grade",
                             choices = grade_levels
              )),
          tabBox(tabPanel('By Time', plotOutput('scatter')),
                 tabPanel('Time and Gender', plotOutput('scatter_gender')),
                 tabPanel('Time and Grade', plotOutput('scatter_grade')),
                 tabPanel('By State', plotOutput('scatter_state')),
                 tabPanel('State and Gender', plotOutput('scatter_gender_state')),
                 tabPanel('State and Grade', plotOutput('scatter_grade_state')),
                 width = 12)
        ) # end of fluidRow
      ), # end of tabItem - correlation
      tabItem(
        tabName = 'about',
        fluidRow(
          box(width = 12, title = 'Youth Risk Behavior Surveillance System',
              status = "primary", solidHeader = TRUE,
              textOutput('yrbss')),
          box(width = 12, title = 'Source Code',
              status = "primary", solidHeader = TRUE,
              textOutput('source'))
        ) # end of fluidRow
      ) # end of tabItem - about
    ) # end of tabItems
  ) # end of dashboardBody
) # end of dashboardPage

