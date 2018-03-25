#' Add dashboard dependencies to html
#'
#' Internal function that adds dashboard dependencies to html.
#'
#' @return Content with appended dependencies.
get_dependencies <- function() {
  if (getOption("shiny.minified", TRUE)) {
    javascript_file <- "semantic.min.js"
    css_files <- c("semantic.min.css")
  } else {
    javascript_file <- "semantic.js"
    css_files <- c("semantic.css")
  }

  file <- system.file("semantic", package = "shiny.semantic")
  shiny::tagList(
    htmltools::htmlDependency("semantic-ui",
                              "2.1.8",
                              c(file = file),
                              script = javascript_file,
                              stylesheet = css_files
    )
  )
}

#' Get default semantic css
#'
#' @return path to default css semantic file
get_default_semantic_theme <- function() {
  # TODO cdf paths
  if (getOption("shiny.minified", TRUE)) {
    path <- system.file("semantic/semantic.min.css", package = "shiny.semantic")
  } else {
    path <- system.file("semantic/semantic.css", package = "shiny.semantic")
  }
  c(path)
}

#' Get default semantic js
#'
#' @return path to default js semantic file
get_default_semantic_js <- function() {
  # TODO cdf paths
  if (getOption("shiny.minified", TRUE)) {
    path <- system.file("semantic/semantic.min.js", package = "shiny.semantic")
  } else {
    path <- system.file("semantic/semantic.js", package = "shiny.semantic")
  }
  path
}

#' Semantic UI page
#'
#' This creates a Semantic page for use in a Shiny app.
#'
#' @param title A title to display in the browser's title bar.
#' @param theme Theme name or path
#' @param ... Other arguments to be added as attributes of the main div tag
#' wrapper (e.g. style, class etc.)
#'
#' @export
semanticPage <- function(..., title = "", theme = NULL) { # nolint
  content <- shiny::tags$div(class = "wrapper", ...)

  shiny::tagList(
    shiny::tags$head(
      shiny::tags$link(rel="stylesheet", href = check_semantic_theme(theme)),
      tags$script(src = get_default_semantic_js()),
      shiny::tags$title(title),
      shiny::tags$meta(name = "viewport", content = "width=device-width, initial-scale=1.0")
    ),
    shiny::tags$body(style = "min-height: 611px;", content)
  )
}

#' Supported semantic themes
SUPPORTED_THEMES <- c("cerulean", "darkly", "paper", "simplex",
                      "superhero", "flatly", "slate", "cosmo",
                      "readable",  "united", "journal", "solar",
                      "cyborg", "sandstone", "yeti", "lumen", "spacelab")

#' Cloudfront path
#' TODO fill in
CDN_PATH <- ""

#' Semantic theme path validator
#'
#' @param theme_css it can be either NULL, character with css path, or theme name
#'
#' @return path to theme
#' @export
#'
#' @examples
#' check_semantic_theme(NULL)
#' check_semantic_theme("darkly")
check_semantic_theme <- function(theme_css) {
  minfield <- ifelse(getOption("shiny.minified", TRUE), ".min", "")
  if (is.null(theme_css)) return(get_default_semantic_theme())
  if (tools::file_ext(theme_css) == "css") return(theme_css)
  if (theme_css %in% SUPPORTED_THEMES) {
    return(file.path(CDN_PATH, paste0("semantic.", theme_css, minfield, ".css"), fsep = "/"))
  } else {
    warning(paste("Theme ", theme_css, "not recognized. Default used instead!"))
    return(get_default_semantic_theme())
  }
}
