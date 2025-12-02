# Show and remove Semantic UI toast

These functions either create or remove a toast notifications with
Semantic UI styling.

## Usage

``` r
toast(
  message,
  title = NULL,
  action = NULL,
  duration = 3,
  id = NULL,
  class = "",
  toast_tags = NULL,
  session = shiny::getDefaultReactiveDomain()
)

close_toast(id, session = shiny::getDefaultReactiveDomain())

showNotification(
  ui,
  action = NULL,
  duration = 5,
  closeButton = TRUE,
  id = NULL,
  type = c("default", "message", "warning", "error"),
  session = getDefaultReactiveDomain(),
  ...
)

removeNotification(id, session = shiny::getDefaultReactiveDomain())
```

## Arguments

- message:

  Content of the message.

- title:

  A title given to the toast. Defauly is empty (`""`).

- action:

  A list of lists containing settings for buttons/options to select
  within the

- duration:

  Length in seconds for the toast to appear, default is 3 seconds. To
  make it not automatically close, set to 0.

- id:

  A unique identifier for the notification. It is optional for `toast`,
  but required for `close_toast`.

- class:

  Classes except "ui toast" to be added to the toast. Semantic UI
  classes can be used. Default "".

- toast_tags:

  Other toast elements. Default NULL.

- session:

  Session object to send notification to.

- ui:

  Content of the toast.

- closeButton:

  Logical, should a close icon appear on the toast?

- type:

  Type of toast

- ...:

  Arguments that can be passed to `toast`

## See also

<https://fomantic-ui.com/modules/toast>

## Examples

``` r
## Create a simple server toast
library(shiny)
library(shiny.semantic)

ui <- function() {
  shinyUI(
    semanticPage(
      actionButton("show", "Show toast")
    )
  )
}

server = function(input, output) {
  observeEvent(input$show, {
    toast(
      "This is an important message!"
    )
  })
}
if (interactive()) shinyApp(ui, server)

## Create a toast with options
ui <- semanticPage(
  actionButton("show", "Show"),
)
server <- function(input, output) {
  observeEvent(input$show, {
    toast(
      title  = "Question",
      "Do you want to see more?",
      duration = 0,
      action = list(
        list(
          text = "OK", class = "green", icon = "check",
          click = ("(function() { $('body').toast({message:'Yes clicked'}); })")
        ),
        list(
          text = "No", class = "red", icon = "times",
          click = ("(function() { $('body').toast({message:'No ticked'}); })")
        )
      )
    )
  })
}

if (interactive()) shinyApp(ui, server)

## Closing a toast
ui <- semanticPage(
  action_button("show", "Show"),
  action_button("remove", "Remove")
)
server <- function(input, output) {
  # A queue of notification IDs
  ids <- character(0)
  # A counter
  n <- 0

  observeEvent(input$show, {
    # Save the ID for removal later
    id <- toast(paste("Message", n), duration = NULL)
    ids <<- c(ids, id)
    n <<- n + 1
  })

  observeEvent(input$remove, {
    if (length(ids) > 0)
      close_toast(ids[1])
    ids <<- ids[-1]
  })
}

if (interactive()) shinyApp(ui, server)
```
