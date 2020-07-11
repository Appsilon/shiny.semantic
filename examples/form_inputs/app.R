library(shiny)
library(shiny.semantic)

ui <- shinyUI(
  semanticPage(
    tags$br(),

    div(
      class = "ui grid",
      div(
        class = "two column row",
        # Form Input
        div(
          class = "column",
          segment(
            form(
              h4(class = "ui dividing header", "Inputs"),
              field(
                tags$label("Text"),
                text_input("text_ex", value = "", type = "text", placeholder = "Enter Text...")
              ),
              field(
                tags$label("Text Area"),
                text_input(
                  "textarea_ex", value = "", type = "textarea", placeholder = "Enter Text...", attribs = list(rows = 2)
                )
              ),
              field(
                tags$label("Password"),
                text_input("password_ex", value = "", type = "password", placeholder = "Select Password")
              ),
              field(
                tags$label("E-Mail"),
                text_input("email_ex", value = "", type = "email", placeholder = "Enter E-Mail")
              ),
              field(
                tags$label("URL"),
                text_input("url_ex", value = "", type = "url", placeholder = "Enter URL")
              ),
              field(
                tags$label("Numeric"),
                numeric_input("number_ex", value = 50, min = 0, max = 100)
              ),
              field(
                tags$label("Checkbox"),
                checkbox_input("checkbox_ex", "Checkbox"),
                tags$br(),
                checkbox_input("slider_ex", "Slider", type = "slider")
              ),
              field(
                tags$label("Group Radio Button"),
                multiple_radio(
                  "grp_radio_ex", "Favourite Letter", choices = LETTERS[1:4], selected = "B", position = "inline"
                )
              ),
              field(
                tags$label("Group Checkbox"),
                multiple_checkbox(
                  "grp_check_ex", "Favourite Numbers", choices = 1:5, position = "inline"
                )
              ),
              field(
                tags$label("Calendar"),
                calendar(
                  "calendar_ex"
                )
              )
            )
          )
        ),

        # Form Output
        div(
          class = "column",
          segment(
            form(
              h4(class = "ui dividing header", "Outputs"),
              field(
                tags$label("Text"),
                "Written Text: ", shiny::textOutput("text_ex", container = shiny::span)
              ),
              field(
                tags$label("Text Area"),
                "Written Text: ", shiny::textOutput("textarea_ex", container = shiny::span)
              ),
              field(
                tags$label("Password"),
                "Written Text: ", shiny::textOutput("password_ex", container = shiny::span)
              ),
              field(
                tags$label("E-Mail"),
                "Written Text: ", shiny::textOutput("email_ex", container = shiny::span)
              ),
              field(
                tags$label("URL"),
                "Written Text: ", shiny::textOutput("url_ex", container = shiny::span)
              ),
              field(
                tags$label("Number"),
                "Selected Number: ", shiny::textOutput("number_ex", container = shiny::span)
              ),
              field(
                tags$label("Checkbox"),
                "Checkbox Selected:", shiny::textOutput("checkbox_ex", container = shiny::span),
                tags$br(),
                "Slider Selected:", shiny::textOutput("slider_ex", container = shiny::span)
              ),
              field(
                tags$label("Group Radio Button"),
                "Radio Button Selected:", shiny::textOutput("grp_radio_ex", container = shiny::span)
              ),
              field(
                tags$label("Group Checkbox"),
                "Checkboxes Selected:", shiny::textOutput("grp_check_ex", container = shiny::span)
              ),
              field(
                tags$label("Calendar"),
                "Date Selected:", shiny::textOutput("calendar_ex", container = shiny::span)
              )
            )
          )
        )
      )
    )
  )
)

server <- shinyServer(function(input, output, session) {
  output$text_ex <- renderText(input$text_ex)
  output$textarea_ex <- renderText(input$textarea_ex)
  output$password_ex <- renderText(input$password_ex)
  output$email_ex <- renderText(input$email_ex)
  output$url_ex <- renderText(input$url_ex)
  output$number_ex <- renderText(paste(input$number_ex, "   Class: ", class(input$number_ex)))
  output$checkbox_ex <- renderText(input$checkbox_ex)
  output$slider_ex <- renderText(input$slider_ex)
  output$grp_radio_ex <- renderText(input$grp_radio_ex)
  output$grp_check_ex <- renderText(paste(input$grp_check_ex, collapse = ", "))
  output$calendar_ex <- renderText(as.character(input$calendar_ex))
})

shiny::shinyApp(ui, server)
