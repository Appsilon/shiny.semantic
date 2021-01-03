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
#'   [[1]] <div id="{{ grid_id }}-header" style="grid-area: header; {{ header_custom_css }}">{{ header }}</div>
#'   [[2]] <div id="{{ grid_id }}-main" style="grid-area: main; {{ main_custom_css }}">{{ main }}</div>
#'   [[3]] <div id="{{ grid_id }}-footer" style="grid-area: footer; {{ footer_custom_css }}">{{ footer }}</div>
#' }
#'
list_of_area_tags <- function(area_names) {
  lapply(area_names,
    function(name) {
      mustache_id <- "{{ grid_id }}"
      mustache_css <- paste0("{{ ", name, "_custom_css }}")
      mustache_area <- paste("{{", name, "}}")
      return(HTML(
        glue::glue('<div id="{mustache_id}-{name}" style="grid-area: {name}; {mustache_css}">{mustache_area}</div>')
      ))
    }
  )
}

#' Define a template of a CSS grid
#'
#' @param default (required)
#' Template for desktop:
#' list(areas = [data.frame of character],
#'      rows_height = [vector of character],
#'      cols_width = [vector of character])
#' @param mobile (optional)
#' Template for mobile (screen width below 768px):
#' list(areas = [data.frame of character],
#'      rows_height = [vector of character],
#'      cols_width = [vector of character])
#'
#' @return
#' list(template = [character], area_names = [vector of character])
#'
#' template - contains template that can be parsed by htmlTemplate() function
#'
#' area_names - contains all unique area names used in grid definition
#'
#' @examples
#' myGrid <- grid_template(
#'   default = list(
#'     areas = rbind(
#'       c("header", "header", "header"),
#'       c("menu",   "main",   "right1"),
#'       c("menu",   "main",   "right2")
#'     ),
#'     rows_height = c("50px", "auto", "100px"),
#'     cols_width = c("100px", "2fr", "1fr")
#'   ),
#'   mobile = list(
#'     areas = rbind(
#'       "header",
#'       "menu",
#'       "main",
#'       "right1",
#'       "right2"
#'     ),
#'     rows_height = c("50px", "50px", "auto", "150px", "150px"),
#'     cols_width = c("100%")
#'   )
#' )
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
grid_template <- function(default = NULL, mobile = NULL) {

  if (!("areas" %in% names(default))) {
    stop(paste("grid_template() default argument must contain list with `areas` definition.",
               "See documentation for examples."))
  }

  area_names <- default$areas %>% as.vector %>% unique
  area_tags <- shiny::tagList(list_of_area_tags(area_names))

  css_grid_template_areas <- data_frame_to_css_grid_template_areas(default$areas)
  css_default <- shiny::tags$style(paste(
    "#{{ grid_id }} {",
      grid_container_css(css_grid_template_areas, default$rows_height, default$cols_width),
    "}"
  ))

  css_mobile <- NULL
  if (!is.null(mobile)) {

    if (!("areas" %in% names(mobile))) {
      stop(paste("grid_template() mobile argument must contain list with `areas` definition.",
                 "See documentation for examples."))
    }

    css_grid_template_areas <- data_frame_to_css_grid_template_areas(mobile$areas)
    css_mobile <- shiny::tags$style(paste(
      "@media screen and (max-width: 768px) {",
        "#{{ grid_id }} {",
          grid_container_css(css_grid_template_areas, mobile$rows_height, mobile$cols_width),
        "}",
      "}"
    ))
  }

  template <- shiny::tagList(
    css_default,
    css_mobile,
    shiny::tags$div(id = "{{ grid_id }}", area_tags)
  ) %>% htmltools::renderTags()

  return(list(template = template$html, area_names = area_names))
}

#' Use CSS grid template in Shiny UI
#'
#' @param grid_template grid template created with grid_template() function
#' @param id id of grid
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
#' @importFrom stats setNames
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
grid <- function(grid_template, id = paste(sample(letters, 5), collapse = ''),
                 container_style = "", area_styles = list(), display_mode = FALSE, ...) {

  if (display_mode) {
    # For debugging mode just display area name
    template_values <- as.list(setNames(grid_template$area_names, grid_template$area_names))
  } else {
    template_values <- list(...)
  }

  template_values$grid_id <- id
  template_values$custom_style_grid_container <- container_style

  for (name in grid_template$area_names) {
    key <- glue::glue("{name}_custom_css")
    template_values[[key]] <- ifelse(name %in% names(area_styles), area_styles[[name]], "")
  }

  do.call(function(...) htmltools::htmlTemplate(text_ = grid_template$template, ...), template_values)
}

#' Display grid template in a browser for easy debugging
#'
#' @param grid_template generated by grid_template() function
#' @details
#' Opens a browser and displays grid template with styled border to highlight existing areas.
#'
#' Warning: CSS can't be displayed in RStudio viewer pane. CSS grid is supported only by modern browsers.
#' You can see list of supported browsers here: https://www.w3schools.com/css/css_grid.asp
#' @importFrom stats setNames
#' @importFrom grDevices rainbow
#' @export
display_grid <- function(grid_template) {

  # Apply style for debugging
  n <- length(grid_template$area_names)
  styles <- lapply(
    rainbow(n), # Pick rainbow colors and then change opacity to 44
    function(color) glue::glue(
      "border: 1px dotted #888;",
      "font-size: 2em;",
      "padding: 20px;",
      "background: {substr(color, 1, 7)}44"
    )
  ) %>% unlist
  area_styles <- as.list(setNames(styles, grid_template$area_names))

  shiny::runApp(list(
      ui = semanticPage(
        grid(
          grid_template,
          container_style = "border: 1px dashed #000",
          area_styles = area_styles,
          display_mode = TRUE
        )
      ),
      server = function(input, output) {}
    ),
    launch.browser = T
  )

}
