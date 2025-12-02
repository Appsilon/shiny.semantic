# Create Semantic UI list with header, description and icons

This creates a list with icons using Semantic UI

## Usage

``` r
list_container(content_list, is_divided = FALSE)
```

## Arguments

- content_list:

  list of lists with fields: \`header\` and/or \`description\`, \`icon\`
  containing the list items headers, descriptions (one of these is
  mandatory) and icons. Icon column should contain strings with icon
  names available here: https://fomantic-ui.com/elements/icon.html

- is_divided:

  If TRUE created list elements are divided

## Examples

``` r
library(shiny)
#> 
#> Attaching package: ‘shiny’
#> The following objects are masked from ‘package:shiny.semantic’:
#> 
#>     Progress, actionButton, checkboxInput, dateInput, fileInput,
#>     flowLayout, icon, incProgress, modalDialog, numericInput,
#>     removeModal, removeNotification, selectInput, setProgress,
#>     showNotification, sliderInput, splitLayout, textAreaInput,
#>     textInput, updateActionButton, updateSelectInput,
#>     updateSliderInput, verticalLayout, withProgress
library(shiny.semantic)
list_content <- list(
  list(header = "Head", description = "Lorem ipsum", icon = "cat"),
  list(header = "Head 2", icon = "tree"),
  list(description = "Lorem ipsum 2", icon = "dog")
)
if (interactive()){
  ui <- semanticPage(
    list_container(list_content, is_divided = TRUE)
 )
  server <- function(input, output) {}
  shinyApp(ui, server)
}
```
