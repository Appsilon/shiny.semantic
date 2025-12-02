# Change numeric input value and settings

Change numeric input value and settings

## Usage

``` r
update_numeric_input(
  session,
  input_id,
  label = NULL,
  value = NULL,
  min = NULL,
  max = NULL,
  step = NULL
)

updateNumericInput(
  session = getDefaultReactiveDomain(),
  inputId,
  label = NULL,
  value = NULL,
  min = NULL,
  max = NULL,
  step = NULL
)
```

## Arguments

- session:

  The session object passed to function given to shinyServer.

- input_id:

  The id of the input object.

- label:

  The label to set for the input object.

- value:

  The value to set for the input object.

- min:

  Minimum value.

- max:

  Maximum value.

- step:

  Step size.

- inputId:

  the same as `input_id`

## Examples

``` r
## Only run examples in interactive R sessions
if (interactive()) {
library(shiny)
library(shiny.semantic)

ui <- semanticPage(
  slider_input("slider_in", 5, 0, 10),
  numeric_input("input", "Numeric input:", 0)
)

server <- function(input, output, session) {

  observeEvent(input$slider_in, {
    x <- input$slider_in

    update_numeric_input(session, "input", value = x)
  })
}

shinyApp(ui, server)
}
```
