#' Generate CSS string representing grid template areas.
#' @param areas_dataframe data.frame of character representing grid areas
#' @return character
#' @details This is a helper function used in grid_template()
#'
#' \preformatted{
#' areas_dataframe <- rbind(
#'    c("header", "header", "header"),
#'    c("menu",   "main",   "right1"),
#'    c("menu",   "main",   "right2")
#' )
#'
#' result == "'header header header' 'menu main right1' 'menu main right2'"
#' }
#'
data_frame_to_css_grid_template_areas <- function(areas_dataframe) {
  apply(areas_dataframe, 1, function(row) paste(row, collapse = ' ')) %>%
    lapply(function(row) glue::glue("'{row}'")) %>%
    paste(collapse = ' ')
}

#' Generate template string representing CSS styles of grid container div.
#'
#' @param css_grid_template_areas character, CSS value for grid-template-areas
#' @param rows_height vector of character
#' @param cols_width vector of character
#'
#' @return character
#' @details This is a helper function used in grid_template()
#' \preformatted{
#'   grid_container_css(
#'     "'a a a' 'b b b'",
#'     c("50\%", "50\%"),
#'     c("100px", "2fr", "1fr")
#'   )
#' }
#' returns
#' \preformatted{
#'   "display: grid;
#'    height: 100\%;
#'    grid-template-rows: 50\% 50\%;
#'    grid-template-columns: 100px 2fr 1fr;
#'    grid-template-areas: 'a a a' 'b b b';
#'    {{ custom_style_grid_container }}"
#' }
#'
grid_container_css <- function(css_grid_template_areas, rows_height, cols_width) {
  grid_container_styles <- c(
    "display: grid",
    "height: 100%",
    glue::glue("grid-template-rows: {paste(rows_height, collapse = ' ')}"),
    glue::glue("grid-template-columns: {paste(cols_width, collapse = ' ')}"),
    glue::glue("grid-template-areas: {css_grid_template_areas}"),
    "{{ custom_style_grid_container }}" # To be rendered by htmltools::htmlTemplate() later
  )
  paste(grid_container_styles, collapse = "; ")
}

#' Generate list of HTML div elements representing grid areas.
#'
#' @param area_names vector with area names
#'
#' @return list of \code{shiny::tags$div}
#'
#' @details This is a helper function used in grid_template()
#' \preformatted{
#'   list_of_area_tags(c("header", "main", "footer"))
#' }
#' returns the following list:
#' \preformatted{
#'   [[1]] <div id="area-header" style="grid-area: header; {{ header_custom_css }}">{{ header }}</div>
#'   [[2]] <div id="area-main" style="grid-area: main; {{ main_custom_css }}">{{ main }}</div>
#'   [[3]] <div id="area-footer" style="grid-area: footer; {{ footer_custom_css }}">{{ footer }}</div>
#' }
#'
list_of_area_tags <- function(area_names) {
  lapply(area_names,
    function(name) shiny::tags$div(
      id = as.character(glue::glue("area-{name}")),
      style = paste0("grid-area: ", name, "; {{ ", name, "_custom_css }}"),
      paste("{{", name, "}}")
    )
  )
}

#' Define a template of a CSS grid
#'
#' @param default
#' Template for desktop:
#' list(areas = [data.frame of character],
#'      rows_height = [vector of character],
#'      cols_width = [vector of character])
#' @param mobile
#' Template for mobile:
#' list(areas = [data.frame of character],
#'      rows_height = [vector of character],
#'      cols_width = [vector of character])
#'
#' @return
#' list(template = [character], area_names = [vector of character])
#'
#' template - contains template that can be formatted with glue::glue() function
#'
#' area_names - contain all unique area names used in grid definition
#'
#' @examples
#' myGrid <- grid_template(default = list(
#'   areas = rbind(
#'     c("header", "header", "header"),
#'     c("menu",   "main",   "right1"),
#'     c("menu",   "main",   "right2")
#'   ),
#'   rows_height = c("50px", "auto", "100px"),
#'   cols_width = c("100px", "2fr", "1fr")
#' ))
#' if (interactive()) display_grid(myGrid)
#' subGrid <- grid_template(default = list(
#'   areas = rbind(
#'     c("top_left", "top_right"),
#'     c("bottom_left", "bottom_right")
#'   ),
#'   rows_height = c("50%", "50%"),
#'   cols_width = c("50%", "50%")
#' ))
#'
#' if (interactive()) display_grid(subGrid)
#' @export
grid_template <- function(
  default = list(areas = rbind(c("main_area")), rows_height = c("100%"), cols_width = c("100%")),
  mobile = list(areas = rbind(c("main_area")), rows_height = c("100%"), cols_width = c("100%"))) {
  # TODO: Support for mobile grid version. Only `default` argument is used right now.

  area_names <- default$areas %>% as.vector %>% unique
  css_grid_template_areas <- data_frame_to_css_grid_template_areas(default$areas)

  grid_template <- shiny::tags$div(
    style = grid_container_css(css_grid_template_areas, default$rows_height, default$cols_width),
    shiny::tagList(list_of_area_tags(area_names))
  ) %>% htmltools::renderTags()

  return(list(template = grid_template$html, area_names = area_names))
}

#' Use CSS grid template in Shiny UI
#'
#' @param grid_template grid template created with grid_template() function
#' @param container_style character - string of custom CSS for the main grid container
#' @param area_styles list of custom CSS styles for provided area names
#' @param display_mode replaces areas HTML content with <area name> text. Used by display_grid() function
#' @param ... areas HTML content provided by named arguments
#'
#' @return Rendered HTML ready to use by Shiny UI. See \code{htmltools::htmlTemplate()} for more details.
#'
#' @details
#' Grids can be nested.
#'
#' @examples
#' myGrid <- grid_template(default = list(
#'   areas = rbind(
#'     c("header", "header", "header"),
#'     c("menu",   "main",   "right1"),
#'     c("menu",   "main",   "right2")
#'   ),
#'   rows_height = c("50px", "auto", "100px"),
#'   cols_width = c("100px", "2fr", "1fr")
#' ))
#'
#' subGrid <- grid_template(default = list(
#'   areas = rbind(
#'     c("top_left", "top_right"),
#'     c("bottom_left", "bottom_right")
#'   ),
#'   rows_height = c("50%", "50%"),
#'   cols_width = c("50%", "50%")
#' ))
#'
#' if (interactive()){
#' library(shiny)
#' library(shiny.semantic)
#' shinyApp(
#'   ui = semanticPage(
#'     grid(myGrid,
#'          container_style = "border: 1px solid #f00",
#'          area_styles = list(header = "background: #0099f9",
#'                             menu = "border-right: 1px solid #0099f9"),
#'          header = div(shiny::tags$h1("Hello CSS Grid!")),
#'          menu = checkbox_input("example", "Check me", is_marked = FALSE),
#'          main = grid(subGrid,
#'                      top_left = calendar("my_calendar"),
#'                      top_right = div("hello 1"),
#'                      bottom_left = div("hello 2"),
#'                      bottom_right = div("hello 3")
#'          ),
#'          right1 = div(
#'            toggle("toggle", "let's toggle"),
#'            multiple_checkbox("mycheckbox", "mycheckbox",
#'                              c("option A","option B","option C"))),
#'          right2 = div("right 2")
#'     )
#'   ),
#'   server = shinyServer(function(input, output) {})
#' )
#' }
#' @export
grid <- function(grid_template, container_style = "", area_styles = list(), display_mode = FALSE, ...) {

  if (display_mode) {
    # For debugging mode just display area name
    template_variables <- as.list(setNames(grid_template$area_names, grid_template$area_names))
  } else {
    template_variables <- list(...)
  }

  template_variables$custom_style_grid_container <- container_style

  for (name in grid_template$area_names) {
    key <- glue::glue("{name}_custom_css")
    template_variables[[key]] <- ifelse(name %in% names(area_styles), area_styles[[name]], "")
  }

  do.call(function(...) htmltools::htmlTemplate(text_ = grid_template$template, ...), template_variables)
}

#' Display grid template in a browser for easy debugging
#'
#' @param grid_template generated by grid_template() function
#' @details
#' Opens a browser and displays grid template with styled border to highlight existing areas.
#'
#' Warning: CSS can't be displayed in RStudio viewer pane. CSS grid is supported only by modern browsers.
#' You can see list of supported browsers here: https://www.w3schools.com/css/css_grid.asp
#'
#' @export
display_grid <- function(grid_template) {
  temporary_html_file <- glue::glue("grid_render_{as.numeric(Sys.time())}.html")

  # Apply dotted border to show all grid areas.
  # List looks like this: area_styles == list(area_1 = "border: 1px dotted #444", area_2 = ...)
  area_styles <- as.list(setNames(
    rep("border: 1px dotted #444", length(grid_template$area_names)),
    grid_template$area_names))

  html <- grid(grid_template, container_style = "border: 1px dashed #000",
               area_styles = area_styles, display_mode = TRUE)

  base::write(unlist(html), temporary_html_file)
  utils::browseURL(temporary_html_file)
  Sys.sleep(1) # Let's wait for browser to load the file until we delete it
  invisible(file.remove(temporary_html_file))
}
