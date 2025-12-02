# Using Fomantic UI JavaScript elements \[Advanced\]

## Using Fomantic UI JavaScript elements \[Advanced\]

Some Fomantic UI elements require to run a specific JS code when DOM
document is ready. There are at least 2 options to do this:

1.  Use `shinyjs`

``` r
library(shinyjs)
...
jsCode <- " # Fomantic UI componts JS "
...
ui <- function() {
  shinyUI(
    semanticPage(
      title = "Your page title",
      shinyjs::useShinyjs(),
      # Your UI code
    )
  )
}
server <- shinyServer(function(input, output) {
  runjs(jsCode)
  # Your Shiny logic
})
shinyApp(ui = ui(), server = server)
```

2.  Use `shiny::tags$script()`

``` r
...
jsCode <- "
$(document).ready(function() {
  # Semantic UI components JS code, like:
  #$('.rating').rating('setting', 'clearable', true);
  #$('.disabled .rating').rating('disable');
})
...
"

ui <- function() {
  shinyUI(
    semanticPage(
      title = "My page",
      tags$script(jsCode),
      # Your UI code
    )
  )
}
...
server <- shinyServer(function(input, output) {
  # Your Shiny logic
})

shinyApp(ui = ui(), server = server)
```
