## Only run examples in interactive R sessions
if (interactive()){
  library(shiny)
  library(shiny.semantic)
  
  ui <- shinyUI(semanticPage(
    dropdown_menu(
      "Dropdown menu",
      icon(class = "dropdown"),
      menu(
        menu_header("Header"),
        menu_divider(),
        menu_item("Option 1"),
        menu_item("Option 2")
      ),
      name = "dropdown_menu",
      dropdown_specs = list("duration: 500")
    )
    
  ))
  server <- shinyServer(function(input, output) {
  })
  
  shinyApp(ui, server)
}

