# Create Semantic UI segment

This creates a segment using Semantic UI styles.

## Usage

``` r
segment(..., class = "")
```

## Arguments

- ...:

  Other arguments to be added as attributes of the tag (e.g. style,
  class or childrens etc.)

- class:

  Additional classes to add to html tag.

## Examples

``` r
## Only run examples in interactive R sessions
if (interactive()){
  library(shiny)
  library(shiny.semantic)

  ui <- shinyUI(semanticPage(
    segment(),
    # placeholder
    segment(class = "placeholder segment"),
    # raised
    segment(class = "raised segment"),
    # stacked
    segment(class = "stacked segment"),
    #  piled
    segment(class = "piled segment")
  ))
  server <- shinyServer(function(input, output) {
  })

  shinyApp(ui, server)
}
```
