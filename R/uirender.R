#' Render semanticui htmlwidget
#'
#' htmlwidget that adds semanticui dependencies and
#' renders in viewer or rmarkdown.
#'
#' @import htmlwidgets
#'
#' @param ui UI, which will be wraped in an htmlwidget.
#' @param width Fixed width for widget (in css units). The default is NULL,
#' which results in intelligent automatic sizing.
#' @param height Fixed height for widget (in css units). The default is NULL,
#' which results in intelligent automatic sizing.
#' @param element_id Use an explicit element ID for the widget
#' (rather than an automatically generated one).
#'
#' @export
uirender <- function(ui, width = NULL, height = NULL, element_id = NULL) {

  # forward options using x
  args <- list(
    ui = toString(ui)
  )

  # create widget
  htmlwidgets::createWidget(
    name = "uirender",
    args,
    width = width,
    height = height,
    package = "shiny.semantic",
    elementId = element_id
  )
}
