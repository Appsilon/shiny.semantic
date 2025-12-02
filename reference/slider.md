# Create Semantic UI Slider / Range

This creates a slider input using Semantic UI. Slider is already
initialized and available under `input[[input_id]]`. Use Range for range
of values.

## Usage

``` r
slider_input(
  input_id,
  value,
  min,
  max,
  step = 1,
  class = "labeled",
  custom_ticks = NULL
)

sliderInput(
  inputId,
  label,
  min,
  max,
  value,
  step = 1,
  width = NULL,
  ticks = TRUE,
  ...
)

range_input(input_id, value, value2, min, max, step = 1, class = NULL)
```

## Arguments

- input_id:

  Input name. Reactive value is available under `input[[input_id]]`.

- value:

  The initial value to be selected for the sldier (lower value if using
  range).

- min:

  The minimum value allowed to be selected for the slider.

- max:

  The maximum value allowed to be selected for the slider.

- step:

  The interval between each selectable value of the slider.

- class:

  UI class of the slider. Can include `"labeled"` and `"ticked"`.

- custom_ticks:

  A vector of custom labels to be added to the slider. Will ignore `min`
  and `max`

- inputId:

  Input name.

- label:

  Display label for the control, or NULL for no label.

- width:

  character with width of slider.

- ticks:

  `FALSE` to hide tick marks, `TRUE` to show them according to some
  simple heuristics

- ...:

  additional arguments

- value2:

  The initial upper value of the slider.

## Details

Use
[`update_slider`](https://appsilon.github.io/shiny.semantic/reference/update_slider.md)
to update the slider/range within the shiny session.

## See also

update_slider for input updates,
<https://fomantic-ui.com/modules/slider.html> for preset classes.

## Examples

``` r
if (interactive()) {
  # Slider example
  library(shiny)
  library(shiny.semantic)

  ui <- shinyUI(
    semanticPage(
      title = "Slider example",
      tags$br(),
      slider_input("slider", 10, 0, 20, class = "labeled ticked"),
      p("Selected value:"),
      textOutput("slider")
    )
  )
  server <- shinyServer(function(input, output, session) {
    output$slider <- renderText(input$slider)
  })
  shinyApp(ui = ui, server = server)

  # Custom ticks slider
  ui <- shinyUI(
    semanticPage(
      title = "Slider example",
      tags$br(),
      slider_input("slider_ticks", "F", custom_ticks = LETTERS, class = "labeled ticked"),
      p("Selected value:"),
      textOutput("slider_ticks")
    )
  )
  server <- shinyServer(function(input, output, session) {
    output$slider_ticks <- renderText(input$slider_ticks)
  })
  shinyApp(ui = ui, server = server)

  # Range example
  ui <- shinyUI(
    semanticPage(
      title = "Range example",
      tags$br(),
      range_input("range", 10, 15, 0, 20),
      p("Selected values:"),
      textOutput("range")
    )
  )
  server <- shinyServer(function(input, output, session) {
    output$range <- renderText(paste(input$range, collapse = " - "))
  })
  shinyApp(ui = ui, server = server)
}
```
