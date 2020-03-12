#' Create Semantic UI modal
#'
#' This creates a modal using Semantic UI styles.
#'
#' @param ... Content elements to be added to the modal body.
#' To change attributes of the container please check the `content` argument.
#' @param id ID to be added to the modal div. Default "".
#' @param class Classes except "ui modal" to be added to the modal. Semantic UI classes can be used. Default "".
#' @param header Content to be displayed in the modal header.
#' If given in form of a list, HTML attributes for the container can also be changed. Default "".
#' @param content Content to be displayed in the modal body.
#' If given in form of a list, HTML attributes for the container can also be changed. Default NULL.
#' @param footer Content to be displayed in the modal footer. Usually for buttons.
#' If given in form of a list, HTML attributes for the container can also be changed. Default NULL.
#' @param target Javascript selector for the element that will open the modal. Default NULL.
#' @param settings List of vectors of Semantic UI settings to be added to the modal. Default NULL.
#' @param modal_tags Other modal elements. Default NULL.
#'
#' @examples
#' ## Create a simple server modal
#' library(shiny)
#' library(shiny.semantic)
#'
#' ui <- function() {
#'   shinyUI(
#'     semanticPage(
#'       actionButton("show", "Show modal dialog")
#'     )
#'   )
#' }
#'
#' server = function(input, output) {
#'   observeEvent(input$show, {
#'     create_modal(modal(
#'       id = "simple-modal",
#'       title = "Important message",
#'       "This is an important message!"
#'     ))
#'   })
#' }
#'
#' ## Create a simple UI modal
#' library(shiny)
#' library(shiny.semantic)
#' ui <- function() {
#'   shinyUI(
#'     semanticPage(
#'       title = "Modal example - Static UI modal",
#'       div(id = "modal-open-button", class = "ui button", "Open Modal"),
#'       modal(
#'         div("Example content"),
#'         id = "example-modal",
#'         target = "modal-open-button"
#'       )
#'     )
#'   )
#' }
#'
#' ## Observe server side actions
#' library(shiny)
#' library(shiny.semantic)
#' ui <- function() {
#'   shinyUI(
#'     semanticPage(
#'       title = "Modal example - Server side actions",
#'       uiOutput("modalAction"),
#'       actionButton("show", "Show by calling show_modal")
#'     )
#'   )
#' }
#'
#' server <- shinyServer(function(input, output) {
#'   observeEvent(input$show, {
#'     show_modal('action-example-modal')
#'   })
#'   observeEvent(input$hide, {
#'     hide_modal('action-example-modal')
#'   })
#'
#'   output$modalAction <- renderUI({
#'     modal(
#'       actionButton("hide", "Hide by calling hide_modal"),
#'       id = "action-example-modal",
#'       header = "Modal example",
#'       footer = "",
#'       class = "tiny"
#'     )
#'   })
#' })
#'
#' ## Changing attributes of header and content.
#' library(shiny)
#' library(shiny.semantic)
#'
#' ui <- function() {
#'   shinyUI(
#'     semanticPage(
#'       actionButton("show", "Show modal dialog")
#'     )
#'   )
#' }
#'
#' server = function(input, output) {
#'   observeEvent(input$show, {
#'     create_modal(modal(
#'       id = "simple-modal",
#'       title = "Important message",
#'       header = list(style = "background: lightcoral"),
#'       content = list(style = "background: lightblue",
#'                      `data-custom` = "value", "This is an important message!"),
#'       p("This is also part of the content!")
#'     ))
#'   })
#' }
#'
#' @import shiny
#' @export
modal <- function(...,
                  id = "",
                  class = "",
                  header = "",
                  content = NULL,
                  footer = NULL,
                  target = NULL,
                  settings = NULL,
                  modal_tags = NULL) {

  div <- shiny::div

  if (is.null(footer)) {
    footer <- shiny::tagList(div(
      div(class = "ui button negative", "Cancel"),
      div(class = "ui button positive", "OK")
    ))
  } else if (class(footer)[[1]] == "shiny.tag") {
    footer <- shiny::tagList(footer)
  }

  if (class(header)[[1]] == "shiny.tag") {
    header <- shiny::tagList(header)
  }

  if (class(content)[[1]] == "shiny.tag") {
    content <- shiny::tagList(content)
  }

  modal_header <- do.call(div, c(list(class = "header"), header))
  modal_content <- do.call(div,
      c(list(class = "content"), content, shiny::tagList(...)))
  modal_actions <- do.call(div, c(
    list(class = "actions"),
    footer
  ))

  shiny::tagList(
    shiny::singleton(
      shiny::tags$head(
        shiny::tags$script(src = "shiny.semantic/shiny-semantic-modal.js")
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
        Shiny.initSemanticModal('", id, "')
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

#' Allows for the creation of modals in the server side without being tied to a specific HTML element.
#'
#' @param ui_modal HTML containing the modal.
#' @param show If the modal should only be created or open when called (open by default).
#' @param session Current session.
#'
#' @import shiny
#' @export
create_modal <- function(ui_modal, show = TRUE, session = shiny::getDefaultReactiveDomain()) {
  session$sendCustomMessage( # nolint
    "createSemanticModal",
    list(ui_modal = as.character(ui_modal),
    action = ifelse(show, "show", ""))
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
  shiny::removeUI(paste0("#", id))
}

#' @rdname show_modal
#' @export
hide_modal <- function(id, session = shiny::getDefaultReactiveDomain()) {
  session$sendCustomMessage("showSemanticModal", list(id = id, action = "hide")) # nolint
}
