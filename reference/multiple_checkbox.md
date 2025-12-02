# Create Semantic UI multiple checkbox

This creates a multiple checkbox using Semantic UI styles.

## Usage

``` r
multiple_checkbox(
  input_id,
  label,
  choices,
  choices_value = choices,
  selected = NULL,
  position = "grouped",
  type = NULL,
  ...
)

multiple_radio(
  input_id,
  label,
  choices,
  choices_value = choices,
  selected = choices_value[1],
  position = "grouped",
  type = "radio",
  ...
)
```

## Arguments

- input_id:

  Input name. Reactive value is available under `input[[input_id]]`.

- label:

  Text to be displayed with checkbox.

- choices:

  Vector of labels to show checkboxes for.

- choices_value:

  Vector of values that should be used for corresponding choice. If not
  specified, `choices` is used by default.

- selected:

  The value(s) that should be chosen initially. If `NULL` the first one
  from `choices` is chosen.

- position:

  Specified checkmarks setup. Can be `grouped` or `inline`.

- type:

  Type of checkbox or radio.

- ...:

  Other arguments to be added as attributes of the tag (e.g. style,
  childrens etc.)

## Details

The following `type`s are allowed:

- NULL The standard checkbox (default)

- toggle Each checkbox has a toggle form

- slider Each checkbox has a simple slider form

## Examples

``` r
## Only run examples in interactive R sessions
if (interactive()) {
  # Checkbox
  library(shiny)
  library(shiny.semantic)

  ui <- function() {
      shinyUI(
        semanticPage(
          title = "Checkbox example",
          h1("Checkboxes"),
          multiple_checkbox("checkboxes", "Select Letters", LETTERS[1:6], selected = "A"),
          p("Selected letters:"),
          textOutput("selected_letters"),
          tags$br(),
          h1("Radioboxes"),
          multiple_radio("radioboxes", "Select Letter", LETTERS[1:6], selected = "A"),
          p("Selected letter:"),
          textOutput("selected_letter")
       )
     )
  }

  server <- shinyServer(function(input, output) {
     output$selected_letters <- renderText(paste(input$checkboxes, collapse = ", "))
     output$selected_letter <- renderText(input$radioboxes)
  })

  shinyApp(ui = ui(), server = server)
}
```
