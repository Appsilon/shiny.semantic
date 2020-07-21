library(shiny)
library(shiny.semantic)
library(glue)
library(dplyr)

# Functions --------------------------------------------------------------------
get_row <- function(arg) {
  class <- "row"
  style <- "padding: 20px;"
  HTML(glue::glue("<div class='{class}' style='{style}'>{arg}</div>"))
}

default_sidebar_panel_grid = grid(
  grid_template = grid_template(default = list(
    areas = rbind(c("")),
    cols_width = c("1fr")
  )),
  container_style = "background-color: tomato; align-content: start;"
)

# Panels -----------------------------------------------------------------------

panel <- function(grid, ...) {
  args <- list(...)
  if(is.null(layout)) {
    div(lapply(args, get_row))
  } else {
    grid(grid$layout, grid$container_style, grid$area_styles, ...)
  }
}

sidebar_panel <- function(grid, ...) {
  panel(grid, ...)
  # adjustments for sidebar panel
}

main_panel <- function(grid, ...) {
  panel(grid, ...)
  # adjustments for main panel
}

# Sidebar Layout ---------------------------------------------------------------

sidebar_layout <- function(sidebar_panel,
                           main_panel,
                           sidebar_width,
                           mirrored = FALSE,
                           min_height = "auto",
                           container_style,
                           area_styles) {

  # set normal or mirrored sidebar layout
  if (!mirrored) {
    layout <- grid_template(default = list(
      areas = rbind(c("sidebar_panel", "main_panel")),
      cols_width = c(glue::glue("{sidebar_width}%"), "1fr")
    ))
  } else {
    layout <- grid_template(default = list(
      areas = rbind(c("main_panel", "sidebar_panel")),
      cols_width = c("1fr", glue::glue("{sidebar_width}%"))
    ))
  }

  # grid container's default styling
  container_style <- glue::glue("
    height: auto;
    min-height: {min_height};
    {container_style}
  ")

  # grid container's children default styling
  area_styles <- list(
    sidebar_panel = glue::glue("
      border: 1px solid orange;
      {area_styles$sidebar_panel}
    "),
    main_panel = glue::glue("
      border: 1px solid blue;
      {area_styles$main_panel}
    ")
  )

  grid(
    layout,
    container_style,
    area_styles,
    sidebar_panel = sidebar_panel,
    main_panel = main_panel
  )
}

# UI ---------------------------------------------------------------------------
ui <- function() {
  shinyUI(semanticPage(
    title = "Sidebar Layout Test",
    theme = "spacelab",
    sidebar_layout(
      # sidebar_panel(
      #   grid = NULL,
      #   "Side Item 1",
      #   "Side Item 2",
      #   "Side Item 3"
      # ),
      # main_panel(
      #   grid = NULL,
      #   "Main 1",
      #   "Main 2",
      #   "Main 3",
      #   "Main 4"
      # ),
      sidebar_panel(
        grid = list(
          layout = grid_template(default = list(
            areas = rbind(
              c("top_left",    "top_right"   ),
              c("bottom_left", "bottom_right")
            ),
            cols_width = c("1fr", "2fr"),
            rows_height = c("2fr", "3fr")
          )),
          container_style = "border: 5px solid tomato;background-color: black;",
          area_styles = list(
            bottom_left = "background-color: yellow;",
            bottom_right = "background-color: teal;"
          )
        ),
        top_left = "Top left part of sidebar",
        top_right = "Top right part of sidebar",
        bottom_left = "Bottom left part of sidebar",
        bottom_right = "Bottom right part of sidebar"
      ),
      main_panel(
        grid = list(
          layout = grid_template(default = list(
            areas = rbind(
              c("top_left",    "top_center",    "top_right"   ),
              c("middle_left", "middle_center", "middle_right"),
              c("bottom_left", "bottom_center", "bottom_right")
            ),
            cols_width = c("1fr", "1fr"),
            rows_height = c("100px", "1fr", "30%")
          )),
          container_style = "border: 5px solid cyan; color: black",
          area_styles = list(
            top_left = "background-color: purple;",
            middle_center = "background-color: tomato;"
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
      min_height = "400px",
      mirrored = FALSE,
      container_style = "background-color: white;",
      area_styles = list(
        sidebar_panel = "border: 5px solid orange; color: white;",
        main_panel = "border: 5px solid hotpink;"
      )
    )
  ))
}

# SERVER -----------------------------------------------------------------------
server <- shinyServer(function(input, output) {})
shinyApp(ui = ui(), server = server)
