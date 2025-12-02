# Create Semantic UI Button

Create Semantic UI Button

## Usage

``` r
button(input_id, label, icon = NULL, class = NULL, ...)
```

## Arguments

- input_id:

  The `input` slot that will be used to access the value.

- label:

  The contents of the button or link

- icon:

  An optional
  [`icon()`](https://appsilon.github.io/shiny.semantic/reference/icon.md)
  to appear on the button.

- class:

  An optional attribute to be added to the button's class. If used
  paramters like `color`, `size` are ignored.

- ...:

  Named attributes to be applied to the button

## Examples

``` r
if (interactive()){
library(shiny)
library(shiny.semantic)
ui <- semanticPage(
  shinyUI(
    button("simple_button", "Press Me!")
  )
)
server <- function(input, output, session) {
}
shinyApp(ui, server)
}

```
