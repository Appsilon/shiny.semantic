# Create Semantic UI Text Input

This creates a default text input using Semantic UI. The input is
available under `input[[input_id]]`.

## Usage

``` r
text_input(
  input_id,
  label = NULL,
  value = "",
  type = "text",
  placeholder = NULL,
  attribs = list()
)

textInput(
  inputId,
  label,
  value = "",
  width = NULL,
  placeholder = NULL,
  type = "text"
)
```

## Arguments

- input_id:

  Input name. Reactive value is available under `input[[input_id]]`.

- label:

  character with label put on the left from the input

- value:

  Pass value if you want to have default text.

- type:

  Change depending what type of input is wanted. See details for
  options.

- placeholder:

  Text visible in the input when nothing is inputted.

- attribs:

  A named list of attributes to assign to the input.

- inputId:

  Input name. The same as `input_id`.

- width:

  The width of the input, eg. "40px"

## Details

The following `type` s are allowed:

- text The standard input

- textarea An extended space for text

- password A censored version of the text input

- email A special version of the text input specific for email addresses

- url A special version of the text input specific for URLs

- tel A special version of the text input specific for telephone numbers

The inputs are updateable by using
[`updateTextInput`](https://rdrr.io/pkg/shiny/man/updateTextInput.html)
or
[`updateTextAreaInput`](https://rdrr.io/pkg/shiny/man/updateTextAreaInput.html)
if `type = "textarea"`.

## Examples

``` r
## Only run examples in interactive R sessions
if (interactive()) {
  library(shiny)
  library(shiny.semantic)
  ui <- semanticPage(
    uiinput(
      text_input("ex", label = "Your text", type = "text", placeholder = "Enter Text")
    )
  )
  server <- function(input, output, session) {
 }
 shinyApp(ui, server)
 }
```
