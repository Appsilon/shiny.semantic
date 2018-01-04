library(shiny)
library(shiny.semantic)
library(highlighter)
library(magrittr)
library(plotly)

ui <- shinyUI(semanticPage(
  suppressDependencies("bootstrap"),
  tabset(tabs=
           list(
             list(menu="First Tab", content= "Text works well"),
             list(menu="Second Tab",content=plotOutput("plot1")),
             list(menu="Second Tab",content=plotlyOutput("plot2"))
           )
  )
))
server <- shinyServer(function(input, output) {
  output$plot1 <- renderPlot(plot(1,1))

  output$plot2 <- renderPlotly(plot_ly(mtcars, x=~mpg, y=~cyl, width = "100%"))
})

shiny::shinyApp(ui, server)
