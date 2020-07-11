library(shiny)
library(shiny.semantic)

options(semantic.themes = TRUE)
# Uncomment this line to use your custom style
#options(shiny.custom.semantic = "styles/")

ui <- shinyUI(
  semanticPage(
    title = "Website", theme = "cosmo",
    div(
      style = "margin-left: 210px",
      p("website content"),
      actionButton("button1", "Go!")
      )
  )
)

server <- function(input, output) {

}

shinyApp(ui, server)
