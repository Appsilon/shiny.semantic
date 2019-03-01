#' Create Semantic UI modal
#'
#' This creates a modal using Semantic UI styles.
#'
#' @param ... Content to be displayed in the modal body.
#' @param id ID to be added to the modal div. Default "".
#' @param class Classes except "ui modal" to be added to the modal. Semantic UI classes can be used. Default "".
#' @param header Content to be displayed in the modal header. Default "".
#' @param footer Content to be displayed in the modal footer. Usually for buttons. Default NULL.
#' @param target Javascript selector for the element that will open the modal. Default NULL.
#' @param settings List of vectors of Semantic UI settings to be added to the modal. Default NULL.
#' @param modal_tags Other modal elements. Default NULL.
#'
#' @import shiny
#' @export
modal <- function(...,
                  id = "",
                  class = "",
                  header = "",
                  footer = NULL,
                  target = NULL,
                  settings = NULL,
                  modal_tags = NULL) {

  div <- shiny::div

  default_modal_footer <- div(
    div(class = "ui button negative", "Cancel"),
    div(class = "ui button positive", "OK")
  )

  modal_header <- div(class = "header", header)
  modal_content <- div(class = "content", ...)
  modal_actions <- div(
    class = "actions",
    if (!is.null(footer)) footer else default_modal_footer
  )

  shiny::tagList(
    shiny::singleton(
      shiny::tags$head(
        shiny::tags$script(src = "shiny.semantic/shiny-modal-message.js")
      )
    ),
    div(
      id = id,
      class = paste0("ui modal ", class),
      modal_header,
      modal_content,
      modal_actions,
      modal_tags
    ),
    HTML(paste0(
      "<script>
        $('.ui.modal').modal({
           onShow: function () {
             Shiny.bindAll();
           }
         });
      </script>
      "
    )),
    if (!is.null(target)) tags$script(attach_rule(id, "attach events", paste0("#", target), "show")),
    if (!is.null(settings)) {
      shiny::tagList(
        lapply(settings, function(x) tags$script(attach_rule(id, "setting", x[1], x[2])))
      )
    }
  )
}

#' Internal function that creates the rule for a specific setting or behavior of the modal.
#'
#' @param id ID of the target modal.
#' @param behavior What behavior is beging set i. e. setting or attach events.
#' @param target First argument of the behavior. Usually a target or a setting name.
#' @param value Second argument of the behavior. usually an action or a setting value.

attach_rule <- function(id, behavior, target, value) {
  is_boolean <- (value == "false" || value == "true")
  paste0(
    "$('#", id, "').modal('", behavior, "', '", target, "', ", if (!is_boolean) "'", value, if (!is_boolean) "'", ")"
  )
}

#' Show, Hide or Remove Semantic UI modal
#'
#' This displays a hidden Semantic UI modal.
#'
#' @param id ID of the modal that will be displayed.
#' @param session The \code{session} object passed to function given to
#'   \code{shinyServer}.
#'
#' @export
show_modal <- function(id, session = shiny::getDefaultReactiveDomain()) {
  session$sendCustomMessage("showSemanticModal", list(id = id, action = "show")) # nolint
}

#' @rdname show_modal
#' @export
remove_modal <- function(id, session = shiny::getDefaultReactiveDomain()) {
  shiny::removeUI(paste0("#", id ))
}

#' @rdname show_modal
#' @export
hide_modal <- function(id, session = shiny::getDefaultReactiveDomain()) {
  session$sendCustomMessage("showSemanticModal", list(id = id, action = "hide")) # nolint
}
