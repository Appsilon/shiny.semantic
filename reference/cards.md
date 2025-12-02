# Create Semantic UI cards tag

This creates a cards tag using Semantic UI styles.

## Usage

``` r
cards(..., class = "")
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
    cards(
      class = "two",
      card(
        div(class="content",
            div(class="header", "Elliot Fu"),
            div(class="meta", "Friend"),
            div(class="description", "Elliot Fu is a film-maker from New York.")
        )
      ),
      card(
        div(class="content",
            div(class="header", "John Bean"),
            div(class="meta", "Friend"),
            div(class="description", "John Bean is a film-maker from London.")
        )
      )
    )
  ))
  server <- shinyServer(function(input, output) {
  })

  shinyApp(ui, server)
}
```
