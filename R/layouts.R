# Layouts

#' Creates row wrapping specified elements
#' @param arg Element to be wrapped in row container
#' @return character with row wrapping specified elements
get_row <- function(arg) {
  class <- "row"
  style <- "padding: 20px;"
  shiny::HTML(glue::glue("<div class='{class}' style='{style}'>{arg}</div>"))
}

#' Returns percentage value of width based on 12-units grid
#' @param width value to be converted to percentage value
#' @return percentage value of width based on 12-units grid
get_percent <- function(width) {
  width <- min(11, max(1, width))
  percent <- round(width / 12 * 100, digits = 0)
}

#' Creates div containing children elements in separate rows
#'
#' @param ... Container's children elements
#' @return Div containing children elements in separate rows
panel <- function(...) {
  args <- list(...)
  div(lapply(args, get_row))
}

#' Creates div containing children elements of sidebar panel
#'
#' @param ... Container's children elements
#' @param width Width of sidebar panel container
#' @rdname sidebar_layout
#' @export
sidebar_panel <- function(..., width = 4) {
  list(panel = panel(...), width = width)
}

#' Creates div containing children elements of main panel
#'
#' @param ... Container's children elements
#' @param width Width of main panel container
#' @rdname sidebar_layout
#' @export
main_panel <- function(..., width = 8) {
  list(panel = panel(...), width = width)
}

#' Creates grid layout composed of sidebar and main panels
#'
#' @param sidebar_panel Sidebar panel component
#' @param main_panel Main panel component
#' @param mirrored If TRUE sidebar is located on the right side,
#' if FALSE - on the left side (default)
#' @param min_height Sidebar layout container keeps the minimum height, if
#' specified. It should be formatted as a string with css units
#' @param container_style CSS declarations for grid container
#' @param area_styles List of CSS declarations for each grid area inside
#' container
#'
#' @return Container with sidebar and main panels
#' @examples
#' if (interactive()){
#'   library(shiny)
#'   library(shiny.semantic)
#'   ui <- semanticPage(
#'     titlePanel("Hello Shiny!"),
#'     sidebar_layout(
#'       sidebar_panel(
#'         shiny.semantic::sliderInput("obs",
#'                                     "Number of observations:",
#'                                     min = 0,
#'                                     max = 1000,
#'                                     value = 500)
#'       ),
#'       main_panel(
#'         plotOutput("distPlot")
#'       )
#'     )
#'   )
#'   server <- function(input, output) {
#'     output$distPlot <- renderPlot({
#'       hist(rnorm(input$obs))
#'     })
#'   }
#' }
#' @rdname sidebar_layout
#' @export
sidebar_layout <- function(sidebar_panel,
                           main_panel,
                           mirrored = FALSE,
                           min_height = "auto",
                           container_style = "",
                           area_styles = list(
                             sidebar_panel = "",
                             main_panel = "")) {

  sidebar_width = sidebar_panel$width
  main_width = main_panel$width
  sidebar_panel = sidebar_panel$panel
  main_panel = main_panel$panel
  sidebar_width = get_percent(sidebar_width)
  main_width = get_percent(main_width)

  # set normal or mirrored sidebar layout
  if (!mirrored) {
    layout <- grid_template(default = list(
      areas = rbind(c("sidebar_panel", "main_panel")),
      cols_width = c(glue::glue("{sidebar_width}% {main_width}%"))
    ))
  } else {
    layout <- grid_template(default = list(
      areas = rbind(c("main_panel", "sidebar_panel")),
      cols_width = c(glue::glue("{main_width}% {sidebar_width}%"))
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

#' @rdname sidebar_layout
sidebarPanel <- function(..., width = 4) {
  sidebar_panel(..., width = width)
}

#' @rdname sidebar_layout
mainPanel <- function(..., width = 8) {
  main_panel(..., width = width)
}

#' @rdname sidebar_layout
sidebarLayout <- function(sidebarPanel,
                          mainPanel,
                          position = c("left", "right"),
                          fluid = TRUE) {
  if (position == "left") mirrored <- FALSE else mirrored <- TRUE
  sidebar_layout (
    sidebar_panel,
    main_panel,
    mirrored = mirrored
  )
}
