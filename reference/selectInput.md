# Create a select list input control

Create a select list that can be used to choose a single or multiple
items from a list of values.

## Usage

``` r
selectInput(
  inputId,
  label,
  choices,
  selected = NULL,
  multiple = FALSE,
  width = NULL,
  ...
)
```

## Arguments

- inputId:

  The input slot that will be used to access the value.

- label:

  Display label for the control, or NULL for no label.

- choices:

  List of values to select from. If elements of the list are named, then
  that name — rather than the value — is displayed to the user.

- selected:

  The initially selected value (or multiple values if multiple = TRUE).
  If not specified then defaults to the first value for single-select
  lists and no values for multiple select lists.

- multiple:

  Is selection of multiple items allowed?

- width:

  The width of the input.

- ...:

  Arguments passed to
  [dropdown_input](https://appsilon.github.io/shiny.semantic/reference/dropdown_input.md).

## Examples

``` r
## Only run examples in interactive R sessions
if (interactive()) {

  library(shiny.semantic)

  # basic example
  shinyApp(
    ui = semanticPage(
      selectInput("variable", "Variable:",
                  c("Cylinders" = "cyl",
                    "Transmission" = "am",
                    "Gears" = "gear")),
      tableOutput("data")
    ),
    server = function(input, output) {
      output$data <- renderTable({
        mtcars[, c("mpg", input$variable), drop = FALSE]
      }, rownames = TRUE)
    }
  )
}
```
