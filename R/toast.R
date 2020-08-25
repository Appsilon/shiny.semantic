#' Show and remove Semantic UI toast
#'
#' These functions either create or remove a toast with Semantic UI styling.
#'
#' @param message Content of the message.
#' @param title A title given to the toast. Defauly is empty (\code{""}).
#' @param id A unique identifier for the notification. It is optional for \code{toast}, but required
#' for \code{close_toast}.
#' @param action A list of lists containing settings for buttons/options to select within the toast.
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
#' @param session Session object to send notification to.
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
#' if (interactive()) shinyApp(ui, server)
#'
#' ## Create a toast with options
#' ui <- semanticPage(
#'   actionButton("show", "Show"),
#' )
#' server <- function(input, output) {
#'   observeEvent(input$show, {
#'     toast(
#'       title  = "Question",
#'       "Do you want to see more?",
#'       duration = 0,
#'       action = list(
#'         list(
#'           text = "OK", class = "green", icon = "check",
#'           click = "(function() { $('body').toast({message:'Yes clicked'}); })")
#'         ),
#'         list(
#'           text = "No", class = "red", icon = "times",
#'           click = ("(function() { $('body').toast({message:'No ticked'}); })")
#'         )
#'       )
#'     )
#'   })
#' }
#'
#' if (interactive()) shinyApp(ui, server)
#'
#' ## Closing a toast
#' ui <- semanticPage(
#'   action_button("show", "Show"),
#'   action_button("remove", "Remove")
#' )
#' server <- function(input, output) {
#'   # A queue of notification IDs
#'   ids <- character(0)
#'   # A counter
#'   n <- 0
#'
#'   observeEvent(input$show, {
#'     # Save the ID for removal later
#'     id <- toast(paste("Message", n), duration = NULL)
#'     ids <<- c(ids, id)
#'     n <<- n + 1
#'   })
#'
#'   observeEvent(input$remove, {
#'     if (length(ids) > 0)
#'       close_toast(ids[1])
#'     ids <<- ids[-1]
#'   })
#' }
#'
#' if (interactive()) shinyApp(ui, server)
#'
#' @seealso \url{https://fomantic-ui.com/modules/toast}
#'
#' @export
toast <- function(message,
                  title = NULL,
                  action = NULL,
                  duration = 3,
                  id = NULL,
                  class = "",
                  toast_tags = NULL,
                  session = shiny::getDefaultReactiveDomain()) {

  data <- list(
    message = message,
    title = title,
    actions = action,
    class = class,
    displayTime = duration * 1000
  )

  if (!is.null(toast_tags)) {
    if (any(names(toast_tags) %in% names(data))) {
      stop("Duplicate tags detected. Please avoid using `message`, `title`, `actions`, `class` and `displayTime`")
    }
    data <- append(data, toast_tags)
  }

  if (is.null(id)) id <- generate_random_id("")

  data <- data[!vapply(data, is.null, logical(1))]
  session$sendCustomMessage("createSemanticToast", list(id = id, message = data))
  id
}

#' @rdname toast
close_toast <- function(id, session = shiny::getDefaultReactiveDomain()) {
  session$sendCustomMessage("closeSemanticToast", list(id = id))
}

#' @param ui Content of the message.
#' @rdname toast
#' @export
showNotification <- function(ui, action = NULL, duration = 5, closeButton = TRUE,
                             id = NULL, type = c("default", "message", "warning", "error"),
                             session = getDefaultReactiveDomain(),
                             ...) {

  type <- match.arg(type)
  type <- switch(type, default = "", message = "info", type)

  if (is.null(id)) id <- generate_random_id("")

  if (!is.null(action)) {
    if (inherits(action, "shiny.tag")) {
      message("shiny.semantic toasts cannot handle HTML actions. The action will be removed from this toast")
      action <- NULL
    }
  }

  toast_tags <- list(...)
  if ("title" %in% names(toast_tags)) {
    title <- toast_tags$title
    toast_tags$title <- NULL
  } else {
    title <- NULL
  }

  toast_tags$closeIcon <- closeButton

  toast(
    message = as.character(ui),
    title = title, action = action, duration = duration, id = id, class = type,
    toast_tags = toast_tags, session = session
  )
  id
}

#' @rdname toast
#' @export
removeNotification <- function(id, session = shiny::getDefaultReactiveDomain()) {
  close_toast(id, session)
}
