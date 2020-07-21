# ------------------------------------------------------------------------------
# Sidebar layout composed of main and sidebar panels
# ------------------------------------------------------------------------------
#'
#' Creates row wrapping specified elements
#' @param arg Element to be wrapped in row container
#' @return Row wrapping specified elements

get_row <- function(arg) {
  class <- "row"
  style <- "padding: 20px;"
  HTML(glue::glue("<div class='{class}' style='{style}'>{arg}</div>"))
}

#' Creates div containing elements in order or grid container for specific panels
#'
#' @param grid_list List to create grid from
#' @param ... Container's children elements
#' @return Div containing elements or grid container for specific panel

panel <- function(grid_list, ...) {
  args <- list(...)
  if(is.null(layout)) {
    div(lapply(args, get_row))
  } else {
    grid(grid_list$layout, grid_list$container_style, grid_list$area_styles, ...)
  }
}

#' Creates div containing elements in order or grid container for sidebar panel
#'
#' @param grid_list List to create grid from
#' @param ... Container's children elements
#' @export

sidebar_panel <- function(grid_list, ...) {
  panel(grid_list, ...)
  # adjustments for sidebar panel
}

#' Creates div containing elements in order or grid container for main panel
#'
#' @param grid_list List to create grid from
#' @param ... Container's children elements
#' @export

main_panel <- function(grid_list, ...) {
  panel(grid_list, ...)
  # adjustments for main panel
}

#' Creates grid layout composed of sidebar and main panels
#'
#' @param sidebar_panel Sidebar panel component
#' @param main_panel Main panel component
#' @param sidebar_width Width of sidebar panel in percents
#' @param mirrored If TRUE sidebar is located on the right side,
#' if FALSE - on the left side (default)
#' @param min_height Sidebar layout container keeps the minimum height, if
#' specified. It should be formatted as a string with css units
#' @param container_style CSS declarations for grid container
#' @param area_styles List of CSS declarations for each grid area inside container
#'
#' @return Container with sidebar and main panels
#' @examples
#'
#' sidebar_layout(
#'   sidebar_panel(
#'     grid = NULL,
#'     "Top Sidebar Item",
#'     "Middle Sidebar Item",
#'     "Bottom Sidebar Item"
#'   ),
#'   main_panel(
#'     grid = NULL,
#'     "Top Main Panel Item",
#'     "Middle Main Panel Item",
#'     "Bottom Main Panel Item"
#'   ),
#'   sidebar_width = 20,
#'   min_height = "400px",
#'   mirrored = FALSE,
#'   container_style = "background-color: white;",
#'   area_styles = list(
#'     sidebar_panel = "border: 5px solid orange; color: white;",
#'     main_panel = "border: 5px solid hotpink;"
#'   )
#' )
#'
#' sidebar_layout(
#'   sidebar_panel(
#'     grid_list = list(
#'       layout = grid_template(default = list(
#'         areas = rbind(
#'           c("top_left",    "top_right"   ),
#'           c("bottom_left", "bottom_right")
#'         ),
#'         cols_width = c("1fr", "2fr"),
#'         rows_height = c("2fr", "3fr")
#'       )),
#'       container_style = "
#'         border: 5px solid tomato;
#'         background-color: indigo;
#'       ",
#'       area_styles = list(
#'         top_right = "background-color: teal;",
#'         bottom_left = "background-color: coral;"
#'       )
#'     ),
#'     top_left = "Top left part of sidebar",
#'     top_right = "Top right part of sidebar",
#'     bottom_left = "Bottom left part of sidebar",
#'     bottom_right = "Bottom right part of sidebar"
#'   ),
#'   main_panel(
#'     grid_list = list(
#'       layout = grid_template(default = list(
#'         areas = rbind(
#'           c("top_left",    "top_center",    "top_right"   ),
#'           c("middle_left", "middle_center", "middle_right"),
#'           c("bottom_left", "bottom_center", "bottom_right")
#'         ),
#'         cols_width = c("1fr", "1fr"),
#'         rows_height = c("100px", "1fr", "30%")
#'       )),
#'       container_style = "
#'         background-color: darkseagreen;
#'         border: 5px solid cyan;
#'         color: black
#'       ",
#'       area_styles = list(
#'         top_left = "background-color: purple;",
#'         top_right = "background-color: ivory;",
#'         middle_center = "background-color: tomato;",
#'         bottom_left = "background-color: mediumslateblue;",
#'         bottom_right = "background-color: steelblue;"
#'       )
#'     ),
#'     top_left = "Top left part of main panel",
#'     top_center = "Top center part of main panel",
#'     top_right = "Top right part of main panel",
#'     middle_left = "Middle left part of main panel",
#'     middle_center = "Middle center part of main panel",
#'     middle_right = "Middle right part of main panel",
#'     bottom_left = "Bottom left part of main panel",
#'     bottom_center = "Bottom center part of main panel",
#'     bottom_right = "Bottom right part of main panel"
#'   ),
#'   sidebar_width = 20,
#'   min_height = "400px",
#'   mirrored = FALSE,
#'   container_style = "background-color: white;",
#'   area_styles = list(
#'     sidebar_panel = "border: 5px solid orange; color: white;",
#'     main_panel = "border: 5px solid hotpink;"
#'   )
#' )
#'
#' @export

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
      background-color: #ccc;
      {area_styles$sidebar_panel}
    "),
    main_panel = glue::glue("
      background-color: #fff;
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
