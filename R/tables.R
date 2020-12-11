#' Create Semantic DT Table
#'
#' This creates DT table styled with Semantic UI.
#'
#' @param ... datatable parameters, check `?DT::datatable` to learn more.
#' @param options datatable options, check `?DT::datatable` to learn more.
#'
#' @example inst/examples/semantic_dt.R
#'
#' @export
semantic_DT <- function(..., options = list()) {
  DT::datatable(..., options = options,
                class = 'ui small compact table',
                style = "semanticui",
                rownames = FALSE)
}

#' Semantic DT Output
#'
#' @param ... datatable parameters, check `?DT::datatable` to learn more.
#'
#' @return DT Output with semanitc style
#' @export
semantic_DTOutput <- function(...) {
    DT::DTOutput(...)
}
