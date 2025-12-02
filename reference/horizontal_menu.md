# Horizontal menu

Renders UI with horizontal menu

## Usage

``` r
horizontal_menu(menu_items, active_location = "", logo = NULL)
```

## Arguments

- menu_items:

  list with list that can have fields: "name" (mandatory), "link" and
  "icon"

- active_location:

  active location of the menu (should match one from "link")

- logo:

  optional argument that displays logo on the left of horizontal menu,
  can be character with image location, or shiny image object

## Value

shiny div with horizontal menu

## Examples

``` r
library(shiny.semantic)
menu_content <- list(
 list(name = "AA", link = "http://example.com", icon = "dog"),
 list(name = "BB", link = "#", icon="cat"),
 list(name = "CC")
)
if (interactive()){
  ui <- semanticPage(
   horizontal_menu(menu_content)
  )
  server <- function(input, output, session) {}
  shinyApp(ui, server)
}
```
