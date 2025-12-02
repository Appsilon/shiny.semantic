# Create Semantic UI tabs

This creates tabs with content using Semantic UI styles.

## Usage

``` r
tabset(
  tabs,
  active = NULL,
  id = generate_random_id("menu"),
  menu_class = "top attached tabular",
  tab_content_class = "bottom attached grid segment"
)
```

## Arguments

- tabs:

  A list of tabs. Each tab is a list of three elements - first element
  defines menu item, second element defines tab content, third optional
  element defines tab id.

- active:

  Id of the active tab. If NULL first tab will be active.

- id:

  Id of the menu element (default: randomly generated id)

- menu_class:

  Class for the menu element (default: "top attached tabular")

- tab_content_class:

  Class for the tab content (default: "bottom attached segment")

## Details

You may access active tab id with `input$<id>`.

## See also

update_tabset

## Examples

``` r
## Only run examples in interactive R sessions
if (interactive()){
  library(shiny)
  library(shiny.semantic)

  ui <- semanticPage(
    tabset(tabs =
             list(
               list(menu = "First Tab", content = "Tab 1"),
               list(menu = "Second Tab", content = "Tab 2", id = "second_tab")
             ),
           active = "second_tab",
           id = "exampletabset"
    ),
    h2("Active Tab:"),
    textOutput("activetab")
  )
  server <- function(input, output) {
      output$activetab <- renderText(input$exampletabset)
  }
  shinyApp(ui, server)
}
```
