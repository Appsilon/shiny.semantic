library(shiny)
library(shiny.semantic)

ui <- semanticPage(
  title = "Flow layout example",
  flow_layout(
    min_cell_width = 300,
    textInput("first-name", label = "First Name", width = "100%"),
    textInput("middle-name", label = "Middle Name"),
    textInput("last-name", label = "Last Name"),
    textInput("address-1", label = "Address Line 1"),
    textInput("address-2", label = "Address Line 2"),
    textInput("city", label = "City"),
    textInput("zip", label = "Zip/Postal Code"),
    textInput("country", label = "Country"),
    textInput("telephone", label = "Telephone")
  )
)

shinyApp(ui = ui, server = function(input, output) {})
