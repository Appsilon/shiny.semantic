# Define simple date input with Semantic UI styling

Define simple date input with Semantic UI styling

## Usage

``` r
date_input(
  input_id,
  label = NULL,
  value = NULL,
  min = NULL,
  max = NULL,
  style = NULL,
  icon_name = "calendar"
)

dateInput(
  inputId,
  label = NULL,
  icon = NULL,
  value = NULL,
  min = NULL,
  max = NULL,
  width = NULL,
  ...
)
```

## Arguments

- input_id:

  Input id.

- label:

  Label to be displayed with date input.

- value:

  Default date chosen for input.

- min:

  Minimum date that can be selected.

- max:

  Maximum date that can be selected.

- style:

  Css style for widget.

- icon_name:

  Icon that should be displayed on widget.

- inputId:

  Input id.

- icon:

  Icon that should be displayed on widget.

- width:

  character width of the object

- ...:

  other arguments

## Examples

``` r
if (interactive()) {
# Below example shows how to implement simple date range input using \code{date_input}

library(shiny)
library(shiny.semantic)

ui <- shinyUI(
  semanticPage(
    title = "Date range example",
    uiOutput("date_range"),
    p("Selected dates:"),
    textOutput("selected_dates")
  )
)

server <- shinyServer(function(input, output, session) {
  output$date_range <- renderUI({
    tagList(
      tags$div(tags$div(HTML("From")),
               date_input("date_from", value = Sys.Date() - 30, style = "width: 10%;")),
      tags$div(tags$div(HTML("To")),
               date_input("date_to", value = Sys.Date(), style = "width: 10%;"))
    )
  })

  output$selected_dates <- renderPrint({
    c(input$date_from, input$date_to)
  })
})

shinyApp(ui = ui, server = server)
}
```
