# Add Semantic UI search selection dropdown based on provided choices

Define the (multiple) search selection dropdown input component serving
search options using provided choices.

## Usage

``` r
search_selection_choices(
  input_id,
  choices,
  value = NULL,
  multiple = FALSE,
  default_text = "Select",
  groups = NULL,
  dropdown_settings = list(forceSelection = FALSE)
)
```

## Arguments

- input_id:

  Input name. Reactive value is available under input\[\[input_id\]\].

- choices:

  Vector or a list of choices to search through.

- value:

  String with default values to set when initialize the component.
  Values should be delimited with a comma when multiple to set. Default
  NULL.

- multiple:

  TRUE if the dropdown should allow multiple selections, FALSE otherwise
  (default FALSE).

- default_text:

  Text to be visible on dropdown when nothing is selected.

- groups:

  Vector of length equal to choices, specifying to which group the
  choice belongs. Specifying the parameter enables group dropdown search
  implementation.

- dropdown_settings:

  Settings passed to dropdown() semantic-ui method. See
  https://semantic-ui.com/modules/dropdown.html#/settings

## Examples

``` r
## Only run examples in interactive R sessions
if (interactive()) {
  library(shiny)
  library(shiny.semantic)

  ui <- function() {
    shinyUI(
      semanticPage(
        title = "Dropdown example",
        uiOutput("search_letters"),
        p("Selected letter:"),
        textOutput("selected_letters")
      )
    )
  }

  server <- shinyServer(function(input, output, session) {
    choices <- LETTERS
    output$search_letters <- shiny::renderUI(
      search_selection_choices("search_result", choices, multiple = TRUE)
    )
    output$selected_letters <- renderText(input[["search_result"]])
  })

  shinyApp(ui = ui(), server = server)
}
```
