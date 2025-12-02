# Create Semantic UI File Input

This creates a default file input using Semantic UI. The input is
available under `input[[input_id]]`.

## Usage

``` r
file_input(
  input_id,
  label,
  multiple = FALSE,
  accept = NULL,
  button_label = "Browse...",
  type = NULL,
  placeholder = "no file selected",
  ...
)

fileInput(
  inputId,
  label,
  multiple = FALSE,
  accept = NULL,
  width = NULL,
  buttonLabel = "Browse...",
  placeholder = "No file selected",
  ...
)
```

## Arguments

- input_id, inputId:

  Input name. Reactive value is available under `input[[input_id]]`.

- label:

  Display label for the control, or NULL for no label.

- multiple:

  Whether the user should be allowed to select and upload multiple files
  at once.

- accept:

  A character vector of "unique file type specifiers" which gives the
  browser a hint as to the type of file the server expects. Many
  browsers use this prevent the user from selecting an invalid file.

- button_label, buttonLabel:

  Display label for the button.

- type:

  Input type specifying class attached to input container. See
  \[Fomantic UI\](https://fomantic-ui.com/collections/form.html) for
  details.

- placeholder:

  Inner input label displayed when no file has been uploaded.

- ...:

  Other parameters passed from `fileInput` to `file_input` like `type`.

- width:

  The width of the input, e.g. `'400px'`, or `'100%'`.

## Examples

``` r
## Only run examples in interactive R sessions
if (interactive()) {
  library(shiny)
  library(shiny.semantic)
  ui <- semanticPage(
    form(
      div(
        class = "ui grid",
        div(
          class = "four wide column",
          file_input("ex", "Select file"),
          header("File type selected:", textOutput("ex_file"))
        )
      )
    )
  )
  server <- function(input, output, session) {
    output$ex_file <- renderText({
      if (is.null(input)) return("No file uploaded")
      tools::file_ext(input$ex$datapath)
    })
  }
  shinyApp(ui, server)
}
```
