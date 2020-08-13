library(shiny)
library(shiny.semantic)

ui <- semanticPage(
  vertical_layout(
    h1("Title"), h4("Subtitle"), p("paragraph"), h3("footer")
  )
)
shinyApp(ui, server = function(input, output) { })

ui <- semanticPage(
  vertical_layout(
    h1("Title"), h4("Subtitle"), p("paragraph"), h3("footer"),
    adjusted_to_page = FALSE
  )
)

shinyApp(ui, server = function(input, output) { })
