function(input, output, session){
  
  observe({
    unique_subtopic = unique(
      questions[questions$Topic==input$topic_s,'Subtopic'])
    updateSelectizeInput(
      session,'subtopic_s',
      choices = unique_subtopic,
      selected = unique_subtopic[1]
    )
  })
  
  observe({
    unique_question = unique(
      questions[questions$Subtopic==input$subtopic_s,'ShortQuestionText'])
    updateSelectizeInput(
      session,'question_s',
      choices = unique_question,
      selected = unique_question[1]
    )
  })
  
  observe({
    unique_year = unique(df[df$ShortQuestionText
                                   ==input$question_s,'YEAR'])
    updateSelectizeInput(
      session,'year_s',
      choices = unique_year,
      selected = sort(unique_year,decreasing = T)[1]
    )
  })
  
  df_state <- reactive({
    df %>%
    filter(ShortQuestionText == input$question_s,
           YEAR == input$year_s,
           Grade == input$grade_s, 
           Sex == input$gender_s,
           LocationAbbr != 'XX')
  })
  
  output$map <- renderGvis({
    df_state() %>%
    gvisGeoChart('LocationDesc', 'Percentage',
                 options=list(region="US", displayMode="regions",
                              resolution="provinces",
                              width="auto", height="auto"))
  })
  
  output$histogram <- renderPlot(
    df_state() %>%
      ggplot(aes(LocationAbbr,Percentage)) +
      geom_col()
  )
}



