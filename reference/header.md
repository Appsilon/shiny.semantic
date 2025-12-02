# Create Semantic UI header

This creates a header with optional icon using Semantic UI styles.

## Usage

``` r
header(title, description, icon = NULL)
```

## Arguments

- title:

  Header title

- description:

  Subheader text

- icon:

  Optional icon name

## Examples

``` r
## Only run examples in interactive R sessions
if (interactive()){
  library(shiny)
  library(shiny.semantic)

  ui <- shinyUI(semanticPage(
    header(title = "Header with description", description = "Description"),
    header(title = "Header with icon", description = "Description", icon = "dog")
  ))
  server <- shinyServer(function(input, output) {
  })

  shinyApp(ui, server)
}
```
