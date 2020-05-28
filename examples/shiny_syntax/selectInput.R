library(shiny)
library(shiny.semantic)

shinyApp(
  ui = semanticPage(
    selectInput("variable", "Variable:",
                c("Cylinders" = "cyl",
                  "Transmission" = "am",
                  "Gears" = "gear"), selectize = TRUE, multiple = TRUE, width = "300px"),
    actionButton("trig", "Cli", icon = icon("dog")),
    actionButton("justbutton", "Justbutton"),
    tableOutput("data")
  ),
  server = function(input, output, session) {
    output$data <- renderTable({
      mtcars[, c("mpg", input$variable), drop = FALSE]
    }, rownames = TRUE)

    observeEvent(input$trig, {
      updateSelectInput(session, "variable", "New variable",
                        choices = c("Cyl" = "cyl", "Am" = "am", "Gear" = "gear"),
                        selected = "am")
    }, ignoreInit = TRUE, ignoreNULL = TRUE)
    observeEvent(input$justbutton, {
      updateActionButton(session, "trig", "New label", icon = icon("cat"))
    }, ignoreInit = TRUE, ignoreNULL = TRUE)
  }
)

