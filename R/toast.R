#' Show and remove Semantic UI toast
#'
#' These functions either create or remove a toast notifications with Semantic UI styling.
#'
#' @param message Content of the message.
#' @param title A title given to the toast. Defauly is empty (`""`).
#' @param action A list of lists containing settings for buttons/options to select within the
#' @param duration Length in seconds for the toast to appear, default is 3 seconds. To make it not automatically close,
#' set to 0.
#' @param id A unique identifier for the notification. It is optional for `toast`, but required
#' for `close_toast`.
#' @param class Classes except "ui toast" to be added to the toast. Semantic UI classes can be used. Default "".
#' @param toast_tags Other toast elements. Default NULL.
#' @param session Session object to send notification to.
#'
#' @example inst/examples/toast.R
#'
#' @seealso <https://fomantic-ui.com/modules/toast>
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
#' @export
close_toast <- function(id, session = shiny::getDefaultReactiveDomain()) {
  session$sendCustomMessage("closeSemanticToast", list(id = id))
}

#' @param ui Content of the toast.
#' @param closeButton Logical, should a close icon appear on the toast?
#' @param type Type of toast
#' @param ... Arguments that can be passed to `toast`
#'
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
