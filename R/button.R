#' Create Semantic UI Button
#'
#' @param input_id The `input` slot that will be used to access the value.
#' @param label The contents of the button or link
#' @param icon An optional [icon()] to appear on the button.
#' @param class An optional attribute to be added to the button's class. If used
#' paramters like `color`, `size` are ignored.
#' @param ... Named attributes to be applied to the button
#'
#' @example inst/examples/button.R
#'
#' @export
button <- function(input_id, label, icon = NULL, class = NULL, ...) {
  tags$button(id = input_id, class = paste("ui", class, "button"), icon, " ", label, ...)
}

#' Action button
#'
#' Creates an action button whose value is initially zero, and increments by one each time it is pressed.
#'
#' @param input_id The input slot that will be used to access the value.
#' @param label The contents of the button - a text label, but you could also use any other HTML, like an image.
#' @param icon An optional [icon] to appear on the button.
#' @param width The width of the input.
#' @param ... Named attributes to be applied to the button or remaining parameters passed to button,
#'   like `class`.
#'
#' @example inst/examples/action_button.R
#'
#' @export
#' @rdname action_button
action_button <- function(input_id, label, icon = NULL, width = NULL, ...) {
  args_list <- list(...)
  args_list$input_id <- input_id
  args_list$label <- label
  args_list$icon <- icon
  args_list$style <- if (!is.null(width)) paste0("width: ", width, "; ", args_list$style) else args_list$style
  do.call(button, args_list)
}

#' @param inputId the same as `input_id`
#' @export
#' @rdname action_button
actionButton <- function(inputId, label, icon = NULL, width = NULL, ...) {
  action_button(inputId, label, icon, width, ...)
}

#' Change the label or icon of an action button on the client
#'
#' @param session The session object passed to function given to shinyServer.
#' @param input_id The id of the input object.
#' @param label The label to set for the input object.
#' @param icon The icon to set for the input object. To remove the current icon, use icon=character(0)
#'
#' @example inst/examples/update_action_button.R
#'
#'
#' @export
#' @rdname update_action_button
update_action_button <- function(session, input_id, label = NULL, icon = NULL) {
  message <- list(label = label, icon = as.character(icon))
  message <- message[!vapply(message, is.null, FUN.VALUE = logical(1))]

  session$sendInputMessage(input_id, message)
}

#' @param inputId the same as `input_id`
#' @rdname update_action_button
#' @export
updateActionButton <- function(session, inputId, label = NULL, icon = NULL) {
  update_action_button(session, inputId, label, icon)
}

#' Counter Button
#'
#' Creates a counter button whose value increments by one each time it is pressed.
#'
#' @param input_id The `input` slot that will be used to access the value.
#' @param label the content of the item to display
#' @param icon an optional [icon()] to appear on the button.
#' @param value initial rating value (integer)
#' @param color character with semantic color
#' @param big_mark big numbers separator
#' @param size character with size of the button, eg. "medium", "big"
#'
#' @return counter button object
#' @export
#' @rdname counterbutton
#' @example inst/examples/counter_button.R
counter_button <- function(input_id, label = "", icon = NULL, value = 0,
                           color = "", size = "", big_mark = " ") {
  big_mark_regex <- if (big_mark == " ") "\\s" else big_mark
  shiny::div(
    class = "ui labeled button", tabindex = "0",
    shiny::tagList(
      button(input_id = input_id, label, icon,
               class = paste(c(size, color), collapse = " "),
               `data-val` = value),
      shiny::tags$span(class = glue::glue("ui basic {color} label"),
                       format(value, big.mark = big_mark)),
      shiny::tags$script(HTML(
        glue::glue("$('#{input_id}').on('click', function() {{
          let $label = $('#{input_id} + .label')
          let value = parseInt($label.html().replace(/{big_mark_regex}/g, ''))
          $label.html((value + 1).toString().replace(/\\B(?=(\\d{{3}})+(?!\\d))/g, '{big_mark}'))
        }})")
      ))
    )
  )
}
