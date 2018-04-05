#' Parse the `shiny_input` value from JSON
#'
#' @param val value to get from JSON
#'
#' @return Value of type defined in `shiny_input`
#' @export
parse_val <- function(val) {
  jsonlite::fromJSON(ifelse(is.null(val), '""', val))
}
