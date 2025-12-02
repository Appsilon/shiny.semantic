# Create progress Semantic UI component

This creates a default progress using Semantic UI styles with Shiny
input. Progress is already initialized and available under
input\[\[input_id\]\].

## Usage

``` r
progress(
  input_id,
  value = NULL,
  total = NULL,
  percent = NULL,
  progress_lab = FALSE,
  label = NULL,
  label_complete = NULL,
  size = "",
  class = NULL
)
```

## Arguments

- input_id:

  Input name. Reactive value is available under input\[\[input_id\]\].

- value:

  The initial value to be selected for the progress bar.

- total:

  The maximum value that will be applied to the progress bar.

- percent:

  The initial percentage to be selected for the progress bar.

- progress_lab:

  Logical, would you like the percentage visible in the progress bar?

- label:

  The label to be visible underneath the progress bar.

- label_complete:

  The label to be visible underneath the progress bar when the bar is at
  100%.

- size:

  character with legal semantic size, eg. "medium", "huge", "tiny"

- class:

  UI class of the progress bar.

## Details

To initialize the progress bar, you can either choose `value` and
`total`, or `percent`.

## Examples

``` r
## Only run examples in interactive R sessions
if (interactive()) {

  library(shiny)
  library(shiny.semantic)
  ui <- function() {
      shinyUI(
        semanticPage(
          title = "Progress example",
          progress("progress", percent = 24, label = "{percent}% complete"),
          p("Progress completion:"),
          textOutput("progress")
       )
     )
  }
  server <- shinyServer(function(input, output) {
     output$progress <- renderText(input$progress)
  })

  shinyApp(ui = ui(), server = server)
}
```
