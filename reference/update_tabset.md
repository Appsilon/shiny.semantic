# Change the selected tab of a tabset on the client

Change the selected tab of a tabset on the client

## Usage

``` r
update_tabset(session, input_id, selected = NULL)
```

## Arguments

- session:

  The session object passed to function given to shinyServer.

- input_id:

  The id of the tabset object.

- selected:

  The id of the tab to be selected.

## Examples

``` r
if (interactive()){
 library(shiny)
 library(shiny.semantic)

 ui <- semanticPage(
   actionButton("changetab", "Select Second Tab"),
   tabset(
      tabs = list(
          list(menu = "First Tab", content = "First Tab", id= "first_tab"),
          list(menu = "Second Tab", content = "Second Tab", id = "second_tab")
      ),
      active = "first_tab",
      id = "exampletabset"
   )
 )

 server <- function(input, output, session) {
     observeEvent(input$changetab,{
         update_tabset(session, "exampletabset", "second_tab")
     })
 }

 shinyApp(ui, server)
}
```
