# ------------------------------------------------------------------------------
# Sidebar layout composed of main and sidebar panels
# ------------------------------------------------------------------------------
#'
#' @param arg Element to be wrapped in row container
#' @return Row wrapping specified elements

get_row <- function(arg) {
  class <- "row"
  style <- "padding: 20px;"
  HTML(glue::glue("<div class='{class}' style='{style}'>{arg}</div>"))
}

# Panels -----------------------------------------------------------------------
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

#' @export

sidebar_panel <- function(grid_list, ...) {
  panel(grid_list, ...)
  # adjustments for sidebar panel
}

#' @export

main_panel <- function(grid_list, ...) {
  panel(grid_list, ...)
  # adjustments for main panel
}

# Sidebar Layout ---------------------------------------------------------------
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
#'
#' @examples
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
