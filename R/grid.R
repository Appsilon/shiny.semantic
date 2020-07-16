# TODO:
# 1. roxygen
# 2. unittests
# 3. Add in the documentation what browsers support CSS Grid functionality
#    Warning: CSS can't be displayed in RStudio viewer pane (RStudio 1.1.453)

.data_frame_to_css_grid_template_areas <- function(areas_dataframe) {
  apply(areas_dataframe, 1, function(row) paste(row, collapse = ' ')) %>% 
    lapply(., function(row) glue::glue("'{row}'")) %>% 
    paste(., collapse = ' ')
}

.grid_container_css <- function(css_grid_template_areas, rows_height, cols_width) {
  grid_container_styles <- c(
    "display: grid",
    "height: 100%",
    glue::glue("grid-template-rows: {paste(rows_height, collapse = ' ')}"),
    glue::glue("grid-template-columns: {paste(cols_width, collapse = ' ')}"),
    glue::glue("grid-template-areas: {css_grid_template_areas}"),
    "{custom_style_grid_container}" # To be rendered by glue::glue() later
  )
  paste(grid_container_styles, collapse = "; ")
}

.list_of_area_tags <- function(area_names) {
  lapply(area_names, 
    function(name) shiny::tags$div(
     style = glue::glue("grid-area: {name}; {{custom_style_grid_area_{name}}}"), paste("{{", name, "}}")
    )
  )
}


grid_template <- function(
  default = list(areas = "", rows_height = c(), cols_width = c()), 
  mobile = list(areas = "", rows_height = c(), cols_width = c())) {
  # TODO: Support for mobile grid version. Only `default` argument is used right now.
  
  area_names <- default$areas %>% as.vector %>% unique
  css_grid_template_areas <- .data_frame_to_css_grid_template_areas(default$areas)

  grid_template <- shiny::tags$div(
    style = .grid_container_css(css_grid_template_areas, default$rows_height, default$cols_width),
    shiny::tagList(.list_of_area_tags(area_names))
  ) %>% htmltools::renderTags(.)

  return(list(template = grid_template$html, area_names = area_names))
}

.apply_custom_styles_to_html_template <- function(html_template = "", area_names = c(), container_style = "", area_styles = list()) {
  custom_styles <- list(custom_style_grid_container = container_style)
  for (area in area_names) {
    custom_styles[[glue::glue("custom_style_grid_area_{area}")]] <- ifelse(area %in% names(area_styles), area_styles[[area]], "")
  }
  styled_template <- do.call(function(...) glue::glue(html_template, ...), custom_styles)
  return(styled_template)
}

.prepare_mustache_for_html_template <- function(styled_html_template = "", area_names = c(), display_mode = FALSE) {
  mustache <- sapply(area_names, function(area) ifelse(display_mode, paste("<", area, ">"), paste("{{", area, "}}")))
  areas_mustache <- as.list(setNames(mustache, area_names))
  html_template <- do.call(function(...) glue::glue(styled_html_template, ...), areas_mustache)
  return(html_template)
}

# It's better to explicitly call function named "grid" in Shiny UI for the clarity in the code
grid <- function(grid_template, container_style = "", area_styles = list(), display_mode = FALSE, ...) {
  
  # Replace {custom_style_grid_container} and {custom_style_grid_area_{name}} with custom CSS
  styled_html_template <- .apply_custom_styles_to_html_template(
    grid_template$template, grid_template$area_names, container_style, area_styles)
  
  # Replace {areas} for glue::glue with {{areas}} for rendering htmlTemplate
  mustached_html_template <- .prepare_mustache_for_html_template(styled_html_template, grid_template$area_names, display_mode)
  
  htmltools::htmlTemplate(text_ = mustached_html_template, ...)
}

display_grid <- function(grid_template) {
  temporary_html_file <- glue::glue("grid_render_{as.numeric(Sys.time())}.html")
  
  # Apply dotted border to show all grid areas. 
  # List looks like this: area_styles == list(area_1 = "border: 1px dotted #444", area_2 = ...)
  area_styles <- as.list(setNames(
    rep("border: 1px dotted #444", length(grid_template$area_names)),
    grid_template$area_names))
  
  html <- grid(grid_template, container_style = "border: 1px dashed #000", area_styles = area_styles, display_mode = TRUE)
  
  base::write(unlist(html), temporary_html_file)
  utils::browseURL(temporary_html_file)
  Sys.sleep(1) # Let's wait for browser to load the file until we delete it
  invisible(file.remove(temporary_html_file))
}

### EXAMPLES

# myGrid <- grid_template(default = list(
#   areas = rbind(
#     c("header", "header", "header"),
#     c("menu",   "main",   "right1"),
#     c("menu",   "main",   "right2")
#   ),
#   rows_height = c("50px", "auto", "100px"), 
#   cols_width = c("100px", "2fr", "1fr")
# ))
# 
# display_grid(myGrid)
# 
# subGrid <- grid_template(default = list(
#   areas = rbind(
#     c("top_left", "top_right"),
#     c("bottom_left", "bottom_right")
#   ),
#   rows_height = c("50%", "50%"), 
#   cols_width = c("50%", "50%")
# ))
# 
# display_grid(subGrid)
