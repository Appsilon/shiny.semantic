# Create Semantic DT Table

This creates DT table styled with Semantic UI.

## Usage

``` r
semantic_DT(
  ...,
  options = list(),
  style = "semanticui",
  class = "ui small compact table"
)
```

## Arguments

- ...:

  datatable parameters, check
  [`?DT::datatable`](https://rdrr.io/pkg/DT/man/datatable.html) to learn
  more.

- options:

  datatable options, check
  [`?DT::datatable`](https://rdrr.io/pkg/DT/man/datatable.html) to learn
  more.

- style:

  datatable style, check
  [`?DT::datatable`](https://rdrr.io/pkg/DT/man/datatable.html) to learn
  more.

- class:

  datatable class, check
  [`?DT::datatable`](https://rdrr.io/pkg/DT/man/datatable.html) to learn
  more.

## Examples

``` r
if (interactive()){
 library(shiny)
 library(shiny.semantic)

 ui <- semanticPage(
   semantic_DTOutput("table")
 )
 server <- function(input, output, session) {
   output$table <- DT::renderDataTable(
     semantic_DT(iris)
   )
 }
 shinyApp(ui, server)
}
```
