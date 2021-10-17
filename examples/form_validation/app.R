library(shiny)
library(shiny.semantic)

ui <- shinyUI(
  semanticPage(
    div(
      class = "ui basic segment grid",
      div(
        class = "two column stretched row",
        div(
          class = "column",
          segment(
            form(
              id = "form",
              h4(class = "ui dividing header", "User Information"),
              fields(
                class = "two",
                field(
                  tags$label("Firstname"),
                  text_input("firstname", value = "", type = "text")
                ),
                field(
                  tags$label("Surname"),
                  text_input("surname", value = "", type = "text")
                )
              ),
              field(
                tags$label("E-Mail Address"),
                text_input("email", value = "", type = "email")
              ),
              field(
                tags$label("Password"),
                text_input("password", value = "", type = "password")
              ),
              field(
                tags$label("Age"),
                text_input("age", value = "", type = "text"),
              ),
              field(
                checkbox_input("confirm", label = "I confirm this information is correct", is_marked = FALSE),
              ),
              form_validation(
                id = "form",
                field_validation("firstname", field_rule("empty")),
                field_validation("surname", field_rule("empty")),
                field_validation("email", field_rule("email")),
                field_validation("password", field_rule("minLength", value = 6)),
                field_validation("age", field_rule("empty"), field_rule("number")),
                field_validation("confirm", field_rule("checked", "You must confirm to submit details"))
              )
            )
          )
        ),

        div(
          class = "column",
          segment(
            form(
              h4(class = "ui dividing header", "Bio"),
              card(
                div(class = "content",  textOutput("name", container = function(...) span(class = "header", ...))),
                div(class = "image", div(class = "ui placeholder", div(class = "square image"))),
                div(
                  class = "content",
                  p("E-mail:", textOutput("email", inline = TRUE)),
                  p("Age:", textOutput("age", inline = TRUE)),
                  p("Password:", textOutput("password", inline = TRUE))
                )
              )
            )
          )
        )
      )
    )
  )
)

server <- shinyServer(function(input, output, session) {
  form_submission <- eventReactive(input$form_submit, {
    list(
      firstname = input$firstname,
      surname = input$surname,
      name = paste(input$firstname, input$surname),
      email = input$email,
      password = input$password,
      age = input$age
    )
  })
  output$name <- renderText(form_submission()$name)
  output$email <- renderText(form_submission()$email)
  output$password <- renderText(gsub(".", "*", form_submission()$password))
  output$age <- renderText(form_submission()$age)
})

shiny::shinyApp(ui, server)
