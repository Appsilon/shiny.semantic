## Only run examples in interactive R sessions
if (interactive()){
  library(shiny)
  library(shiny.semantic)
  
  ui <- shinyUI(semanticPage(
    form(
      field(
        tags$label("Text"),
        text_input("text_ex", value = "", type = "text", placeholder = "Enter Text...")
      )
    ),
    # loading form
    form(class = "loading form",
         field(
           tags$label("Text"),
           text_input("text_ex", value = "", type = "text", placeholder = "Enter Text...")
         )),
    # size variations mini form
    form(class = "mini",
         field(
           tags$label("Text"),
           text_input("text_ex", value = "", type = "text", placeholder = "Enter Text...")
         )),
    # massive
    form(class = "massive",
         field(
           tags$label("Text"),
           text_input("text_ex", value = "", type = "text", placeholder = "Enter Text...")
         ))
  ))
  server <- shinyServer(function(input, output) {
  })
  
  shinyApp(ui, server)
}
