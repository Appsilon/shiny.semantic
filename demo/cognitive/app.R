library(shiny)
library(shinyjs)
library(semanticui)
library(plotly)
library(leaflet)
library(magrittr)
library(mosaic)
library(quantmod)
library(tidyr)
library(chartjs)
library(DT)
library(visNetwork)

source("emotion.R")

options(shiny.maxRequestSize = 100 * 1024^2) 

jsCode <- "
$('.ui.dropdown').dropdown({});
$('.rating').rating('setting', 'clearable', true);
"

ui <- function() {
  shinyUI(semanticPage(
    style="min-height: 100%;",
    useShinyjs(),
    menu(class = "ui three item menu",
         divMenuItem(img(src = "/images/logo-appsilon.png", style="width:135px")),
         menuItem("Settings"),
         menuItem("Log out")),
    div(class = "ui two column grid",
        style = "height: 100%",
        div(class = "column",
            div(class = "ui raised segment",
              a(class="ui red ribbon label", "Panel"),
              p(),
              fileInput(inputId = 'file', 
                        label = 'Select an Image',
                        multiple = TRUE,
                        accept=c('image/png', 'image/jpeg')),
              uiOutput("detectedOutput"),
              DT::dataTableOutput("emotionsTable")
            )),
        div(class = "column",
            div(class = "ui raised segment",
                a(class="ui red ribbon label", "Photo"),
                p(),
                imageOutput("image", width="500px"),
                plotly::plotlyOutput("emotionsPlot")
                )
            )
        )
    )
  )
}

enhanceImageWithFaces <- function(imagePath, outPath, emotions) {
  file.copy(imagePath, outPath, overwrite = T)
  img <- EBImage::readImage(outPath)
  emotions %>% 
    purrr::map(~ .$faceRectangle) %>%
    purrr::map(function(rect) {
      x <- rect$left + rect$width / 2
      y <- rect$top + rect$height / 2
      radius <- (rect$width + rect$height) / 2
      img <<- EBImage::drawCircle(img, x, y, radius, col="red")
    })
  EBImage::writeImage(img, outPath)
}

server <- shinyServer(function(input, output) {
  runjs(jsCode)
  
  emotions <- reactive({
    if(is.null(input$file)) return(NULL)
    getEmotionResponse(input$file$datapath)
  })
  
  emotionsTab <- reactive({
    emotions() %>% 
      purrr::map(~ .$scores %>% unlist %>% round(4)) %>% 
      do.call(rbind, .)
  })
  
  output$image <- renderImage({
    validate(
      need(input$file$datapath != "", "No file selected")
    )
    
    path <- input$file$datapath
    outPath <- "/tmp/tempImage.jpg"
    enhanceImageWithFaces(path, outPath, emotions())
    
    list(src = outPath, alt = "Image failed to render", width = 400)
  }, deleteFile = F)
  
  output$detectedOutput <- renderUI({
    if(is.null(input$file)) return(NULL)
    span(emotions() %>% length %>% as.character) 
  })
  
  output$emotionsTable <- DT::renderDataTable({
    if(is.null(input$file)) return(NULL)
    emotionsTab() %>% DT::datatable()
  })
  output$emotionsPlot <- plotly::renderPlotly({
    facesChart(emotionsTab())
  })
})
shinyApp(ui = ui(), server = server)
