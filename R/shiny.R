#' Internal function that expose javascript bindings to Shiny app.
.onLoad <- function(libname, pkgname) {
  # Add directory for static resources
  shiny::addResourcePath('shiny.semantic', system.file('www', package = 'shiny.semantic', mustWork = TRUE))
}

#' Universal binding for Shiny input on custom user interface. Using this function one can create various inputs
#' ranging from text, numerical, date, dropdowns, etc. Value of this input is extracted via jQuery using $().val()
#' function and exposed as serialized JSON to the Shiny server.
#'
#' @param input_id String with name of this input. Access to this input within server code is normal with input[[input_id]].
#' @param shiny_ui UI of HTML component presenting this input to the users. This UI should allow to extract its value with jQuery $().val() function.
#' @param value An optional argument with value that should be set for this input. Can be used to store persisten input valus in dynamic UIs.
#'
#' @export
shiny_input <- function(input_id, shiny_ui, value = NULL) {
  selected <- shiny::restoreInput(id = input_id, default = value)

  custom_input_class <- 'shiny-custom-input'
  shiny_ui$attribs$class <- paste(custom_input_class, ifelse(is.null(shiny_ui$attribs$class), "", shiny_ui$attribs$class))
  shiny_ui$attribs$id <- input_id
  shiny_ui$attribs[['data-value']] <- selected

  shiny::tagList(
    shiny::singleton(
      shiny::tags$head(
        shiny::tags$script(src = "shiny.semantic/shiny-binding.js")
      )
    ),
    shiny_ui
  )
}

#' Universal binding for Shiny input on custom user interface with text value. Main difference between this and shiny_input is lack of
#' JSON serialization.
#'
#' @param input_id String with name of this input. Access to this input within server code is normal with input[[input_id]].
#' @param shiny_ui UI of HTML component presenting this input to the users. This UI should allow to extract its value with jQuery $().val() function.
#' @param value An optional argument with value that should be set for this input. Can be used to store persisten input valus in dynamic UIs.
#'
#' @export
shiny_text_input <- function(input_id, shiny_ui, value = NULL) {
  selected <- shiny::restoreInput(id = input_id, default = value)

  custom_input_class <- 'shiny-custom-text-input'
  shiny_ui$attribs$class <- paste(custom_input_class, ifelse(is.null(shiny_ui$attribs$class), "", shiny_ui$attribs$class))
  shiny_ui$attribs$id <- input_id
  shiny_ui$attribs[['data-value']] <- selected

  shiny::tagList(
    shiny::singleton(
      shiny::tags$head(
        shiny::tags$script(src = "shiny.semantic/shiny-text-input.js")
      )
    ),
    shiny_ui
  )
}
