#' Generates warning message.
#'
#' @param fct Name of the shiny function used.
page_display_warning <- function(fct) {
  glue::glue("shiny.semantic is loaded but {fct} is used. This will cause display issues.
             Please unload shiny.semantic or use semanticPage() instead.")
}

#' Generates warning message if basicPage is used.
basicPage <- function(...) {
  warning(page_display_warning("basicPage"))
  shiny::basicPage(...)
}

#' Generates warning message if bootstrapPage is used.
bootstrapPage <- function(...) {
  warning(page_display_warning("bootstrapPage"))
  shiny::bootstrapPage(...)
}

#' Generates warning message if fillPage is used.
fillPage <- function(...) {
  warning(page_display_warning("fillPage"))
  shiny::fillPage(...)
}

#' Generates warning message if fixedPage is used.
fixedPage <- function(...) {
  warning(page_display_warning("fixedPage"))
  shiny::fixedPage(...)
}

#' Generates warning message if navbarPage is used.
navbarPage <- function(...) {
  warning(page_display_warning("navbarPage"))
  shiny::navbarPage(...)
}

#' Generates warning message if fluidPage is used.
fluidPage <- function(...) {
  warning(page_display_warning("fluidPage"))
  shiny::fluidPage(...)
}
