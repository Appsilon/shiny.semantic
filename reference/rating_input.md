# Rating Input.

Crates rating component

## Usage

``` r
rating_input(
  input_id,
  label = "",
  value = 0,
  max = 3,
  icon = "star",
  color = "yellow",
  size = ""
)
```

## Arguments

- input_id:

  The `input` slot that will be used to access the value.

- label:

  the contents of the item to display

- value:

  initial rating value

- max:

  maximum value

- icon:

  character with name of the icon or
  [`icon()`](https://appsilon.github.io/shiny.semantic/reference/icon.md)
  that is an element of the rating

- color:

  character with colour name

- size:

  character with legal semantic size, eg. "medium", "huge", "tiny"

## Value

rating object

## Examples

``` r
## Only run examples in interactive R sessions
if (interactive()) {
  library(shiny)
  library(shiny.semantic)

  ui <- shinyUI(
    semanticPage(
      rating_input("rate", "How do you like it?", max = 5,
                   icon = "heart", color = "yellow"),
    )
  )
  server <- function(input, output) {
    observeEvent(input$rate,{print(input$rate)})
  }
  shinyApp(ui = ui, server = server)
}
```
