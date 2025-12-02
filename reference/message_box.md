# Create Semantic UI Message box

Create Semantic UI Message box

## Usage

``` r
message_box(header, content, class = "", icon_name, closable = FALSE)
```

## Arguments

- header:

  Header of the message box

- content:

  Content of the message box . If it is a vector, creates a list of
  vector's elements

- class:

  class of the message. Look at
  https://semantic-ui.com/collections/message.html for all
  possibilities.

- icon_name:

  If the message is of the type 'icon', specify the icon. Look at
  http://semantic-ui.com/elements/icon.html for all possibilities.

- closable:

  Determines whether the message should be closable. Default is FALSE -
  not closable

## Examples

``` r
## Only run examples in interactive R sessions
if (interactive()){
  library(shiny)
  library(shiny.semantic)

  ui <- shinyUI(semanticPage(
    message_box(header = "Main header", content = "text"),
    # message with icon
    message_box(class = "icon", header = "Main header", content = "text", icon_name = "dog"),
    # closable message
    message_box(header = "Main header", content = "text", closable =  TRUE),
    # floating
    message_box(class = "floating", header = "Main header", content = "text"),
    # compact
    message_box(class = "compact", header = "Main header", content = "text"),
    # warning
    message_box(class = "warning", header = "Warning", content = "text"),
    # info
    message_box(class = "info", header = "Info", content = "text")
  ))
  server <- shinyServer(function(input, output) {
  })

  shinyApp(ui, server)
}
```
