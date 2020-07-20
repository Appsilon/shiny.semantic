#'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
#' Sidebar layout composed of main and sidebar panels
#'
#' vector of number days to be determine column width in grid
numbers <- c("one", "two", "three", "four", "five", "six", "seven", "eight",
             "nine", "ten", "eleven", "twelve", "thirteen", "fourteen",
             "fifteen", "sixteen")
#' create row wrapping specified elements
get_row <- function(arg) {
  class <- "row"
  style <- "padding: 20px;"
  HTML(glue::glue("<div class='{class}' style='{style}'>{arg}</div>"))
}
#' create row wrapping specified elements
get_width <- function(percent) {
  width <- round(percent / 100 * 16, digits = 0)
  width <- min(15, max(1, width))
}
#' Sidebar Panel '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
#'
#' @param ... Elements included in sidebar panel
#' @param width Width of sidebar panel in percents as numeric value
#'
#' @export
sidebarPanel <- function(..., width = 25) {
  args <- list(...)
  style <- "padding: 20px;"
  width <- numbers[get_width(width)]
  div(
    class = glue::glue("{width} wide column center aligned grey"),
    style = style,
    lapply(args, get_row)
  )
}
#' Main Panel ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
#' @param ... Content of main panel
#' @param width Specified with of main panel
#'
#' @export
mainPanel <- function(...) {
  args <- list(...)
  style <- "flex-grow: 1"
  div(
    class = glue::glue("column center aligned"),
    style = style,
    lapply(args, get_row)
  )
}
#' Sidebar Layout ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
#' @param sidebar_panel Sidebar panel component
#' @param main_panel Main panel component
#' @param mirrored If TRUE sidebar is located on the right side,
#' if FALSE - on the left side (default)
#' @param min_height Sidebar layout container keeps the minimum height, if
#' specified. It should be formatted as a string with css units
#'
#' @return Container with sidebar and main panels
#'
#' @examples
#' sidebarLayout(
#'   sidebarPanel("Side Item 1", "Side Item 2", "Side Item 3", width = 20),
#'   mainPanel("Main 1", "Main 2", "Main 3", "Main 4"),
#'   mirrored = FALSE,
#'   min_height = "400px"
#' )
#'
#' @export
sidebarLayout <- function(sidebar_panel,
                          main_panel,
                          mirrored = FALSE,
                          min_height = "auto") {
  class <- "ui celled relaxed grid divided"
  style <- glue::glue("min-height: {min_height};")
  if (mirrored) {
    div(class = class, style = style, main_panel, sidebar_panel)
  } else {
    div(class = class, style = style, sidebar_panel, main_panel)
  }
}
