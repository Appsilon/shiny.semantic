#' Create Semantic UI checkbox
#'
#' This creates a checkbox using Semantic UI styles.
#'
#' @param id Input name. Reactive value is available under input[[name]].
#' @param label Text to be displayed with checkbox.
#' @param type Type of checkbox. Please check \code{checkbox_types} for possibilities.
#' @param is_marked Defines if checkbox should be marked. Default TRUE.
#' @param style Style of the widget.
#'
#' @export
simple_checkbox <- function(id, label, type = "", is_marked = TRUE, style = NULL) {
  if (!(type %in% checkbox_types)) {
    stop("Wrong type selected. Please check checkbox_types for possibilities.")
  }
  value <- if (is_marked) {
    "true"
  } else {
    "false"
  }
  selector <- paste0('.checkbox.', id)
  tagList(
    shiny_text_input(id, tags$input(type = "text", style = 'display:none'), value = value),
    div(
      style = style,
      class = paste("ui checkbox", type, id),
      tags$input(type = "checkbox", tags$label(label))
    ),
    tags$script(js_for_toggle_input(selector, id)),
    if (value == "true") tags$script(paste0("$('", selector, "').checkbox('set checked')")) else NULL
  )
}

js_for_toggle_input <- function(selector, input_id) {
  paste0("$('", selector, "').checkbox({
         onChecked: function() {
         $('#", input_id, "').val('true');
         $('#", input_id, "').change();
         },
         onUnchecked: function() {
         $('#", input_id, "').val('false');
         $('#", input_id, "').change();
         }});")
}

#' @export
uicheckbox <- function(..., type = "") {
  shiny::div(class = paste("ui checkbox", type), ...)
}

#' @export
multiple_checkbox <- function(input_id, label, choices, selected = NULL, position = "grouped", type = "radio", ...) {

  if (missing(input_id) || missing(label) || missing(choices)) {
    stop("Each of input_id, label and choices must be specified")
  }

  if (!(position %in% checkbox_positions)) {
    stop("Wrong position selected. Please check checkbox_positions for possibilities.")
  }

  if (!(type %in% checkbox_types)) {
    stop("Wrong type selected. Please check checkbox_types for possibilities.")
  }

  choices_names <- names(choices)
  choices_values <- choices

  if (!is.null(selected) && !(selected %in% choices_values)) {
    stop("choices must include selected value.")
  }

  if (is.null(selected)) {
    selected <- choices[[1]]
  }

  slider_field <- function(label, value, checked, type) {
    field_id <- shiny.semantic:::generate_random_id("slider", 10)

    if (checked) {
      checked <- "checked"
    } else {
      checked = NULL
    }
    uifield(
      uicheckbox(type = type, id = field_id,
                 tags$input(type = "radio", name = "field", checked = checked, value = value),
                 tags$label(label)
      )
    )
  }

  checked <- as.list(choices %in% selected)
  values <- choices
  labels <- as.list(names(choices))
  checkbox_id = sprintf("checkbox_%s", input_id)

  div(...,
      id = checkbox_id,
      shiny_text_input(input_id, tags$input(type = "text", style = 'display:none'), value = selected),
      uiform(
        div(class = sprintf("%s fields", position),
            tags$label(label),
            purrr::pmap(list(labels, values, checked), slider_field, type = type) %>%
              tagList()
        )
      ),
      tags$script(paste0("$('#", checkbox_id," .checkbox').checkbox({
        onChecked: function() {
          var childCheckboxValue  = $(this).closest('.checkbox').find('.checkbox').context.value;
          $('#", input_id, "').val(childCheckboxValue);
          $('#", input_id, "').change();

        }
      });"))
  )
}
