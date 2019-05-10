#' Add Semantic UI slider component
#'
#' It implements slider extension provided by: https://github.com/tyleryasaka/semantic-ui-range
#'
#' @param name Input name. Reactive value is available under input[[name]].
#' @param min Minimum possible value to set.
#' @param max Miaksimum possible value to set.
#' @param value Initial value.
#' @param step Possible step for slider inputs.
#' @param n_ticks Specifies how many ticks the slider should display.
#' @param color Possible slider color, see: \link{semantic_palette}.
#'
#' @export
slider_input <- function(name, min, max, value, step = 0.01, n_ticks = 5, color = "") {
  check_proper_color(color)
  slider_id <- sprintf("slider-%s", name)

  shiny::tagList(
    div(style = "margin: 0.5em;",
      shiny_text_input(name, tags$input(type = "text", style = "display:none"), value = value),
      div(
        id = slider_id,
        class = paste("ui range", color),
        style = "padding-bottom: 0; padding-top: 2em;"),
      div(
        id = paste0(slider_id, "-tick-labels"),
        style = "padding-top: 1.2em;",
        paste(format(round(seq(min, max, length.out = n_ticks), 2), nsmall = 2), collapse = " ")
      )
    ),
    tags$style(
      sprintf("#%s-tick-labels {text-align: justify;}
              #%s-tick-labels:after {content: ''; display: inline-block; width: 100%%;}",
              slider_id, slider_id)
    ),
    tags$script(slider_js(slider_id, min, max, value, step, name))
  )
}

slider_js <- function(slider_id, min, max, init, step, name) {
  HTML(sprintf("
    $('#%s').range({
       min: %s,
       max: %s,
       start: %s,
       step: %s,
       onChange: function(value) {
         var html = '%s';
         $('#%s .thumb').html(html);
         $('#%s').val(value);
         $('#%s').change();
       }
    });",
    slider_id, min, max, init, step,
    div(
     class = "ui pointing below label",
     style = "bottom: 2.7em; right: 0.9em; width: 3.5em; text-align: center;",
     "'+ value +'"
    ),
    slider_id, name, name)
  )
}

