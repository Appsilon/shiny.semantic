#' Create Semantic UI modal
#'
#' This creates a modal using Semantic UI styles.
#'
#' @param id ID to be added to the modal div. Default "".
#' @param class Classes except "ui modal" to be added to the modal. Semantic UI classes can be used. Default "".
#' @param header Content to be displayed in the modal header. Default "".
#' @param content Content to be displayed in the modal body. Default "".
#' @param footer Content to be displayed in the modal footer. Usually for buttons. Default NULL.
#' @param target Javascript selector for the element that will open the modal. Default NULL.
#' @param settings List of vectors of Semantic UI settings to be added to the modal. Default NULL.
#'
#' @export
modal <- function(id = "",
                  class = "",
                  header = "",
                  content = "",
                  footer = NULL,
                  target = NULL,
                  settings = NULL) {

  div <- shiny::div

  default_modal_footer <- div(
    div(class = "ui button negative", "Cancel"),
    div(class = "ui button positive", "OK")
  )

  modal_header <- div(class = "header", header)
  modal_content <- div(class = "content", content)
  modal_actions <- div(
    class = "actions",
    if (!is.null(footer)) footer else default_modal_footer
  )

  shiny::tagList(
    div(
      id = id,
      class = paste0("ui modal ", class),
      modal_header,
      modal_content,
      modal_actions
    ),
    if (!is.null(target)) tags$script(attach_rule(id, "attach events", target, "show")),
    if (!is.null(settings)) {
      shiny::tagList(
        lapply(settings, function(x) tags$script(attach_rule(id, "setting", x[1], x[2])))
      )
    }
  )
}

attach_rule <- function(id, behavior, target, value) {
  is_boolean <- (value == "false" || value == "true")
  paste0(
    "$('#", id, "').modal('", behavior, "', '", target, "', ", if (!is_boolean) "'", value, if (!is_boolean) "'", ")"
  )
}

#' Show Semantic UI modal
#'
#' This displays a hidden Semantic UI modal.
#'
#' @param target Javascript selector for the modal that will be displayed.
#'
#' @export
show_modal <- function(selector) {
  shinyjs::runjs(paste0("$('", selector, "').modal('show')"))
}

#' Hide Semantic UI modal
#'
#' This hides a displayed Semantic UI modal.
#'
#' @param target Javascript selector for the modal that will be hidden.
#'
#' @export
remove_modal <- function(selector) {
  shinyjs::runjs(paste0("$('", selector, "').modal('hide')"))
}
