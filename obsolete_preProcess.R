# OBSOLETE

# This will take about 150 minutes to process the whole file.

preProcess = function(filepath) {
  con = file(filepath)
  open(con)
  
  # columns and rows to be selected
  col_names = c("YEAR","LocationAbbr","Greater_Risk_Data_Value",
                "Lesser_Risk_Data_Value","Sample_Size","Sex",
                "Grade","QuestionCode")
  row_has = c('H23','H24','H25','H26','H68','H69','QNOWT',
              'H79','QNPA0DAY','QNPA7DAY','H83','H80','H81',
              'H88') 
  
  # read header and create emtpy data frame
  header = strsplit((readLines(con, n = 1)),split=',')[[1]]
  col_ind = match(col_names,header)
  df = read.table(text='',col.names = col_names,
                  colClasses = rep('character',length(col_ind)),
                  stringsAsFactors=F)
  
  # read line by line
  i = 1
  while ( i <= 1000 ) {
    line = readLines(con,1)
    if ( length(line) == 0 ) {
      break
    }
    new_line = read.csv(text=line,header=F,
                        col.names = header,
                        stringsAsFactors = F)
    if (new_line$Race[1] == 'Total' &
        ! is.na(new_line$Greater_Risk_Data_Value[1]) &
        new_line$QuestionCode[1] %in% row_has) { # filter rows
      new_line = new_line[,col_ind] # select columns
      df = rbind(df,new_line)
    }
    i = i+1
  }
  
  close(con)
  
  colnames(df) = col_names
  return(df)
}

system.time(
  df <- preProcess('data/YRBS.csv')
# 5.95M rows
# Will take about 150 minutes to process the whole file.
)

