#' Rating Input.
#'
#' Crates rating component
#'
#' @param input_id The \code{input} slot that will be used to access the value.
#' @param label the contents of the item to display
#' @param value initial rating value
#' @param max maximum value
#' @param icon character with name of the icon or \code{\link{icon}()} that is
#' an element of the rating
#' @param color character with colour name
#' @param size character with legal semantic size, eg. "medium", "huge", "tiny"
#'
#' @return rating object
#' @examples
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#'   library(shiny)
#'   library(shiny.semantic)
#'
#'   ui <- shinyUI(
#'     semanticPage(
#'       rating_input("rate", "How do you like it?", max = 5,
#'                    icon = "heart", color = "yellow"),
#'     )
#'   )
#'   server <- function(input, output) {
#'     observeEvent(input$rate,{print(input$rate)})
#'   }
#'   shinyApp(ui = ui, server = server)
#' }
#' @export
rating_input <- function(input_id, label = "", value = 0, max = 3, icon = "star",
                   color = "yellow", size = "") {
  if (!(size %in% SIZE_LEVELS)) {
    warning("Size value not supported.")
    size <- ""
  }
  if (inherits(icon, "shiny.tag")) {
    icon <- extract_icon_name(icon)
  }
  class <- glue::glue("ui {size} {color} rating")
  shiny::div(
    class = "ui form",
    shiny::div(class = "field",
      if (!is.null(label)) tags$label(label, `for` = input_id),
      shiny::div(
        id = input_id, class = class, `data-icon` = icon,
        `data-rating` = value, `data-max-rating` = max
      )
    )
  )
}

#' Update rating
#'
#' Change the value of a rating input on the client. Check
#' \code{rating_input} to learn more.
#'
#' @param session shiny object with session info
#'
#' @param input_id rating input name
#' @param label character with updated label
#' @param value new rating value
#' @examples
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#' library(shiny)
#' library(shiny.semantic)
#'
#' ui <- shinyUI(
#'   semanticPage(
#'     rating_input("rate", "How do you like it?", max = 5,
#'                  icon = "heart", color = "yellow"),
#'     numeric_input("numeric_in", "", 0, min = 0, max = 5)
#'   )
#' )
#' server <- function(session, input, output) {
#'   observeEvent(input$numeric_in, {
#'     x <- input$numeric_in
#'     update_rating_input(session, "rate", value = x)
#'   }
#'   )
#' }
#' shinyApp(ui = ui, server = server)
#' }
#'
#' @export
#' @rdname update_rating
update_rating_input <- function(session, input_id, label = NULL, value = NULL) {
  message <- list(label = label, value = value)
  message <- message[!vapply(message, is.null, FUN.VALUE = logical(1))]
  session$sendInputMessage(input_id, message)
}
