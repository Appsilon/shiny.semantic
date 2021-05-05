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
navbar_page <- function(..., title = "", id = NULL, selected = NULL,
                        theme = NULL, suppress_bootstrap = TRUE) {
  tabs <- list(...)

  menu_items <- lapply(tabs, navbar_menu_creator, selected = selected)
  if (is.null(selected)) menu_items[[1]]$attribs$class <- "active item"
  menu_header <- tags$nav(
    div(
      class = "ui sem menu",
      div(class = "item", title),
      menu_items
    )
  )

  menu_content <- lapply(tabs, navbar_content_creator, selected = selected)
  if (is.null(selected)) menu_content[[1]]$attribs$class <- paste(menu_content[[1]]$attribs$class, "active")

  semanticPage(
    menu_header, menu_content,
    title = title, theme = theme, suppress_bootstrap = suppress_bootstrap, margin = 0
  )
}

navbar_menu_creator <- function(tab, selected = NULL) {
  title <- tab$attribs$`data-title`
  tab_id <- tab$attribs$`data-tab`
  active <- if (identical(title, selected)) "active " else ""

  tags$a(class = paste0(active, "item"), `data-tab` = tab_id, title)
}

navbar_content_creator <- function(tab, selected = NULL) {
  title <- tab$attribs$`data-title`
  if (identical(title, selected)) {
    tab$attribs$class <- paste(tab$attribs$class, "active")
  }
  tab
}

#' Navebar Menu
#'
#' @description
#'
#' @param title Display title for menu
#' @param ... \code{\link{tab_panel}} elements to include in the page. Can also include strings as section headers,
#' or "----" as a horizontal separator.
#' @param menu_name The value that is linked to the \code{navbar_menu}
#' @param icon Optional icon to appear on the tab.
#' This attribute is only valid when using a \code{tab_panel} within a \code{\link{navbar_page}}.
#'
#' @export
navbar_menu <- function(title, ..., menu_name = title, icon = NULL) {
  structure(
    list(title = title, menu_name = menu_name, tabs = list(...), icon = icon),
    class = "ssnavmenu"
  )
}

#' Tabset Panel
#'
#' @description
#' Create a tabset that contains \code{\link{tab_panel}}s.
#'
#' @export
tabset_panel <- function(..., id = NULL, selected = NULL, type = c("tabs", "pills", "hidden")) {

}

#' Tab Panel
#'
#' @description
#' Create a tab panel
#'
#' @param title Display title for tab
#' @param ... UI elements to include within the tab
#' @param value The value that should be sent when \code{\link{tabset_panel}} reports that this tab is selected.
#' If omitted and \code{\link{tabset_panel}} has an id, then the title will be used.
#' @param icon Optional icon to appear on the tab.
#' This attribute is only valid when using a \code{tab_panel} within a \code{\link{navbar_page}}.
#'
#' @return
#' A tab that can be passed to \code{\link{tabset_panel}}.
#'
#' @seealso \code{\link{tabset_panel}}
#'
#' @examples
#' tabset_panel(
#'   tab_panel("Plot", shiny::plotOutput("plot")),
#'   tab_panel("Summary", shiny::verbatimTextOutput("summary")),
#'   tab_panel("Table", shiny::tableOutput("table"))
#' )
#'
#' @export
tab_panel <- function(title, ..., value = title, icon = NULL) {
  shiny::div(
    class = "ui bottom attached tab segment",
    `data-title` = title, `data-tab` = value, `data-icon` = icon,
    ...
  )
}
