library(shiny)
library(shiny.semantic)
library(glue)

ui <- function() {
  shinyUI(semanticPage(
    title = "Sidebar Layout Test",
    theme = "spacelab",
    sidebar_layout(
      sidebar_panel(
        grid_list = list(
          layout = shiny.semantic::grid_template(default = list(
            areas = rbind(
              c("top_left",    "top_right"   ),
              c("bottom_left", "bottom_right")
            ),
            cols_width = c("1fr", "2fr"),
            rows_height = c("2fr", "3fr")
          )),
          container_style = "
            border: 5px solid tomato;
            background-color: indigo;
          ",
          area_styles = list(
            top_right = "background-color: teal;",
            bottom_left = "background-color: coral;"
          )
        ),
        top_left = "Top left part of sidebar",
        top_right = "Top right part of sidebar",
        bottom_left = "Bottom left part of sidebar",
        bottom_right = "Bottom right part of sidebar"
      ),
      main_panel(
        grid_list = list(
          layout = shiny.semantic::grid_template(default = list(
            areas = rbind(
              c("top_left",    "top_center",    "top_right"   ),
              c("middle_left", "middle_center", "middle_right"),
              c("bottom_left", "bottom_center", "bottom_right")
            ),
            cols_width = c("1fr", "1fr"),
            rows_height = c("100px", "1fr", "30%")
          )),
          container_style = "
            background-color: darkseagreen;
            border: 5px solid cyan;
            color: black
          ",
          area_styles = list(
            top_left = "background-color: purple;",
            top_right = "background-color: ivory;",
            middle_center = "background-color: tomato;",
            bottom_left = "background-color: mediumslateblue;",
            bottom_right = "background-color: steelblue;"
          )
        ),
        top_left = "Top left part of main panel",
        top_center = "Top center part of main panel",
        top_right = "Top right part of main panel",
        middle_left = "Middle left part of main panel",
        middle_center = "Middle center part of main panel",
        middle_right = "Middle right part of main panel",
        bottom_left = "Bottom left part of main panel",
        bottom_center = "Bottom center part of main panel",
        bottom_right = "Bottom right part of main panel"
      ),
      sidebar_width = 20,
      min_height = "600px",
      mirrored = FALSE,
      container_style = "background-color: white;",
      area_styles = list(
        sidebar_panel = "border: 5px solid orange; color: white;",
        main_panel = "border: 5px solid hotpink;"
      )
    )
  ))
}

server <- shinyServer(function(input, output) {})
shinyApp(ui = ui(), server = server)
