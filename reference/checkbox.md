# Create Semantic UI checkbox

Create Semantic UI checkbox

## Usage

``` r
checkbox_input(
  input_id,
  label = "",
  type = NULL,
  is_marked = TRUE,
  style = NULL
)

checkboxInput(inputId, label = "", value = FALSE, width = NULL)

toggle(input_id, label = "", is_marked = TRUE, style = NULL)
```

## Arguments

- input_id:

  Input name. Reactive value is available under input\[\[name\]\].

- label:

  Text to be displayed with checkbox.

- type:

  Type of checkbox: NULL, 'toggle'

- is_marked:

  Defines if checkbox should be marked. Default TRUE.

- style:

  Style of the widget.

- inputId:

  same as `input_id`

- value:

  same as `is_marked`

- width:

  The width of the input (currently not supported, but check `style`)

## Details

The inputs are updateable by using
[`updateCheckboxInput`](https://rdrr.io/pkg/shiny/man/updateCheckboxInput.html).

The following `type`s are allowed:

- NULL The standard checkbox (default)

- toggle Each checkbox has a toggle form

- slider Each checkbox has a simple slider form

## Examples

``` r
if (interactive()){
  ui <- shinyUI(
    semanticPage(
      p("Simple checkbox:"),
      checkbox_input("example", "Check me", is_marked = FALSE),
      p(),
      p("Simple toggle:"),
      toggle("tog1", "My Label", TRUE)
    )
  )
  server <- function(input, output, session) {
    observeEvent(input$tog1, {
      print(input$tog1)
    })
  }
  shinyApp(ui, server)
}
```
