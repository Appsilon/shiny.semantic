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
#' @examples
#' check_proper_color("blue")
check_proper_color <- function(color) {
  if (!(color %in% c("", names(COLOR_PALETTE)))) {
    stop("Wrong color parameter specified!")
  } else {
    invisible(color)
  }
}

#' ::: hack solution to pass CRAN checks
#'
#' @param pkg package name
#' @param name function name
#'
#' @return function
`%:::%` <- function(pkg, name) { # nolint
  pkg <- as.character(substitute(pkg))
  name <- as.character(substitute(name))
  get(name, envir = asNamespace(pkg), inherits = FALSE)
}

#' Check for extra arguments
#'
#' This throws warning if there're parameters not supported by semantic.
#'
#' @param args list with extra arguments
check_extra_arguments <- function(args) {
  to_wrn <- paste0(as.character(names(args)), collapse = ',')
if (nchar(to_wrn) > 1)
  warning(glue::glue("arguments: `{to_wrn}` not supported yet in semantic version"))
}
