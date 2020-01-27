function(input, output, session){
  
  observe({
    unique_subtopic = sort(unique(
      questions[questions$Topic==input$topic_s,'Subtopic']))
    updateSelectizeInput(
      session,'subtopic_s',
      choices = unique_subtopic,
      selected = unique_subtopic[1]
    )
  })
  
  observe({
    unique_question = sort(unique(
      questions[questions$Subtopic==input$subtopic_s,'ShortQuestionText']))
    updateSelectizeInput(
      session,'question_s',
      choices = unique_question,
      selected = unique_question[1]
    )
  })
  
  observe({
    unique_year = sort(unique(df[df$ShortQuestionText
                                   ==input$question_s,'YEAR']),
                       decreasing = T)
    updateSelectizeInput(
      session,'year_s',
      choices = unique_year,
      selected = sort(unique_year,decreasing = T)[1]
    )
  })
  
  observe({
    unique_state = sort(unique(df[df$ShortQuestionText
                                 ==input$question_s,
                                 'LocationDesc']))  
    updateSelectizeInput(
      session,'state_s',
      choices = unique_state,
      selected = 'United States'
    )
  })
  
  observe({
    unique_subtopic_r = sort(unique(
      questions[questions$Topic==input$topic_r,'Subtopic']))
    updateSelectizeInput(
      session,'subtopic_r',
      choices = unique_subtopic_r,
      selected = unique_subtopic_r[1]
    )
  })
  
  observe({
    unique_question_r = sort(unique(
      questions[questions$Subtopic==input$subtopic_r,'ShortQuestionText']))
    updateSelectizeInput(
      session,'question_r',
      choices = unique_question_r,
      selected = unique_question_r[1]
    )
  })
  
  observe({
    unique_state_r = sort(unique(df[df$ShortQuestionText
                                    ==input$question_r,
                                    'LocationDesc']))  
    updateSelectizeInput(
      session,'state_r',
      choices = unique_state_r,
      selected = 'United States'
    )
  })
  
  observe({
    unique_year_r = sort(unique(df[df$ShortQuestionText
                                 ==input$question_r,'YEAR']),
                       decreasing = T)
    updateSelectizeInput(
      session,'year_r',
      choices = unique_year_r,
      selected = sort(unique_year_r,decreasing = T)[1]
    )
  })
  
  output$description <- renderText({
    paste(questions[questions$ShortQuestionText 
              == input$question_s,'Greater_Risk_Question'],
           questions[questions$ShortQuestionText 
              == input$question_s,'Description'])
  })
  
  output$description_r <- renderText({
    paste(questions[questions$ShortQuestionText 
                    == input$question_r,'Greater_Risk_Question'],
          questions[questions$ShortQuestionText 
                    == input$question_r,'Description'])
  })
  
  df_state <- reactive({
    df %>%
    filter(ShortQuestionText == input$question_s,
           YEAR == input$year_s,
           LocationAbbr != 'XX')
  })
  
  output$map <- renderGvis({
    df_state() %>%
      filter(Grade == input$grade_s, 
             Sex == input$gender_s) %>%
      gvisGeoChart('LocationDesc', 'Percentage',
                   options=list(region="US", displayMode="regions",
                                resolution="provinces",
                                width="auto", height="auto"))
  })
  
  output$histogram <- renderPlot({
    df_state() %>%
      filter(Grade == input$grade_s, 
             Sex == input$gender_s) %>%
      ggplot(aes(Percentage)) +
      geom_histogram(bins = 10, fill = '#368DB8')
  })
  
  output$boxplot <- renderPlot({
    df_state() %>%
      ggplot(aes(Grade,Percentage)) +
      geom_boxplot(aes(fill=Sex),position='dodge')
  })
  
  df_trend <- reactive({
    df %>%
      filter(ShortQuestionText == input$question_s,
             LocationDesc == input$state_c
             )
  })

  output$bar <- renderPlot({
    df_trend() %>%
      filter(Grade == input$grade_c, 
             Sex == input$gender_c) %>%
      ggplot(aes(YEAR,Percentage)) +
      geom_col(fill = '#368DB8')
  })
  
  output$bar_gender <- renderPlot({
    df_trend() %>%
      filter(Grade == input$grade_c) %>%
      mutate(YEAR = as.numeric(YEAR)) %>%
      ggplot(aes(YEAR,Percentage)) +
      geom_point(aes(color=Sex),na.rm=T, size=3) +
      geom_smooth(aes(color = Sex), se = FALSE)
  })
  
  output$bar_grade <- renderPlot({
    df_trend() %>%
      filter(Sex == input$gender_c) %>%
      mutate(YEAR = as.numeric(YEAR)) %>%
      ggplot(aes(YEAR,Percentage))  +
      geom_point(aes(color=Grade),na.rm=T, size=3) +
      geom_smooth(aes(color = Grade), se = FALSE)
  })
  
  df_correlation <- reactive({
    df %>%
      filter(ShortQuestionText == input$question_s |
             ShortQuestionText == input$question_r,
             LocationDesc == input$state_r
      )
  })

  output$scatter <- renderPlot({
    correlations <- df_correlation() %>%
      filter(Grade == input$grade_r, 
             Sex == input$gender_r) %>%
      select(YEAR,ShortQuestionText,Percentage) %>%
      spread(key=ShortQuestionText,value=Percentage,
             drop=T)
    correlations <-
      filter(correlations,!is.na(correlations[,2]) & 
             !is.na(correlations[,3]))
    correlations %>%
      ggplot(aes(correlations[,2],correlations[,3])) +
      geom_point(aes(color=YEAR),na.rm=T,size = 3) +
      labs(x=colnames(correlations)[2],
           y=colnames(correlations)[3]) +
      geom_smooth(method = 'lm')
  })

  output$scatter_gender <- renderPlot({
    correlations <- df_correlation() %>%
      filter(Grade == input$grade_r) %>%
      select(YEAR,ShortQuestionText,Percentage,Sex) %>%
      spread(key=ShortQuestionText,value=Percentage,
             drop=T)
    correlations <-
      filter(correlations,!is.na(correlations[,3]) & 
               !is.na(correlations[,4]))
    correlations %>%
      ggplot(aes(correlations[,3],correlations[,4])) +
      geom_point(aes(color=Sex),na.rm=T,size = 3) +
      labs(x=colnames(correlations)[3],
           y=colnames(correlations)[4]) +
      geom_smooth(aes(color = Sex), method = 'lm')
  })
  
  output$scatter_grade <- renderPlot({
    correlations <- df_correlation() %>%
      filter(Sex == input$gender_r) %>%
      select(YEAR,ShortQuestionText,Percentage,Grade) %>%
      spread(key=ShortQuestionText,value=Percentage,
             drop=T)
    correlations <-
      filter(correlations,!is.na(correlations[,3]) & 
               !is.na(correlations[,4]))
    correlations %>%
      ggplot(aes(correlations[,3],correlations[,4])) +
      geom_point(aes(color=Grade),na.rm=T,size = 3) +
      labs(x=colnames(correlations)[3],
           y=colnames(correlations)[4]) +
      geom_smooth(aes(color = Grade), method = 'lm')
  })

  df_correlation_state <- reactive({
    df %>%
      filter(ShortQuestionText == input$question_s |
               ShortQuestionText == input$question_r,
             LocationDesc != 'United States',
             YEAR == input$year_r
      )
  })
  
  output$scatter_state <- renderPlot({
    correlations <- df_correlation_state() %>%
      filter(Grade == input$grade_r, 
             Sex == input$gender_r) %>%
      select(LocationDesc,ShortQuestionText,Percentage) %>%
      spread(key=ShortQuestionText,value=Percentage,
             drop=T)
    correlations <-
      filter(correlations,!is.na(correlations[,2]) & 
               !is.na(correlations[,3]))
    correlations %>%
      ggplot(aes(correlations[,2],correlations[,3])) +
      geom_point(aes(color=LocationDesc),na.rm=T,size = 3) +
      labs(x=colnames(correlations)[2],
           y=colnames(correlations)[3]) +
      geom_smooth(method = 'lm')
  })
  
  output$scatter_gender_state <- renderPlot({
    correlations <- df_correlation_state() %>%
      filter(Grade == input$grade_r) %>%
      select(LocationDesc,ShortQuestionText,Percentage,Sex) %>%
      spread(key=ShortQuestionText,value=Percentage,
             drop=T)
    correlations <-
      filter(correlations,!is.na(correlations[,3]) & 
               !is.na(correlations[,4]))
    correlations %>%
      ggplot(aes(correlations[,3],correlations[,4])) +
      geom_point(aes(color=Sex),na.rm=T,size = 3) +
      labs(x=colnames(correlations)[3],
           y=colnames(correlations)[4]) +
      geom_smooth(aes(color = Sex), method = 'lm')
  })
  
  output$scatter_grade_state <- renderPlot({
    correlations <- df_correlation_state() %>%
      filter(Sex == input$gender_r) %>%
      select(LocationDesc,ShortQuestionText,Percentage,Grade) %>%
      spread(key=ShortQuestionText,value=Percentage,
             drop=T)
    correlations <-
      filter(correlations,!is.na(correlations[,3]) & 
               !is.na(correlations[,4]))
    correlations %>%
      ggplot(aes(correlations[,3],correlations[,4])) +
      geom_point(aes(color=Grade),na.rm=T,size = 3) +
      labs(x=colnames(correlations)[3],
           y=colnames(correlations)[4]) +
      geom_smooth(aes(color = Grade), method = 'lm')
  })
  
  output$yrbss <- renderText(
    paste(
    'The Youth Risk Behavior Surveillance System (YRBSS)',
    'monitors six categories of health-related behaviors that',
    'contribute to the leading causes of death and disability',
    'among youth and adults. It includes a national',
    'school-based survey conducted by CDC and state,',
    'territorial, tribal, and local surveys conducted by',
    'state, territorial, and local education and health',
    'agencies and tribal governments. More details can be',
    'found at https://www.cdc.gov/healthyyouth/data/yrbs.')
  )
  
  output$source <- renderText(
    paste(
      'This website is developed by Ting Yan using the YRBSS',
      'data. The source code is on GitHub at',
      'https://github.com/astrotyan/shiny.')
  )
}



