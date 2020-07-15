#' allowed sizes
FOMANTIC_SIZE_LEVELS <- c("mini", "tiny", "small", "", "large", "huge", "massive")

#' Extract icon name
#'
#' @param icon uiicon object
#'
#' @return character with icon name
extract_icon_name <- function(icon) {
  gsub(" icon", "", icon$attribs$class)
}

#' Rating Input.
#'
#' Crates rating component
#'
#' @param name The \code{input} slot that will be used to access the value.
#' @param label the contents of the item to display
#' @param value initial rating value
#' @param max maximum value
#' @param icon character with name of the icon or \code{\link{uiicon}()} that is
#' an element of the rating
#' @param color character with colour name
#' @param size character with legal semantic size, eg. "medium", "huge", "tiny"
#'
#' @return rating object
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shiny.semantic)
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
rating_input <- function(name, label = "", value = 0, max = 3, icon = "star",
                   color = "yellow", size = "") {
  if (!(size %in% FOMANTIC_SIZE_LEVELS)) {
    warning("Size value not supported.")
    size <- ""
  }
  if (class(icon) == "shiny.tag") {
    icon <- extract_icon_name(icon)
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
#' check \code{rating_input} to learn more.
#'
#' @param session shiny object with session info
#'
#' @param name rating input name
#' @param label character with updated label
#' @param value new rating value
#'
#' @export
update_rating_input <- function(session, name, label = NULL, value = NULL) {
  message <- list(label = label, value = value)
  message <- message[!vapply(message, is.null, FUN.VALUE = logical(1))]
  session$sendInputMessage(name, message)
}
