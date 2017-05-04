#' Internal function that expose javascript bindings to Shiny app.
.onLoad <- function(libname, pkgname) {
  # Add directory for static resources
  shiny::addResourcePath('shiny.semantic', system.file('www', package = 'shiny.semantic', mustWork = TRUE))
}

#' Create universal Shiny input binding
#'
#' Universal binding for Shiny input on custom user interface. Using this function one can create various inputs
#' ranging from text, numerical, date, dropdowns, etc. Value of this input is extracted via jQuery using $().val()
#' function and default exposed as serialized JSON to the Shiny server. If you want to change type of exposed input
#' value specify it via type param. Currently list of supported types is "JSON" (default) and "text".
#'
#' @param input_id String with name of this input. Access to this input within server code is normal with input[[input_id]].
#' @param shiny_ui UI of HTML component presenting this input to the users. This UI should allow to extract its value with jQuery $().val() function.
#' @param value An optional argument with value that should be set for this input. Can be used to store persisten input valus in dynamic UIs.
#' @param type Type of input value (could be "JSON" or "text").
#'
#' @export
shiny_input <- function(input_id, shiny_ui, value = NULL, type = "JSON") {
  selected <- shiny::restoreInput(id = input_id, default = value)
  valid_types <- c("JSON", "text")

  if (!(type %in% valid_types)) {
    stop(type, " is not valid type for universal shiny input")
  }

  custom_input_class <- 'shiny-custom-input'
  shiny_ui$attribs$class <- paste(custom_input_class, ifelse(is.null(shiny_ui$attribs$class), "", shiny_ui$attribs$class))
  shiny_ui$attribs$id <- input_id
  shiny_ui$attribs[['data-value']] <- selected
  shiny_ui$attribs[['data-value-type']] <- type

  shiny::tagList(
    shiny::singleton(
      shiny::tags$head(
        shiny::tags$script(src = "shiny.semantic/shiny-custom-input.js")
      )
    ),
    shiny_ui
  )
}

#' Create universal Shiny text input binding
#'
#' Universal binding for Shiny text input on custom user interface. Value of this input is extracted via jQuery using $().val()
#' function. This function is just a simple binding over shiny_input. Please take a look at shiny_input documentation for more
#' information.
#'
#' @param ... Possible arguments are the same as in shiny_input() method: input_id, shiny_ui, value. Type is already predefined as "text"
#'
#' @export
shiny_text_input <- function(...) {
  shiny_input(type = "text", ...)
}
