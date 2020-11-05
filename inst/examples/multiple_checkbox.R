## Only run examples in interactive R sessions
if (interactive()) {
  # Checkbox
  library(shiny)
  library(shiny.semantic)
  
  ui <- function() {
    shinyUI(
      semanticPage(
        title = "Checkbox example",
        h1("Checkboxes"),
        multiple_checkbox("checkboxes", "Select Letters", LETTERS[1:6], value = "A"),
        p("Selected letters:"),
        textOutput("selected_letters"),
        tags$br(),
        h1("Radioboxes"),
        multiple_radio("radioboxes", "Select Letter", LETTERS[1:6], value = "A"),
        p("Selected letter:"),
        textOutput("selected_letter")
      )
    )
  }
  
  server <- shinyServer(function(input, output) {
    output$selected_letters <- renderText(paste(input$checkboxes, collapse = ", "))
    output$selected_letter <- renderText(input$radioboxes)
  })
  
  shinyApp(ui = ui(), server = server)
}

