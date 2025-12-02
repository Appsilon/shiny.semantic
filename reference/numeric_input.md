# Create Semantic UI Numeric Input

This creates a default numeric input using Semantic UI. The input is
available under `input[[input_id]]`.

## Usage

``` r
numeric_input(
  input_id,
  label,
  value = NULL,
  min = NA,
  max = NA,
  step = NA,
  type = NULL,
  icon = NULL,
  placeholder = NULL,
  ...
)

numericInput(
  inputId,
  label,
  value = NULL,
  min = NA,
  max = NA,
  step = NA,
  width = NULL,
  placeholder = NULL,
  ...
)
```

## Arguments

- input_id:

  Input name. Reactive value is available under `input[[input_id]]`.

- label:

  Display label for the control, or NULL for no label.

- value:

  Initial value of the numeric input.

- min:

  Minimum allowed value.

- max:

  Maximum allowed value.

- step:

  Interval to use when stepping between min and max.

- type:

  Input type specifying class attached to input container. See
  \[Fomantic UI\](https://fomantic-ui.com/collections/form.html) for
  details.

- icon:

  Icon or label attached to numeric input.

- placeholder:

  Inner input label displayed when no value is specified

- ...:

  Other parameters passed to `numeric_input` like `type` or `icon`.

- inputId:

  The input slot that will be used to access the value.

- width:

  The width of the input.

## Details

Either \`value\` or \`placeholder\` should be defined. The inputs are
updateable by using
[`updateNumericInput`](https://appsilon.github.io/shiny.semantic/reference/update_numeric_input.md).

## Examples

``` r
## Only run examples in interactive R sessions
if (interactive()) {
  library(shiny)
  library(shiny.semantic)
  ui <- semanticPage(
    numeric_input("ex", "Select number", 10),
  )
  server <- function(input, output, session) {}
  shinyApp(ui, server)
}
```
