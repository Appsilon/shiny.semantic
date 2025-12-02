# Update checkbox Semantic UI component

Change the value of a
[`multiple_checkbox`](https://appsilon.github.io/shiny.semantic/reference/multiple_checkbox.md)
input on the client.

## Usage

``` r
update_multiple_checkbox(
  session = getDefaultReactiveDomain(),
  input_id,
  choices = NULL,
  choices_value = choices,
  selected = NULL,
  label = NULL
)

update_multiple_radio(
  session = getDefaultReactiveDomain(),
  input_id,
  choices = NULL,
  choices_value = choices,
  selected = NULL,
  label = NULL
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

- selected:

  The initially selected value.

- label:

  The label linked to the input

## Examples

``` r
if (interactive()) {

library(shiny)
library(shiny.semantic)

ui <- function() {
  shinyUI(
    semanticPage(
      title = "Checkbox example",
      form(
        multiple_checkbox(
          "simple_checkbox", "Letters:", LETTERS[1:5], selected = c("A", "C"), type = "slider"
        )
      ),
      p("Selected letter:"),
      textOutput("selected_letter"),
      shiny.semantic::actionButton("simple_button", "Update input to D")
    )
  )
}

server <- shinyServer(function(input, output, session) {
  output$selected_letter <- renderText(paste(input[["simple_checkbox"]], collapse = ", "))

  observeEvent(input$simple_button, {
    update_multiple_checkbox(session, "simple_checkbox", selected = "D")
  })
})

shinyApp(ui = ui(), server = server)

}
```
