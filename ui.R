dashboardPage(
  dashboardHeader(title = 'Youth Mental Health'),
  dashboardSidebar(
    sidebarUserPanel(name='Ting Yan'),
    sidebarMenu(
      menuItem('Map',tabName = "map", icon = icon("map")),
      menuItem('Chart',tabName = 'chart', 
                 icon = icon("chart-bar"))
    ),
    selectizeInput("q_selected",
                    "Select Question to Display",
                    question),
    selectizeInput("y_selected",
                   "Select Year to Display",
                   year)
  ),
  dashboardBody(
     fluidRow(box(htmlOutput("map"),width=12))
  )
)

