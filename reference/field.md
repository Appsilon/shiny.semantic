# Create Semantic UI field tag

This creates a field tag using Semantic UI styles.

## Usage

``` r
field(..., class = "")
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
      field(
        tags$label("Name"),
        text_input("name", value = "", type = "text", placeholder = "Enter Name...")
      ),
      # error field
      field(
        class = "error",
        tags$label("Name"),
        text_input("name", value = "", type = "text", placeholder = "Enter Name...")
      ),
      # disabled
      field(
        class = "disabled",
        tags$label("Name"),
        text_input("name", value = "", type = "text", placeholder = "Enter Name...")
      )
    )
  ))
  server <- shinyServer(function(input, output) {
  })

  shinyApp(ui, server)
}
```
