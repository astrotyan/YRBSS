function(input, output){
  output$map <- renderGvis({
    df_map <- df %>%
      filter(QuestionCode == input$q_selected,
             YEAR == input$y_selected,
             Grade == 'Total', Sex == 'Total',
             LocationAbbr != 'XX')
    gvisGeoChart(df_map,'LocationAbbr', 'Greater_Risk_Data_Value',
                 options=list(region="US", displayMode="regions",
                              resolution="provinces",
                              width="auto", height="auto"))
  })
}