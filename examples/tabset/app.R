library(shiny)
library(shiny.semantic)
library(plotly)

ui <- shinyUI(semanticPage(
  tabset(tabs =
           list(
             list(menu = "First Tab", content = "Text works well"),
             list(menu = "Second Tab", content = plotOutput("plot1"), id = "second_tab"),
             list(menu = "Third Tab", content = plotlyOutput("plot2"))
           ),
         active = "second_tab",
         id = "exampletabset"
  ),
  h2("Active Tab:"),
  textOutput("activetab")
))
server <- shinyServer(function(input, output) {

  output$plot1 <- renderPlot(plot(1, 1))
  output$plot2 <- renderPlotly(plot_ly(mtcars, x = ~mpg, y = ~cyl, width = "100%"))
  output$activetab <- renderText(input$exampletabset_tab)
})

shiny::shinyApp(ui, server)
