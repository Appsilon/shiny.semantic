#' Get dependencies path
#'
#' @return path with css and js files
#' @keywords internal
get_dependencies_path <- function() {
  if (!is.null(getOption("shiny.custom.semantic"))) {
    return(
      list(
        src = c(file = getOption("shiny.custom.semantic")),
        type = "custom"
      )
    )
  }

  if (!is.null(getOption("shiny.custom.semantic.cdn"))) {
    return(
      list(
        src = c(href = getOption("shiny.custom.semantic.cdn")),
        type = "cdn"
      )
    )
  }

  list(
    src = c(
      file = system.file(
        "www",
        "shared",
        "semantic",
        package = "semantic.assets"
      )
    ),
    type = "local"
  )
}

#' Add dashboard dependencies to html
#'
#' Internal function that adds dashboard dependencies to html.
#'
#' @param theme define theme
#'
#' @return Content with appended dependencies.
#' @keywords internal
get_dependencies <- function(theme = NULL) {
  dep_src <- get_dependencies_path()

  minified <- if (getOption("shiny.minified", TRUE)) "min" else NULL
  javascript_file <- paste(c("semantic", minified, "js"), collapse = ".")

  css_file <- get_css_file(
    type = dep_src$type,
    theme = theme,
    minified = minified
  )

  shiny::tagList(
    shiny::tagList(
      htmltools::htmlDependency(
        "semantic-ui",
        "2.8.3",
        dep_src$src,
        script = javascript_file,
        stylesheet = css_file
      )
    )
  )
}

#' Get css file
#'
#' @param type define type of dependencies source
#' @param theme define theme
#' @param minified define if minified version should be used
#'
#' @return css file name
#' @keywords internal
get_css_file <- function(type, theme = NULL, minified = NULL) {
  if (type == "custom") {
    return(theme)
  }

  if (type == "local" && !(is.null(theme) || theme %in% semantic.assets::SUPPORTED_THEMES)) {
    warning(paste("Theme ", theme, "not recognized. Default used instead!"))
    theme <- NULL
  }

  paste(c("semantic", theme, minified, "css"), collapse = ".")
}

#' Semantic UI page
#'
#' This creates a Semantic page for use in a Shiny app.
#'
#' Inside, it uses two crucial options:
#'
#' (1) \code{shiny.minified} with a logical value, tells whether it should attach min or full
#' semnatic css or js (TRUE by default).
#' (2) \code{shiny.custom.semantic} if this option has not NULL character \code{semanticPage}
#' takes dependencies from custom css and js files specified in this path
#' (NULL by default). Depending on \code{shiny.minified} value the folder should contain
#' either "min" or standard version. The folder should contain: \code{semantic.css} and
#' \code{semantic.js} files, or \code{semantic.min.css} and \code{semantic.min.js}
#' in \code{shiny.minified = TRUE} mode.
#'
#' @param ... Other arguments to be added as attributes of the main div tag
#' wrapper (e.g. style, class etc.)
#' @param title A title to display in the browser's title bar.
#' @param theme Theme name or path. Full list of supported themes you will find in
#' \code{\link[semantic.assets:SUPPORTED_THEMES]{semantic.assets::SUPPORTED_THEMES}}
#' or at http://semantic-ui-forest.com/themes.
#' @param suppress_bootstrap boolean flag that supresses bootstrap when turned on
#' @param margin character with body margin size
#' @examples
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#' library(shiny)
#' library(shiny.semantic)
#'
#' ui <- semanticPage(
#'   title = "Hello Shiny Semantic!",
#'   tags$label("Number of observations:"),
#'   slider_input("obs", value = 500, min = 0, max = 1000),
#'   segment(
#'     plotOutput("dist_plot")
#'   )
#' )
#'
#' server <- function(input, output) {
#'   output$dist_plot <- renderPlot({
#'     hist(rnorm(input$obs))
#'   })
#' }
#'
#' shinyApp(ui, server)
#' }
#'
#' @export
semanticPage <- function(..., title = "", theme = NULL, suppress_bootstrap = TRUE,
                         margin = "10px") {
  if (suppress_bootstrap) {
    suppress_bootstrap <- suppressDependencies("bootstrap")
  }
  else {
    suppress_bootstrap <- NULL
  }
  shiny::tagList(
    shiny::tags$head(
      get_dependencies(theme),
      shiny::tags$title(title),
      shiny::tags$meta(name = "viewport", content = "width=device-width, initial-scale=1.0"),
      shiny::tags$link(rel = "stylesheet", type = "text/css",
                       href = "shiny.semantic/shiny-semantic-DT.css"),
      shiny::tags$script(src = "shiny.semantic/shiny-semantic-modal.js"),
      shiny::tags$script(src = "shiny.semantic/shiny-semantic-checkbox.js"),
      shiny::tags$script(src = "shiny.semantic/shiny-semantic-dropdown.js"),
      shiny::tags$script(src = "shiny.semantic/shiny-semantic-button.js"),
      shiny::tags$script(src = "shiny.semantic/shiny-semantic-slider.js"),
      shiny::tags$script(src = "shiny.semantic/shiny-semantic-calendar.js"),
      shiny::tags$script(src = "shiny.semantic/shiny-semantic-fileinput.js"),
      shiny::tags$script(src = "shiny.semantic/shiny-semantic-numericinput.js"),
      shiny::tags$script(src = "shiny.semantic/shiny-semantic-rating.js"),
      shiny::tags$script(src = "shiny.semantic/shiny-semantic-tabset.js"),
      shiny::tags$script(src = "shiny.semantic/shiny-semantic-progress.js"),
      shiny::tags$script(src = "shiny.semantic/shiny-semantic-toast.js"),
      shiny::tags$script(src = "shiny.semantic/shiny-semantic-step.js")
    ),
    shiny::tags$body(style = glue::glue("margin:{margin};"),
                     suppress_bootstrap,
                     ...)
  )
}
