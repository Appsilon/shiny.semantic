## Only run examples in interactive R sessions
if (interactive()) {
  
  ui <- semanticPage(
    p("The checkbox group controls the select input"),
    multiple_checkbox("checkboxes", "Input checkbox",
                      c("Item A", "Item B", "Item C")),
    selectInput("inSelect", "Select input",
                c("Item A", "Item B"))
  )
  
  server <- function(input, output, session) {
    observe({
      x <- input$checkboxes
      
      # Can use character(0) to remove all choices
      if (is.null(x))
        x <- character(0)
      
      # Can also set the label and select items
      updateSelectInput(session, "inSelect",
                        label = paste(input$checkboxes, collapse = ", "),
                        choices = x,
                        selected = tail(x, 1)
      )
    })
  }
  
  shinyApp(ui, server)
}
