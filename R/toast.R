#' Create Semantic UI toast
#'
#' This creates a toast using Semantic UI styles.
#'
#' @param ... Content elements to be added to the toast body.
#' To change attributes of the container please check the `content` argument.
#' @param id ID to be added to the toast div. Default "".
#' @param class Classes except "ui toast" to be added to the toast. Semantic UI classes can be used. Default "".
#' @param header Content to be displayed in the toast header.
#' If given in form of a list, HTML attributes for the container can also be changed. Default "".
#' @param content Content to be displayed in the toast body.
#' If given in form of a list, HTML attributes for the container can also be changed. Default NULL.
#' @param footer Content to be displayed in the toast footer. Usually for buttons.
#' If given in form of a list, HTML attributes for the container can also be changed. Default NULL.
#' @param target Javascript selector for the element that will open the toast. Default NULL.
#' @param settings List of vectors of Semantic UI settings to be added to the toast. Default NULL.
#' @param toast_tags Other toast elements. Default NULL.
#'
#' @examples
#' ## Create a simple server toast
#' library(shiny)
#' library(shiny.semantic)
#'
#' ui <- function() {
#'   shinyUI(
#'     semanticPage(
#'       actionButton("show", "Show toast")
#'     )
#'   )
#' }
#'
#' server = function(input, output) {
#'   observeEvent(input$show, {
#'     toast(
#'       "This is an important message!"
#'     )
#'   })
#' }
#'
#' @export
toast <- function(message,
                  title = NULL,
                  action = NULL,
                  duration = 3,
                  id = NULL,
                  type = c("", "info", "success", "error", "warning"),
                  toast_tags = NULL,
                  session = shiny::getDefaultReactiveDomain()) {

  type <- match.arg(type)

  data <- list(
    message = message,
    title = title,
    actions = action,
    class = type,
    displayTime = duration * 1000
  )

  if (!is.null(toast_tags)) {
    data <- append(data, toast_tags)
  }

  if (is.null(id)) id <- generate_random_id("")

  session$sendCustomMessage("createSemanticToast", list(id = id, message = data))
}

#' Close Semantic UI toast
#'
#' This closes a displayed Semantic UI toast.
#'
#' @param id ID of the toast that will be displayed.
#' @param session The \code{session} object passed to function given to
#'   \code{shinyServer}.
#' @seealso toast
#'
#' @export
close_toast <- function(id, session = shiny::getDefaultReactiveDomain()) {
  shiny::removeUI(paste0("#", id))
}

#' @rdname toast
#' @export
showNotification <- function(ui) {

}

#' @rdname toast
#' @export
removeNotification <- function() {

}
