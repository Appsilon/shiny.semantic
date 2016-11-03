library("httr")
library("XML")
library("stringr")
library("ggplot2")

emotionKEY <- '6a33047cbc964124b5ae2d1897800767'

# imagePath <- '/Users/filip/Desktop/IMG_5350 2.jpg'
getEmotionResponse <- function(imagePath) {
  # img.url <- 'https://www.whitehouse.gov/sites/whitehouse.gov/files/images/first-family/44_barack_obama[1].jpg'
  apiURL <- 'https://api.projectoxford.ai/emotion/v1.0/recognize'
  
  # Request data from Microsoft
  response <- POST(
    url = apiURL,
    content_type('application/octet-stream'), 
    add_headers(.headers = c('Ocp-Apim-Subscription-Key' = emotionKEY)),
    body = upload_file(imagePath)
  )
  parsed <- httr::content(response)
  parsed
}

facesChart <- function(tab) {
  tab %>% t %>% 
    as.data.frame() %>%
    { colnames(.) <- 1:ncol(.) %>% paste0("person", .); . } %>%
    dplyr::mutate(name = rownames(.)) -> plotData
  
  plot_ly(data = plotData, x = ~name, y = ~person1, type = 'bar', name = 'Person 1') -> tempPlot
  for(i in 2:(ncol(plotData)-1)) {
    tempPlot %>%
      add_trace(y = plotData[, paste0("person", i)], name = paste('Person', i)) -> tempPlot
  }
  tempPlot %>%
    layout(yaxis = list(title = 'Count'), barmode = 'group')
}


emotionGraph <- function(scores) {
  o<-as.data.frame(as.matrix(Obama$scores))
  o$V1 <- lapply(strsplit(as.character(o$V1 ), "e"), "[", 1)
  o$V1<-as.numeric(o$V1)
  colnames(o)[1] <- "Level"
  o$Emotion<- rownames(o)
  ggplot(data=o, aes(x=Emotion, y=Level)) +
    geom_bar(stat="identity")
}

