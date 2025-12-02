# Change the label or icon of an action button on the client

Change the label or icon of an action button on the client

## Usage

``` r
update_action_button(session, input_id, label = NULL, icon = NULL)

updateActionButton(session, inputId, label = NULL, icon = NULL)
```

## Arguments

- session:

  The session object passed to function given to shinyServer.

- input_id:

  The id of the input object.

- label:

  The label to set for the input object.

- icon:

  The icon to set for the input object. To remove the current icon, use
  icon=character(0)

- inputId:

  the same as `input_id`

## Examples

``` r
if (interactive()){
library(shiny)
library(shiny.semantic)

ui <- semanticPage(
  actionButton("update", "Update button"),
  br(),
  actionButton("go_button", "Go")
)

server <- function(input, output, session) {
  observe({
    req(input$update)

    # Updates go_button's label and icon
    updateActionButton(session, "go_button",
                       label = "New label",
                       icon = icon("calendar"))

  })
}
shinyApp(ui, server)
}
```
