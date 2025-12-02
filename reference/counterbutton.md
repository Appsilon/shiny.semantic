# Counter Button

Creates a counter button whose value increments by one each time it is
pressed.

## Usage

``` r
counter_button(
  input_id,
  label = "",
  icon = NULL,
  value = 0,
  color = "",
  size = "",
  big_mark = " "
)
```

## Arguments

- input_id:

  The `input` slot that will be used to access the value.

- label:

  the content of the item to display

- icon:

  an optional
  [`icon()`](https://appsilon.github.io/shiny.semantic/reference/icon.md)
  to appear on the button.

- value:

  initial rating value (integer)

- color:

  character with semantic color

- size:

  character with size of the button, eg. "medium", "big"

- big_mark:

  big numbers separator

## Value

counter button object

## Examples

``` r
if (interactive()) {
library(shiny)
library(shiny.semantic)
ui <-semanticPage(
     counter_button("counter", "My Counter Button",
                   icon = icon("world"),
                   size = "big", color = "purple")
 )
server <- function(input, output) {
 observeEvent(input$counter,{
   print(input$counter)
  })
 }
shinyApp(ui, server)
}
```
