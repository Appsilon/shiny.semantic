library(shiny)
library(shiny.semantic)

ui <- shinyUI(
  semanticPage(
    fileInput("file_ex", "File Input", width = "400px", type = "small"),
    h3("File type uploaded"),
    textOutput("file_ex")
  )
)

server <- shinyServer(function(input, output, session) {
  output$file_ex <- renderText({
    if (is.null(input$file_ex)) return("No file uploaded")
    tools::file_ext(input$file_ex$datapath)
  })
})

shiny::shinyApp(ui, server)
