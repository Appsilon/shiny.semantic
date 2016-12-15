#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
uirender <- function(ui, width = NULL, height = NULL, elementId = NULL) {

  # forward options using x
  x = list(
    ui = toString(ui)
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'uirender',
    x,
    width = width,
    height = height,
    package = 'shiny.semantic',
    elementId = elementId
  )
}

#' Shiny bindings for uirender
#'
#' Output and render functions for using uirender within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a uirender
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name uirender-shiny
#'
#' @export
uirenderOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'uirender', width, height, package = 'shiny.semantic')
}

#' @rdname uirender-shiny
#' @export
renderUirender <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, uirenderOutput, env, quoted = TRUE)
}
