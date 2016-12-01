.onLoad <- function(libname, pkgname) {
  # Add directory for static resources
  message("attaching resources")
  shiny::addResourcePath('semanticui', system.file('www', package = 'semanticui', mustWork = TRUE))
}

shiny_input <- function(input_id, shiny_ui) {
  custom_input_class <- 'shiny-custom-input'
  shiny_ui$attribs$class <- paste(custom_input_class, ifelse(is.null(shiny_ui$attribs$class), "", shiny_ui$attribs$class))
  shiny_ui$attribs$id <- input_id

  shiny::tagList(
    shiny::singleton(
      shiny::tags$head(
        shiny::tags$script(src = "semanticui/dist.js")
      )
    ),
    shiny_ui
  )
}
