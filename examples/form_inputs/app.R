library(shiny)
library(shiny.semantic)

ui <- shinyUI(
  semanticPage(
    suppressDependencies("bootstrap"),

    tags$br(),

    div(
      class = "ui grid",
      div(
        class = "two column row",
        # Form Input
        div(
          class = "column",
          uisegment(
            uiform(
              h4(class = "ui dividing header", "Inputs"),
              uifield(
                tags$label("Text"),
                uitextinput("text_ex", value = "", type = "text", placeholder = "Enter Text...")
              ),
              uifield(
                tags$label("Text Area"),
                uitextinput(
                  "textarea_ex", value = "", type = "textarea", placeholder = "Enter Text...", attribs = list(rows = 2)
                )
              ),
              uifield(
                tags$label("Password"),
                uitextinput("password_ex", value = "", type = "password", placeholder = "Select Password")
              ),
              uifield(
                tags$label("E-Mail"),
                uitextinput("email_ex", value = "", type = "email", placeholder = "Enter E-Mail")
              ),
              uifield(
                tags$label("URL"),
                uitextinput("url_ex", value = "", type = "url", placeholder = "Enter URL")
              ),
              uifield(
                tags$label("Numeric"),
                uinumericinput("number_ex", value = 50, min = 0, max = 100)
              )
            )
          )
        ),

        # Form Output
        div(
          class = "column",
          uisegment(
            uiform(
              h4(class = "ui dividing header", "Outputs"),
              uifield(
                tags$label("Text"),
                "Written Text: ", shiny::textOutput("text_ex", container = shiny::span)
              ),
              uifield(
                tags$label("Text Area"),
                "Written Text: ", shiny::textOutput("textarea_ex", container = shiny::span)
              ),
              uifield(
                tags$label("Password"),
                "Written Text: ", shiny::textOutput("password_ex", container = shiny::span)
              ),
              uifield(
                tags$label("E-Mail"),
                "Written Text: ", shiny::textOutput("email_ex", container = shiny::span)
              ),
              uifield(
                tags$label("URL"),
                "Written Text: ", shiny::textOutput("url_ex", container = shiny::span)
              ),
              uifield(
                tags$label("Number"),
                "Selected Number: ", shiny::textOutput("number_ex", container = shiny::span)
              )
            )
          )
        )
      )
    )
  )
)

server <- shinyServer(function(input, output) {
  output$text_ex <- renderText(input$text_ex)
  output$textarea_ex <- renderText(input$textarea_ex)
  output$password_ex <- renderText(input$password_ex)
  output$email_ex <- renderText(input$email_ex)
  output$url_ex <- renderText(input$url_ex)
  output$number_ex <- renderText(paste(input$number_ex, "   Class: ", class(input$number_ex)))
})

shiny::shinyApp(ui, server)
