#' Get CDN path semantic dependencies
#'
#' Internal function that returns path string from `shiny.custom.semantic.cdn` options.
#'
#' @examples
#' ## Load shiny.semantic dependencies from local domain.
#' options("shiny.custom.semantic.cdn" = "shiny.semantic")
#'
#' @return CDN path of semantic dependencies
get_cdn_path <- function() {
  getOption("shiny.custom.semantic.cdn", default = "https://d335w9rbwpvuxm.cloudfront.net/2.8.3")
}

#' Add dashboard dependencies to html
#'
#' Internal function that adds dashboard dependencies to html.
#'
#' @param theme define theme
#'
#' @return Content with appended dependencies.
get_dependencies <- function(theme = NULL) {
  minfield <- if (getOption("shiny.minified", TRUE)) "min" else NULL
  javascript_file <- paste(c("semantic", minfield, "js"), collapse = ".")
  css_files <- c(check_semantic_theme(theme, full_url = FALSE))

  dep_src <- NULL
  if (!is.null(getOption("shiny.custom.semantic", NULL))) {
    dep_src <- c(file = getOption("shiny.custom.semantic"))
  } else if (isTRUE(getOption("shiny.semantic.local", FALSE))) {
    if (!is.null(theme)) {
      warning("It's not posible use local semantic version with themes. Using CDN")
    } else {
      dep_src <- c(
        file = system.file(
          "www",
          "shared",
          "semantic",
          package = "shiny.semantic"
        )
      )
    }
  }

  if (is.null(dep_src)) {
    dep_src <- c(href = get_cdn_path())
  }
  shiny::tagList(
    htmltools::htmlDependency("semantic-ui",
                              "2.8.3",
                              dep_src,
                              script = javascript_file,
                              stylesheet = css_files
    )
  )
}

#' Get default semantic css
#'
#' @param full_url define return output filename or full path. Default TRUE
#'
#' @return path to default css semantic file or default filename
get_default_semantic_theme <- function(full_url = TRUE) {
  minfield <- if (getOption("shiny.minified", TRUE)) "min" else NULL
  css_file <- paste(c("semantic", minfield, "css"), collapse = ".")
  path <- file.path(get_cdn_path(), css_file, fsep = "/")
  return(c(ifelse(full_url, path, css_file)))
}

#' Semantic theme path validator
#'
#' @param theme_css it can be either NULL, character with css path, or theme name
#' @param full_url boolean flag that defines what is returned, either filename, or full path. Default TRUE
#'
#' @return path to theme or filename
#' @export
#'
#' @examples
#' check_semantic_theme(NULL)
#' check_semantic_theme("darkly")
#' check_semantic_theme("darkly", full_url = FALSE)
check_semantic_theme <- function(theme_css, full_url = TRUE) {
  minfield <- if (getOption("shiny.minified", TRUE)) "min" else NULL
  if (is.null(theme_css)) return(get_default_semantic_theme(full_url))
  if (tools::file_ext(theme_css) == "css") return(theme_css)
  if (theme_css %in% SUPPORTED_THEMES) {
    if (full_url)
      return(
        file.path(
          get_cdn_path(),
          paste(c("semantic", theme_css, minfield, "css"), collapse = "."),
          fsep = "/"
        )
      )
    else
      return(paste(c("semantic", theme_css, minfield, "css"), collapse = "."))
  } else {
    warning(paste("Theme ", theme_css, "not recognized. Default used instead!"))
    return(get_default_semantic_theme(full_url))
  }
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
#' \code{SUPPORTED_THEMES} or at http://semantic-ui-forest.com/themes.
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
      shiny::tags$script(src = "shiny.semantic/shiny-semantic-dropdown.js"),
      shiny::tags$script(src = "shiny.semantic/shiny-semantic-button.js"),
      shiny::tags$script(src = "shiny.semantic/shiny-semantic-slider.js"),
      shiny::tags$script(src = "shiny.semantic/shiny-semantic-calendar.js"),
      shiny::tags$script(src = "shiny.semantic/shiny-semantic-fileinput.js"),
      shiny::tags$script(src = "shiny.semantic/shiny-semantic-numericinput.js"),
      shiny::tags$script(src = "shiny.semantic/shiny-semantic-rating.js"),
      shiny::tags$script(src = "shiny.semantic/shiny-semantic-tabset.js"),
      shiny::tags$script(src = "shiny.semantic/shiny-semantic-progress.js"),
      shiny::tags$script(src = "shiny.semantic/shiny-semantic-toast.js")
    ),
    shiny::tags$body(style = glue::glue("margin:{margin}; min-height: 611px;"),
                     suppress_bootstrap,
                     ...)
  )
}
