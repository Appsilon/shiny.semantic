library(shiny)
library(shiny.semantic)

ui <- semanticPage(
  action_button("changetab", "Select First Tab!"),
  br(),br(),
  uiOutput("activetab"),
  br(),br(),
  selectInput(
    inputId = "plot1xaxis",
    label = "change x axis variable in third tab:",
    choices = names(mtcars),
    selected = "mpg",
    width = 200
  ),
  br(),br(),
  tabset(
    tabs = list(
      list(menu = "First Tab", content = "Text works well", id = "first_tab"),
      list(menu = "Second Tab", content = plotOutput("plot1"), id = "second_tab"),
      list(menu = "Third Tab", content = plotOutput("plot2"))
    ),
    active = "second_tab",
    id = "exampletabset"
  )
)
server <- function(input, output, session) {

  observeEvent(input$changetab,{
    update_tabset(session, "exampletabset", "first_tab")
  })

  output$plot1 <- renderPlot(
    plot(c(1, 2), c(1, 5), type = 'b', main = "Plot 1",
         xlab = "x axis", ylab = "y axis")
  )

  output$plot2 <- renderPlot(
    plot(mtcars[[input$plot1xaxis]], mtcars$cyl, col = 'red',
         xlab = input$plot1xaxis, ylab = "cyl")
  )

  output$activetab <- renderUI(
    p(strong("Active Tab ID: "), input$exampletabset)
  )
}

shiny::shinyApp(ui, server)
