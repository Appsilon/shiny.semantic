#' @export
slider_input <- function(name, min, max, value, step = 0.01, n_ticks = 5, color = "") {
  if (!(color %in% c("", "red", "yellow", "orange", "olive", "green", "teal", "blue", "violet", "purple", "pink", "brown", "grey"))) {
    stop("Wrong color parameter specified!")
  }

  tagList(
    div(style = "margin: 0.5em;",
      div(id = name, class = paste("ui range", color), style = "padding-bottom: 0; padding-top: 2em;"),
      div(
        id = paste0(name, "-tick-labels"),
        paste(format(round(seq(min, max, length.out = n_ticks), 2), nsmall = 2), collapse = " ")
      )
    ),
    tags$style(
      sprintf("#%s-tick-labels {text-align: justify;}
              #%s-tick-labels:after {content: ''; display: inline-block; width: 100%%;}",
              name, name)),
    tags$script(HTML(sprintf("
            $('#%s').range({
               min: %s,
               max: %s,
               start: %s,
               step: %s,
               verbose: true,
               debug: true,
               onChange: function(value) {
                 var $self = $(this),
                   firstVal = $self.range('get thumb value');
                 Shiny.onInputChange('%s', firstVal);
                 $self.find('.thumb').html('<div class = \"ui pointing below label\" style = \"bottom: 2.7em; right: 0.9em; width: 3.5em; text-align: center;\">' + firstVal + '</div>');
               }
            });",
            name, min, max, value, step, name
    )))
  )
}
