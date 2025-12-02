# Create dropdown Semantic UI component

This creates a default \*dropdown_input\* using Semantic UI styles with
Shiny input. Dropdown is already initialized and available under
input\[\[input_id\]\].

## Usage

``` r
dropdown_input(
  input_id,
  choices,
  choices_value = choices,
  default_text = "Select",
  value = NULL,
  type = "selection fluid"
)
```

## Arguments

- input_id:

  Input name. Reactive value is available under input\[\[input_id\]\].

- choices:

  All available options one can select from.

- choices_value:

  What reactive value should be used for corresponding choice.

- default_text:

  Text to be visible on dropdown when nothing is selected.

- value:

  Pass value if you want to initialize selection for dropdown.

- type:

  Change depending what type of dropdown is wanted.

## Examples

``` r
## Only run examples in interactive R sessions
if (interactive()) {
library(shiny)
library(shiny.semantic)
ui <- semanticPage(
  title = "Dropdown example",
  dropdown_input("simple_dropdown", LETTERS, value = "A"),
  p("Selected letter:"),
  textOutput("dropdown")
)
server <- function(input, output) {
  output$dropdown <- renderText(input[["simple_dropdown"]])
}

shinyApp(ui = ui, server = server)
}
```
