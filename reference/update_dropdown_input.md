# Update dropdown Semantic UI component

Change the value of a
[`dropdown_input`](https://appsilon.github.io/shiny.semantic/reference/dropdown_input.md)
input on the client.

## Usage

``` r
update_dropdown_input(
  session,
  input_id,
  choices = NULL,
  choices_value = choices,
  value = NULL
)
```

## Arguments

- session:

  The `session` object passed to function given to `shinyServer`.

- input_id:

  The id of the input object

- choices:

  All available options one can select from. If no need to update then
  leave as `NULL`

- choices_value:

  What reactive value should be used for corresponding choice.

- value:

  A value to update dropdown to. Defaults to `NULL`.

  - a value from `choices` updates the selection

  - `character(0)` and `""` clear the selection

  - `NULL`:

    - clears the selection if `choices` is provided

    - otherwise, `NULL` does not change the selection

  - a value not found in `choices` does not change the selection

## Examples

``` r
if (interactive()) {
  library(shiny)
  library(shiny.semantic)

  ui <- semanticPage(
    title = "Dropdown example",
    dropdown_input("simple_dropdown", LETTERS[1:5], value = "A", type = "selection multiple"),
    p("Selected letter:"),
    textOutput("selected_letter"),
    shiny.semantic::actionButton("simple_button", "Update input to D")
  )

  server <- function(input, output, session) {
    output$selected_letter <- renderText(paste(input[["simple_dropdown"]], collapse = ", "))

    observeEvent(input$simple_button, {
      update_dropdown_input(session, "simple_dropdown", value = "D")
    })
  }

  shinyApp(ui, server)
}
```
