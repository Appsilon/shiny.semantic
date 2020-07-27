library(shiny)
library(shiny.semantic)

ui <- shinyUI(semanticPage(
  tabset(tabs =
           list(
             list(menu = "First Tab", content = "Text works well"),
             list(menu = "Second Tab", content = plotOutput("plot1"), id = "second_tab"),
             list(menu = "Third Tab", content = plotOutput("plot2"))
           ),
         active = "second_tab",
         id = "exampletabset"
  ),
  h2("Active Tab:"),
  textOutput("activetab")
))
server <- shinyServer(function(input, output) {

  output$plot1 <- renderPlot(plot(c(1, 2), c(1, 5), type='b', main = "Plot 1"))
  output$plot2 <- renderPlot(plot(mtcars$mpg, mtcars$cyl, col = 'red'))
  output$activetab <- renderText(input$exampletabset_tab)
})

shiny::shinyApp(ui, server)
