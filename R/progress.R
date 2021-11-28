#' Create progress Semantic UI component
#'
#' This creates a default progress using Semantic UI styles with Shiny input.
#' Progress is already initialized and available under input[[input_id]].
#'
#' @param input_id Input name. Reactive value is available under input[[input_id]].
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
#'           progress("progress", percent = 24, label = "{percent}% complete"),
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
#' @rdname progress
#' @export
progress <- function(input_id, value = NULL, total = NULL, percent = NULL, progress_lab = FALSE,
                     label = NULL, label_complete = NULL, size = "", class = NULL) {

  if ((!is.null(value) | !is.null(total)) & !is.null(percent)) stop("Can only select value or percent")
  if (isTRUE(value > total)) stop("Value must not exceed total for the progress bar")
  if (!(size %in% SIZE_LEVELS)) {
    warning("Size value not supported.")
    size <- ""
  }

  div(
    id = input_id, class = paste("ui progress ss-progress", size, class),
    `data-value` = value, `data-total` = total, `data-percent` = percent,
    `data-label` = label, `data-label-complete` = label_complete,
    div(class = "bar", if (progress_lab) div(class = "progress")),
    div(class = "label")
  )
}

#' Update progress Semantic UI component
#'
#' Change the value of a \code{\link{progress}} input on the client.
#'
#' @param session The \code{session} object passed to function given to \code{shinyServer}.
#' @param input_id The id of the input object
#' @param type Whether you want to increase the progress bar (\code{"increment"}), decrease the
#' progress bar (\code{"decrement"}), update the label \code{"label"}, or set it to a specific value (\code{"value"})
#' @param value The value to increase/decrease by, or the value to be set to
#'
#' @export
update_progress <- function(session, input_id, type = c("increment", "decrement", "label", "value"), value = 1) {
  type <- match.arg(type)
  message <- list(id = input_id, type = type, value = value)

  session$sendCustomMessage("ssprogress", list(type = "change", message = message))
}

#' Reporting progress (object-oriented API)
#'
#' Reports progress to the user during long-running operations.
#'
#' This package exposes two distinct programming APIs for working with
#' progress. [withProgress()] and [setProgress()]
#' together provide a simple function-based interface, while the
#' `Progress` reference class provides an object-oriented API.
#'
#' Instantiating a `Progress` object causes a progress panel to be
#' created, and it will be displayed the first time the `set`
#' method is called. Calling `close` will cause the progress panel
#' to be removed.
#'
#' As of version 0.14, the progress indicators use Shiny's new notification API.
#' If you want to use the old styling (for example, you may have used customized
#' CSS), you can use `style="old"` each time you call
#' `Progress$new()`. If you don't want to set the style each time
#' `Progress$new` is called, you can instead call
#' [`shinyOptions(progress.style="old")`][shinyOptions] just once, inside the server
#' function.
#'
#' @param message A single-element character vector; the message to be
#'   displayed to the user, or `NULL` to hide the current message (if any).
#'
#' @examples
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#'
#' ui <- semanticPage(
#'   plotOutput("plot")
#' )
#'
#' server <- function(input, output, session) {
#'   output$plot <- renderPlot({
#'     progress <- Progress$new(session, min=1, max=15)
#'     on.exit(progress$close())
#'
#'     progress$set(message = 'Calculation in progress')
#'
#'     for (i in 1:15) {
#'       progress$set(value = i)
#'       Sys.sleep(0.5)
#'     }
#'     plot(cars)
#'   })
#' }
#'
#' shinyApp(ui, server)
#' }
#'
#' @seealso [with_progress()]
#' @format NULL
#' @usage NULL
#' @import R6
#'
#' @rdname Progress-R6
#' @export
Progress <- R6::R6Class(
  "Progress",
  public = list(
    #' @description Creates a new progress panel (but does not display it).
    #' @param session The Shiny session object, as provided by `shinyServer` to
    #'   the server function.
    #' @param min The value that represents the starting point of the progress
    #'   bar. Must be less than `max`.
    #' @param max The value that represents the end of the progress bar. Must be
    #'   greater than `min`.
    #' @param ... Arguments that may have been used for `shiny::Progress`
    initialize = function(session = getDefaultReactiveDomain(), min = 0, max = 1, ...) {
      if (is.null(session$progressStack)) stop("'session' is not a ShinySession object.")
      check_shiny_param("style", "Progress", ...)

      private$session <- session
      private$id <- generate_random_id("", id_length = 8)
      private$min <- min
      private$max <- max
      private$value <- NULL
      private$closed <- FALSE

      data <- list(id = private$id, min = min, max = max)

      session$sendCustomMessage("ssprogress", list(type = "open", message = data))
    },

    #' @description Updates the progress panel. When called the first time, the
    #'   progress panel is displayed.
    #' @param value Single-element numeric vector; the value at which to set the
    #'   progress bar, relative to `min` and `max`. `NULL` hides the progress
    #'   bar, if it is currently visible.
    #' @param ... Arguments that may have been used for `shiny::Progress`
    set = function(value = NULL, message = NULL, ...) {
      if (private$closed) {
        warning("Attempting to set progress, but progress already closed.")
        return()
      }

      check_shiny_param("detail", "Progress", ...)

      if (is.null(value) || is.na(value)) value <- NULL
      if (!is.null(value)) private$value <- value

      data <- list(id = private$id, message = message, value = value)
      data <- data[!vapply(data, is.null, logical(1))]

      private$session$sendCustomMessage("ssprogress", list(type = "update", message = data))
    },

    #' @description Like `set`, this updates the progress panel. The difference
    #'   is that `inc` increases the progress bar by `amount`, instead of
    #'   setting it to a specific value.
    #' @param amount For the `inc()` method, a numeric value to increment the
    #'   progress bar.
    #' @param ... Arguments that may have been used for `shiny::Progress`
    inc = function(amount = 0.1, message = NULL, ...) {
      check_shiny_param("detail", "Progress", ...)

      if (is.null(private$value)) private$value <- private$min

      value <- min(private$value + amount, private$max)
      self$set(value, message)
    },

    #' @description Returns the minimum value.
    getMin = function() private$min,

    #' @description Returns the maximum value.
    getMax = function() private$max,

    #' @description Returns the current value.
    getValue = function() private$value,

    #' @description Removes the progress panel. Future calls to `set` and
    #'   `close` will be ignored.
    close = function() {
      if (private$closed) {
        warning("Attempting to close progress, but progress already closed.")
        return()
      }

      private$session$sendCustomMessage(
        "ssprogress", list(type = "close", message = list(id = private$id))
      )
      private$closed <- TRUE
    }
  ),

  private = list(
    session = "ShinySession",
    id = character(0),
    min = numeric(0),
    max = numeric(0),
    value = numeric(0),
    closed = logical(0)
  )
)

#' Reporting progress (functional API)
#'
#' Reports progress to the user during long-running operations.
#'
#' This package exposes two distinct programming APIs for working with progress.
#' Using `with_progress` with `inc_progress` or `set_progress`
#' provide a simple function-based interface, while the [Progress()]
#' reference class provides an object-oriented API.
#'
#' Use `with_progress` to wrap the scope of your work; doing so will cause a
#' new progress panel to be created, and it will be displayed the first time
#' `inc_progress` or `set_progress` are called. When `with_progress`
#' exits, the corresponding progress panel will be removed.
#'
#' The `inc_progress` function increments the status bar by a specified
#' amount, whereas the `set_progress` function sets it to a specific value,
#' and can also set the text displayed.
#'
#' Generally, `with_progress`/`inc_progress`/`set_progress` should
#' be sufficient; the exception is if the work to be done is asynchronous (this
#' is not common) or otherwise cannot be encapsulated by a single scope. In that
#' case, you can use the `Progress` reference class.
#'
#' When migrating from shiny applications, the functions `withProgress`, `incProgress`
#' and `setProgress` are aliases for `with_progress`, `inc_progress` and `set_progress`.
#'
#' @param session The Shiny session object, as provided by `shinyServer` to
#'   the server function. The default is to automatically find the session by
#'   using the current reactive domain.
#' @param expr The work to be done. This expression should contain calls to
#'   `set_progress`.
#' @param min The value that represents the starting point of the progress bar.
#'   Must be less tham `max`. Default is 0.
#' @param max The value that represents the end of the progress bar. Must be
#'   greater than `min`. Default is 1.
#' @param amount For `inc_progress`, the amount to increment the status bar.
#'   Default is 0.1.
#' @param env The environment in which `expr` should be evaluated.
#' @param quoted Whether `expr` is a quoted expression (this is not
#'   common).
#' @param message A single-element character vector; the message to be displayed
#'   to the user, or `NULL` to hide the current message (if any).
#' @param value Single-element numeric vector; the value at which to set the
#'   progress bar, relative to `min` and `max`.
#' @param ... Arguments that may have been used in `shiny::withProgress`
#'
#' @examples
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#'
#' ui <- semanticPage(
#'   plotOutput("plot")
#' )
#'
#' server <- function(input, output) {
#'   output$plot <- renderPlot({
#'     with_progress(message = 'Calculation in progress',
#'                  detail = 'This may take a while...', value = 0, {
#'       for (i in 1:15) {
#'         inc_progress(1/15)
#'         Sys.sleep(0.25)
#'       }
#'     })
#'     plot(cars)
#'   })
#' }
#'
#' shinyApp(ui, server)
#' }
#'
#' @seealso [Progress()]
#' @rdname with_progress
#' @export
with_progress <- function(expr, min = 0, max = 1,
                          value = min + (max - min) * 0.1, message = NULL,
                          session = getDefaultReactiveDomain(),
                          env = parent.frame(), quoted = FALSE) {
  if (is.null(session$progressStack)) stop("'session' is not a ShinySession object.")

  if (!quoted) expr <- substitute(expr)

  p <- Progress$new(session, min = min, max = max)

  session$progressStack$push(p)
  on.exit({
    session$progressStack$pop()
    p$close()
  })

  p$set(value, message)
  eval(expr, env)
}

#' @rdname with_progress
#' @export
withProgress <- function(expr, min = 0, max = 1,
                         value = min + (max - min) * 0.1, message = NULL,
                         session = getDefaultReactiveDomain(),
                         env = parent.frame(), quoted = FALSE, ...) {
  if (is.null(session$progressStack)) stop("'session' is not a ShinySession object.")

  check_shiny_param("style", "withProgress", ...)
  check_shiny_param("detail", "withProgress", ...)

  if (!quoted) expr <- substitute(expr)

  p <- Progress$new(session, min = min, max = max)

  session$progressStack$push(p)
  on.exit({
    session$progressStack$pop()
    p$close()
  })

  p$set(value, message)
  eval(expr, env)
}

#' @rdname with_progress
#' @export
setProgress <- function(value = NULL, message = NULL, session = getDefaultReactiveDomain(), ...) {
  check_shiny_param("detail", "withProgress", ...)

  set_progress(value, message, session)
}

#' @rdname with_progress
#' @export
set_progress <- function(value = NULL, message = NULL, session = getDefaultReactiveDomain()) {
  if (is.null(session$progressStack)) stop("'session' is not a ShinySession object.")

  if (session$progressStack$size() == 0) {
    warning("set_progress was called outside of with_progress; ignoring")
    return()
  }

  session$progressStack$peek()$set(value, message)
  invisible()
}

#' @rdname with_progress
#' @export
incProgress <- function(amount = 0.1, message = NULL, session = getDefaultReactiveDomain(), ...) {
  check_shiny_param("detail", "withProgress", ...)

  inc_progress(amount, message, session)
}

#' @rdname with_progress
#' @export
inc_progress <- function(amount = 0.1, message = NULL, session = getDefaultReactiveDomain(), ...) {
  if (is.null(session$progressStack)) stop("'session' is not a ShinySession object.")

  if (session$progressStack$size() == 0) {
    warning("inc_progress was called outside of with_progress; ignoring")
    return()
  }

  p <- session$progressStack$peek()
  p$inc(amount, message)
  invisible()
}
