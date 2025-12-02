# Create Semantic UI fields tag

This creates a fields tag using Semantic UI styles.

## Usage

``` r
fields(..., class = "")
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
    form(
      fields(class = "two",
             field(
               tags$label("Name"),
               text_input("name", value = "", type = "text", placeholder = "Enter Name...")
             ),
             field(
               tags$label("Surname"),
               text_input("surname", value = "", type = "text", placeholder = "Enter Surname...")
             ))
    )
  ))
  server <- shinyServer(function(input, output) {
  })

  shinyApp(ui, server)
}
```
