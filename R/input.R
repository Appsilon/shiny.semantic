#' Create Semantic UI Input
#'
#' This creates an input shell for the actual input
#'
#' @param ... Other arguments to be added as attributes of the tag (e.g. style, class or childrens etc.)
#' @param class Additional classes to add to html tag.
#'
#' @examples
#' library(shiny)
#' library(shiny.semantic)
#'
#' # Text input
#' uiinput(
#'   tags$label("Text input"),
#'   uitextinput("ex", type = "text", placeholder = "Enter Text")
#' )
#'
#' @seealso uitextinput
#'
#' @export
uiinput <- function(..., class = "") {
  div(class = paste("ui", class, "input"), ...)
}

#' Create Semantic UI Text Input
#'
#' This creates a default text input using Semantic UI. The input is available
#' under \code{input[[name]]}.
#'
#' @param name Input name. Reactive value is available under \code{input[[name]]}.
#' @param value Pass value if you want to have default text.
#' @param type Change depending what type of input is wanted. See details for options.
#' @param placeholder Text visible in the input when nothing is inputted.
#' @param attribs A named list of attributes to assign to the input.
#'
#' @details
#' The following \code{type}s are allowed:
#' \itemize{
#' \item{text}{The standard input}
#' \item{textarea}{An extended space for text}
#' \item{password}{A censored version of the text input}
#' \item{email}{A special version of the text input specific for email addresses}
#' \item{url}{A special version of the text input specific for URLs}
#' \item{tel}{A special version of the text input specific for telephone numbers}
#' }
#'
#' The inputs are updateable by using \code{\link[shiny]{updateTextInput}} or
#' \code{\link[shiny]{updateTextAreaInput}} if \code{type = "textarea"}.
#'
#' @examples
#' library(shiny)
#' library(shiny.semantic)
#'
#' # Text input
#' uiinput(
#'   tags$label("Text input"),
#'   uitextinput("ex", type = "text", placeholder = "Enter Text")
#' )
#'
#' @export
uitextinput <- function(name, value = "", type = "text", placeholder = NULL, attribs = list()) {
  if (!type %in% c("text", "textarea", "password", "email", "url", "tel")) {
    stop(type, " is not a valid Semantic UI input")
  }

  if (type == "textarea") {
    input <- tags$textarea(id = name, value = value, placeholder = placeholder)
  } else {
    input <- tags$input(id = name, value = value, type = type, placeholder = placeholder)
  }

  for (i in names(attribs)) input$attribs[[i]] <- attribs[[i]]
  input
}

#' Create Semantic UI Numeric Input
#'
#' This creates a default numeric input using Semantic UI. The input is available
#' under \code{input[[name]]}.
#'
#' @param name Input name. Reactive value is available under \code{input[[name]]}.
#' @param value Initial value of the numeric input.
#' @param min Minimum allowed value.
#' @param max Maximum allowed value.
#' @param step Interval to use when stepping between min and max.
#'
#' @details
#' The inputs are updateable by using \code{\link[shiny]{updateNumericInput}}.
#'
#' @examples
#' library(shiny)
#' library(shiny.semantic)
#'
#' # Text input
#' uiinput(
#'   tags$label("Numeric Input"),
#'   uinumericinput("ex", 10)
#' )
#'
#' @export
uinumericinput <- function(name, value, min = NA, max = NA, step = NA) {
  if (!is.numeric(value) & !grepl("^\\d*(\\.\\d*|)$", value)) stop("Non-numeric input detected")

  input <- tags$input(id = name, value = value, type = "number")
  if (!is.na(min)) input$attibs$min <- min
  if (!is.na(max)) input$attibs$max <- max
  if (!is.na(step)) input$attibs$step <- step
  input
}
