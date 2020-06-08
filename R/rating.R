fomantic_size_levels <- c("mini", "tiny", "small", "", "large", "huge", "massive")

#' @export
rating <- function(inputId, label, value = 0, max = 3, icon = "star", color = "yellow", size = 4) {

  class <- glue::glue("ui {fomantic_size_levels[size]} {color} rating")
  shiny::div(
    class = "ui form",
    shiny::div(class = "field",
      if (!is.null(label)) tags$label(label, `for` = inputId),
      shiny::div(id = inputId, class = class, `data-icon` = icon, `data-rating` = value, `data-max-rating` = max)
    )
  )
}

#' @export
updateRating <- function(session, inputId, label = NULL, value = NULL) {
  message <- list(label = label, value = value)
  message <- message[!vapply(message, is.null, FUN.VALUE = logical(1))]

  session$sendInputMessage(inputId, message)
}
