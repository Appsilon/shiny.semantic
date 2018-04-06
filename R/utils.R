#' Parse the `shiny_input` value from JSON
#'
#' @param val value to get from JSON
#'
#' @return Value of type defined in `shiny_input`
#' @export
parse_val <- function(val) {
  jsonlite::fromJSON(ifelse(is.null(val), '""', val))
}

#' Check if color is set from Semanti-UI palette
#'
#' @param color character with color name
#'
#' @return Error when \code{color} does not belong to palette
#' @export
check_proper_color <- function(color) {
  if (!(color %in% c("", names(semantic_palette)))) {
    stop("Wrong color parameter specified!")
  } else {
    invisible(color)
  }
}
