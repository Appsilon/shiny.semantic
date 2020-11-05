library(shiny)
library(shiny.semantic)
# Create a color picker
uirender(
  tagList(
    div(class = "ui input",
        style = NULL,
        "Color picker",
        shiny_text_input(
          "my_id",
          tags$input(type = "color", name = "my_id", value = "#ff0000"))
    )
  ))

