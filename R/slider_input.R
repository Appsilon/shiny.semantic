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
  ticks <- round(seq(min, max, length.out = n_ticks), 2)
  if (!all(ticks %% 1 == 0)) {
    ticks <- format(ticks, nsmall = 2)
  }

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
        paste(ticks, collapse = " ")
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

#' Java script code that allows passing slider value into shiny
#'
#' @param slider_id Id for div containing the slider.
#' @param min Minimum slider value.
#' @param max Maximum slider value.
#' @param init Initial value set for slider after the page is loaded.
#' @param step Step value defining possible values passes into slider.
#' @param name Id for input element responsible for passing chosen value into shiny.
#'
#' @description
#' JS code uses range method for slider div element.
#' The method allows to specify basic parameters for slider such as min, max, etc.
#' onChange parameter allows to specify callback executed after slider value is changed.
#' In this case onChange performs the following steps:
#' \itemize{
#'   \item{basing on selected value in slider it creates label with selected value and attaches it to slider pointer}
#'   \item{new value is attached to input element responsible for passing value into Shiny server}
#'   \item{the value attached to input element replaces the old one that triggers passing it to Shiny server}
#' }
#'
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
