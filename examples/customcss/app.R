library(shiny)
library(shiny.semantic)

options(shiny.custom.semantic = "styles/")

ui <- shinyUI(
  semanticPage(
    title = "Website", theme = "cosmo",
    div(style="margin-left: 210px",
        p("website content"))
  )
)

server <- function(input, output) {

}

shinyApp(ui, server)
