# Action button

Creates an action button whose value is initially zero, and increments
by one each time it is pressed.

## Usage

``` r
action_button(input_id, label, icon = NULL, width = NULL, ...)

actionButton(inputId, label, icon = NULL, width = NULL, ...)
```

## Arguments

- input_id:

  The input slot that will be used to access the value.

- label:

  The contents of the button - a text label, but you could also use any
  other HTML, like an image.

- icon:

  An optional
  [icon](https://appsilon.github.io/shiny.semantic/reference/icon.md) to
  appear on the button.

- width:

  The width of the input.

- ...:

  Named attributes to be applied to the button or remaining parameters
  passed to button, like `class`.

- inputId:

  the same as `input_id`

## Examples

``` r
if (interactive()){
library(shiny)
library(shiny.semantic)
ui <- shinyUI(semanticPage(
  actionButton("action_button", "Press Me!"),
  textOutput("button_output")
))
server <- function(input, output, session) {
  output$button_output <- renderText(as.character(input$action_button))
}
shinyApp(ui, server)
}
```
