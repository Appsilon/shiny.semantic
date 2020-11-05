## Only run examples in interactive R sessions
if (interactive()){
  library(shiny)
  library(shiny.semantic)
  
  ui <- shinyUI(
    semanticPage(
      ## label
      label(icon = icon("mail icon"), 23),
      p(),
      ## pointing label
      field(
        text_input("ex", label = "", type = "text", placeholder = "Your name")),
      label("Please enter a valid name", class = "pointing red basic"),
      p(),
      ## tag
      label(class = "tag", "New"),
      label(class = "red tag", "Upcoming"),
      label(class =" teal tag","Featured"),
      ## ribbon
      segment(class = "ui raised segment",
              label(class = "ui red ribbon", "Overview"),
              "Text"),
      ## attached
      segment(class = "ui raised segment",
              label(class = "top attached", "HTML"),
              p("Text"))
    ))
  server <- function(input, output, session) {
  }
  shinyApp(ui, server)
}
