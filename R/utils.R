#' Parse the `shiny_input` value from JSON
#'
#' @param val
#'
#' @return Value of type defined in `shiny_input`
#' @export
parse_val <- function(val) {
  jsonlite::fromJSON(ifelse(is.null(val), '""', val))
}
