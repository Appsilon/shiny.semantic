# Create Semantic UI Dropdown

This creates a dropdown using Semantic UI.

## Usage

``` r
dropdown_menu(
  ...,
  class = "",
  name,
  is_menu_item = FALSE,
  dropdown_specs = list()
)
```

## Arguments

- ...:

  Dropdown content.

- class:

  class of the dropdown. Look at
  https://semantic-ui.com/modules/dropdown.html for all possibilities.

- name:

  Unique name of the created dropdown.

- is_menu_item:

  TRUE if the dropdown is a menu item. Default is FALSE.

- dropdown_specs:

  A list of dropdown functionalities. Look at
  https://semantic-ui.com/modules/dropdown.html#/settings for all
  possibilities.

## Examples

``` r
## Only run examples in interactive R sessions
if (interactive()){
  library(shiny)
  library(shiny.semantic)

  ui <- shinyUI(semanticPage(
    dropdown_menu(
      "Dropdown menu",
      icon(class = "dropdown"),
      menu(
        menu_header("Header"),
        menu_divider(),
        menu_item("Option 1"),
        menu_item("Option 2")
      ),
      name = "dropdown_menu",
      dropdown_specs = list("duration: 500")
    )

  ))
  server <- shinyServer(function(input, output) {
  })

  shinyApp(ui, server)
}
```
