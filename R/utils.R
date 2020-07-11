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
  if (!(color %in% c("", names(semantic_palette)))) {
    stop("Wrong color parameter specified!")
  } else {
    invisible(color)
  }
}

#' Generates random id of element
#'
#' @param prefix character with prefix add to id
#' @param id_length numeric with length of id (default 20)
generate_random_id <- function(prefix, id_length = 20) {
  random_id <- paste(sample(letters, id_length, replace = TRUE), collapse = "")
  paste0(prefix, "-", random_id)
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
