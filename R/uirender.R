#' htmlwidget that adds semanticui dependencies and renders in viewer or rmarkdown.
#'
#' @import htmlwidgets
#'
#' @export
uirender <- function(ui, width = NULL, height = NULL, elementId = NULL) {

  # forward options using x
  args = list(
    ui = toString(ui)
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'uirender',
    args,
    width = width,
    height = height,
    package = 'shiny.semantic',
    elementId = elementId
  )
}
