#' Create progress Semantic UI component
#'
#' This creates a default progress using Semantic UI styles with Shiny input.
#' Progress is already initialized and available under input[[name]].
#'
#' @param name Input name. Reactive value is available under input[[name]].
#' @param value The initial value to be selected for the progress bar.
#' @param total The maximum value that will be applied to the progress bar.
#' @param percent The initial percentage to be selected for the progress bar.
#' @param progress_lab Logical, would you like the percentage visible in the progress bar?
#' @param label The label to be visible underneath the progress bar.
#' @param label_complete The label to be visible underneath the progress bar when the bar is at 100\%.
#' @param size character with legal semantic size, eg. "medium", "huge", "tiny"
#' @param class UI class of the progress bar.
#'
#' @details
#' To initialize the progress bar, you can either choose \code{value} and \code{total}, or \code{percent}.
#'
#' @examples
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#'
#'   library(shiny)
#'   library(shiny.semantic)
#'   ui <- function() {
#'       shinyUI(
#'         semanticPage(
#'           title = "Progress example",
#'           uiprogress("progress", percent = 24, label = "{percent}% complete"),
#'           p("Progress completion:"),
#'           textOutput("progress")
#'        )
#'      )
#'   }
#'   server <- shinyServer(function(input, output) {
#'      output$progress <- renderText(input$progress)
#'   })
#'
#'   shinyApp(ui = ui(), server = server)
#' }
#'
#' @export
uiprogress <- function(name, value = NULL, total = NULL, percent = NULL, progress_lab = FALSE,
                       label = NULL, label_complete = NULL, size = "", class = NULL) {

  if ((!is.null(value) | !is.null(total)) & !is.null(percent)) stop("Can only select value or percent")
  if (isTRUE(value > total)) stop("Value must not exceed total for the progress bar")
  if (!(size %in% FOMANTIC_SIZE_LEVELS)) {
    warning("Size value not supported.")
    size <- ""
  }

  div(
    id = name, class = paste("ui progress ss-progress", size, class),
    `data-value` = value, `data-total` = total, `data-percent` = percent,
    `data-label` = label, `data-label-complete` = label_complete,
    div(class = "bar", if (progress_lab) div(class = "progress")),
    div(class = "label")
  )
}

#' Update progress Semantic UI component
#'
#' Change the value of a \code{\link{uiprogress}} input on the client.
#'
#' @param session The \code{session} object passed to function given to \code{shinyServer}.
#' @param name The id of the input object
#' @param type Whether you want to increase the progress bar (\code{"increment"}), decrease the
#' progress bar (\code{"decrement"}), update the label \code{"label"}, or set it to a specific value (\code{"value"})
#' @param value The value to increase/decrease by, or the value to be set to
#'
#' @seealso uiprogress
#'
#' @export
update_progress <- function(session, name, type = c("increment", "decrement", "label", "value"), value = 1) {
  type <- match.arg(type)
  message <- structure(list(value), names = type)

  session$sendInputMessage(name, message)
}
