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
                        position = c("", "top fixed", "bottom fixed"),
                        header = NULL, footer = NULL,
                        collapsible = FALSE, window_title = title,
                        menu_class = NULL, theme = NULL, suppress_bootstrap = TRUE) {
  tabs <- list(...)
  position <- match.arg(position)
  if (is.null(selected)) selected <- get_first_tab(tabs)

  if (collapsible) {
    collapse_icon <- tags$button(
      class = "ui basic icon button collapsed-hamburger-icon",
      tags$i(class = "hamburger icon")
    )
  } else {
    collapse_icon <- NULL
  }

  menu_items <- lapply(tabs, navbar_menu_creator, selected = selected)
  menu_header <- tags$nav(
    div(
      class = paste("ui navbar-page-menu", position, menu_class, "stackable menu sem"),
      id = id,
      div(class = "item", title, collapse_icon),
      menu_items
    )
  )

  menu_content <- lapply(tabs, navbar_content_creator, selected = selected)

  semanticPage(
    menu_header, tags$header(header), tags$main(menu_content), tags$footer(footer),
    # shiny::tags$script(src = "shiny.semantic/shiny-semantic.js"),
    title = window_title, theme = theme, suppress_bootstrap = suppress_bootstrap, margin = 0
  )
}

navbar_menu_creator <- function(tab, selected = NULL) {
  if (inherits(tab, "ssnavmenu")) {
    dropdown_menu(
      id = tab$menu_name,
      name = tab$title,
      tags$i(class = "dropdown icon"),
      div(class = "menu", lapply(tab$tabs, navbar_menu_creator, selected = selected)),
      is_menu_item = TRUE,
      class = "navbar-collapisble-item"
    )
  } else if (is.character(tab)) {
    if (grepl("^(-|_){4,}$", tab)) menu_divider() else div(class = "header", tab)
  } else {
    title <- tab$attribs$`data-title`
    icon <- tab$attribs$`data-icon`
    tab_id <- tab$attribs$`data-tab`
    class <- paste0(if (identical(title, selected)) "active " else "", "item")

    tags$a(
      class = paste("navbar-collapisble-item", class),
      `data-tab` = tab_id,
      if (!is.null(icon)) tags$i(class = paste(icon, "icon")),
      if (!(!is.null(icon) && title == "")) title
    )
  }
}

navbar_content_creator <- function(tab, selected = NULL) {
  if (inherits(tab, "ssnavmenu")) {
    tagList(lapply(tab$tabs, navbar_content_creator, selected = selected))
  } else if (is.character(tab)) {
    NULL
  } else {
    title <- tab$attribs$`data-title`

    if (identical(title, selected)) {
      tab$attribs$class <- paste(tab$attribs$class, "active")
    }
    tab
  }
}

get_first_tab <- function(tabs, i = 1) {
  if (inherits(tabs[[i]], "ssnavmenu")) {
    get_first_tab(tabs[[i]]$tabs, i)
  } else if (is.character(tabs[[i]])) {
    get_first_tab(tabs, i + 1)
  } else {
    tabs[[i]]$attribs$`data-title`
  }
}

#' Navbar Menu
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
