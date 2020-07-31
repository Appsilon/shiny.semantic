library(shiny)
library(shiny.semantic)

ui <- semanticPage(
  titlePanel("Hello Shiny!"),
  sidebar_layout(
    sidebar_panel(
      sliderInput("obs",
                  "Number of observations:",
                  min = 0,
                  max = 1000,
                  value = 500)
    ),
    main_panel(
      plotOutput("distPlot"),
      "trestrsd"
    )
  )
)

server <- function(input, output) {
  output$distPlot <- renderPlot({
    hist(rnorm(input$obs))
  })
}

shinyApp(ui, server)
