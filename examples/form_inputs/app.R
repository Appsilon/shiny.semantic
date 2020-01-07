library(shiny)
library(shiny.semantic)

ui <- shinyUI(
  semanticPage(
    tags$script(src = "shiny-semantic-radiogroup.js"),
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
              ),
              uifield(
                tags$label("Checkbox"),
                simple_checkbox("checkbox_ex", "Checkbox"),
                tags$br(),
                simple_checkbox("slider_ex", "Slider", type = "slider")
              ),
              uifield(
                tags$label("Group Radio Button"),
                multiple_radio(
                  "grp_radio_ex", "Favourite Letter", choices = LETTERS[1:4], selected = "B", position = "inline"
                )
              ),
              uifield(
                tags$label("Group Checkbox"),
                multiple_checkbox(
                  "grp_check_ex", "Favourite Numbers", choices = 1:5, position = "inline"
                )
              ),
              uifield(
                tags$label("Calendar"),
                uicalendar(
                  "calendar_ex"
                )
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
              ),
              uifield(
                tags$label("Checkbox"),
                "Checkbox Selected:", shiny::textOutput("checkbox_ex", container = shiny::span),
                tags$br(),
                "Slider Selected:", shiny::textOutput("slider_ex", container = shiny::span)
              ),
              uifield(
                tags$label("Group Radio Button"),
                "Radio Button Selected:", shiny::textOutput("grp_radio_ex", container = shiny::span)
              ),
              uifield(
                tags$label("Group Checkbox"),
                "Checkboxes Selected:", shiny::textOutput("grp_check_ex", container = shiny::span)
              ),
              uifield(
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

  # observeEvent(input$grp_check_ex, browser(), ignoreInit = TRUE)
})

shiny::shinyApp(ui, server)
