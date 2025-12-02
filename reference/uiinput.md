# Create Semantic UI Input

This creates an input shell for the actual input

## Usage

``` r
uiinput(..., class = "")
```

## Arguments

- ...:

  Other arguments to be added as attributes of the tag (e.g. style,
  class or childrens etc.)

- class:

  Additional classes to add to html tag.

## See also

text_input

## Examples

``` r
#' ## Only run examples in interactive R sessions
if (interactive()) {
library(shiny)
library(shiny.semantic)

ui <- semanticPage(
  uiinput(icon("dog"),
          numeric_input("input", value = 0, label = "")
  )
)

server <- function(input, output, session) {
}

shinyApp(ui, server)
}
```
