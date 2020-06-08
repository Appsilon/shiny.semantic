#' allowed sizes
FOMANTIC_SIZE_LEVELS <- c("mini", "tiny", "small", "", "large", "huge", "massive")

#' Rating
#'
#' Crates rating component
#'
#' @param name The \code{input} slot that will be used to access the value.
#' @param label the contents of the item to display
#' @param value initial rating value
#' @param max maximum value
#' @param icon An optional \code{\link{uiicon}()} to appear on the button.
#' @param color character with colour name
#' @param size character with legal semantic size, eg. "medium", "huge", "tiny"
#'
#' @return rating object
#'
#' @export
rating <- function(name, label = "", value = 0, max = 3, icon = "star",
                   color = "yellow", size = "") {
  if (!(size %in% FOMANTIC_SIZE_LEVELS)) {
    warning("Size value not supported.")
    size <- ""
  }
  class <- glue::glue("ui {size} {color} rating")
  shiny::div(
    class = "ui form",
    shiny::div(class = "field",
      if (!is.null(label)) tags$label(label, `for` = name),
      shiny::div(id = name, class = class, `data-icon` = icon,
                 `data-rating` = value, `data-max-rating` = max)
    )
  )
}

#' Update rating
#'
#' check \code{rating} to learn more.
#'
#' @param session shiny object with session info
#'
#' @param name rating input name
#' @param label character with updated label
#' @param value new rating value
#'
#' @export
updateRating <- function(session, name, label = NULL, value = NULL) {
  message <- list(label = label, value = value)
  message <- message[!vapply(message, is.null, FUN.VALUE = logical(1))]
  session$sendInputMessage(name, message)
}
