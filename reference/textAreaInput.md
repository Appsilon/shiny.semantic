# Create a semantic Text Area input

Create a text area input control for entry of unstructured text values.

## Usage

``` r
textAreaInput(inputId, label, value = "", width = NULL, placeholder = NULL)
```

## Arguments

- inputId:

  Input name. Reactive value is available under `input[[input_id]]`.

- label:

  character with label put above the input

- value:

  Pass value if you want to have default text.

- width:

  The width of the input, eg. "40px"

- placeholder:

  Text visible in the input when nothing is inputted.

## Examples

``` r
## Only run examples in interactive R sessions
if (interactive()) {
ui <- semanticPage(
  textAreaInput("a", "Area:", value = "200", width = "200px"),
  verbatimTextOutput("value")
)
server <- function(input, output, session) {
  output$value <- renderText({ input$a })
}
shinyApp(ui, server)
}
```
