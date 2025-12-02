# Create Semantic UI Calendar

This creates a default calendar input using Semantic UI. The input is
available under `input[[input_id]]`.

This function updates the date on a calendar

## Usage

``` r
calendar(
  input_id,
  value = NULL,
  placeholder = NULL,
  type = "date",
  min = NA,
  max = NA
)

update_calendar(session, input_id, value = NULL, min = NULL, max = NULL)
```

## Arguments

- input_id:

  ID of the calendar that will be updated

- value:

  Initial value of the numeric input.

- placeholder:

  Text visible in the input when nothing is inputted.

- type:

  Select from `'year'`, `'month'`, `'date'` and `'time'`

- min:

  Minimum allowed value.

- max:

  Maximum allowed value.

- session:

  The `session` object passed to function given to `shinyServer`.

## Examples

``` r
# Basic calendar
if (interactive()) {

  library(shiny)
  library(shiny.semantic)

  ui <- shinyUI(
    semanticPage(
      title = "Calendar example",
      calendar("date"),
      p("Selected date:"),
      textOutput("selected_date")
    )
  )

   server <- shinyServer(function(input, output, session) {
     output$selected_date <- renderText(
       as.character(input$date)
     )
   })

   shinyApp(ui = ui, server = server)
 }

if (FALSE) { # \dontrun{
# Calendar with max and min
calendar(
  name = "date_finish",
  placeholder = "Select End Date",
  min = "2019-01-01",
  max = "2020-01-01"
)

# Selecting month
calendar(
  name = "month",
  type = "month"
)
} # }
```
