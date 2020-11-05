## Only run examples in interactive R sessions
if (interactive()) {
  library(shiny)
  library(shiny.semantic)
  
  ui <- function() {
    shinyUI(
      semanticPage(
        title = "My page",
        menu(menu_item("Menu"),
             dropdown_menu(
               "Action",
               menu(
                 menu_header(icon("file"), "File", is_item = FALSE),
                 menu_item(icon("wrench"), "Open"),
                 menu_item(icon("upload"), "Upload"),
                 menu_item(icon("remove"), "Upload"),
                 menu_divider(),
                 menu_header(icon("user"), "User", is_item = FALSE),
                 menu_item(icon("add user"), "Add"),
                 menu_item(icon("remove user"), "Remove")),
               class = "",
               name = "unique_name",
               is_menu_item = TRUE),
             menu_item(icon("user"), "Profile", href = "#index", item_feature = "active"),
             menu_item("Projects", href = "#projects"),
             menu_item(icon("users"), "Team"),
             menu(menu_item(icon("add icon"), "New tab"), class = "right"))
      )
    )
  }
  server <- shinyServer(function(input, output) {})
  shinyApp(ui = ui(), server = server)
}
