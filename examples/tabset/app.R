library(shiny)
library(shiny.semantic)

ui <- shinyUI(semanticPage(
  h2("Active Tab:"),
  textOutput("activetab"),
  action_button("changetab", "Change tab!"),
  tabset(tabs =
           list(
             list(menu = "First Tab", content = "Text works well", id= "first_tab"),
             list(menu = "Second Tab", content = plotOutput("plot1"), id = "second_tab"),
             list(menu = "Third Tab", content = plotOutput("plot2"), id = "third_tab")
           ),
         active = "second_tab",
         id = "exampletabset"
  )
))
server <- function(input, output, session) {

  observeEvent(input$changetab,{
    session$sendInputMessage("exampletabset", "first_tab")
  })

  output$plot1 <- renderPlot(plot(c(1, 2), c(1, 5), type='b', main = "Plot 1"))
  output$plot2 <- renderPlot(plot(mtcars$mpg, mtcars$cyl, col = 'red'))
  output$activetab <- renderText(input$exampletabset)
}

shiny::shinyApp(ui, server)
