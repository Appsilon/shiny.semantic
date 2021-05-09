#' Semantic UI page with top level navigation bar
#'
#' @description
#' This creates a Semantic page for use in a Shiny app. It is in the same layout as \code{\link[shiny]{navbarPage}},
#' where a top level navigation bar exists.
#'
#' @details
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
#' @param ... Other arguments to be added as attributes of the main div tag wrapper (e.g. style, class etc.)
#' @param title A title to display in the navbar.
#' @param id ID of the navbar menu. Given random ID if none specified.
#' @param selected Which tab should be selected first? If none selected, will automatically have the first tab open.
#' @param position Determines the location and behaviour of the navbar. Padding will be included when pinned to prevent
#' overlap.
#' \itemize{
#' \item{""}{Default. Top of page, and goes out of view when scrolling}
#' \item{"top fixed"}{Top of page, pinned when scrolling}
#' \item{"bottom fixed"}{Bottom of page, pinned when scrolling}
#' }
#' @param header Optional list of tags to be added to the top of all \code{tab_panel}s.
#' @param footer Optional list of tags to be added to the bottom of all \code{tab_panel}s.
#' @param collapsible \code{TRUE} to automatically collapse the navigation elements into a menu when the width of the
#' browser is less than 768 pixels (useful for viewing on smaller touchscreen device)
#' @param window_title A title to display in the browser's title bar. By default it will be the same as the navbar
#' title.
#' @param type Class to be given to the navbar menu.
#' @param theme Theme name or path. Full list of supported themes you will find in
#' \code{SUPPORTED_THEMES} or at http://semantic-ui-forest.com/themes.
#' @param suppress_bootstrap boolean flag that supresses bootstrap when turned on
#'
#' @examples
#' navbar_page(
#'   "App Title",
#'   tab_panel("Plot"),
#'   tab_panel("Summary"),
#'   tab_panel("Table")
#' )
#'
#' navbar_page(
#'   "App Title",
#'   tab_panel("Plot"),
#'   tab_panel("Icon", icon = "r project"),
#'   navbar_menu(
#'     "More",
#'     tab_panel("Summary"),
#'     "----",
#'     "Section header",
#'     tab_panel("Table")
#'   )
#' )
#'
#' @export
navbar_page <- function(..., title = "", id = NULL, selected = NULL,
                        position = c("", "top fixed", "bottom fixed"),
                        header = NULL, footer = NULL,
                        collapsible = FALSE, window_title = title,
                        type = "stackable", theme = NULL, suppress_bootstrap = TRUE) {
  tabs <- list(...)
  position <- match.arg(position)
  # Padding depending on the position
  body_padding <- switch(position, "top fixed" = "padding-top: 40px;", "bottom fixed" = "padding-bottom: 40px;", "")
  if (is.null(selected)) selected <- get_first_tab(tabs)
  if (is.null(id)) id <- generate_random_id("navbar_menu")

  if (collapsible) {
    collapse_icon <- tags$button(
      class = "ui basic icon button collapsed-hamburger-icon",
      tags$i(class = "hamburger icon")
    )
  } else {
    collapse_icon <- NULL
  }

  menu_items <- c(
    list(div(class = "item", title, collapse_icon)),
    lapply(tabs, navbar_menu_creator, selected = selected)
  )

  menu_header <- tags$nav(
    div(
      class = paste("ui navbar-page-menu", position, type, "menu sem"),
      id = id,
      menu_items
    )
  )

  menu_content <- lapply(tabs, navbar_content_creator, selected = selected)

  semanticPage(
    menu_header,
    div(style = body_padding, tags$header(header), tags$main(menu_content), tags$footer(footer)),
    title = window_title, theme = theme, suppress_bootstrap = suppress_bootstrap, margin = 0
  )
}

navbar_menu_creator <- function(tab, selected = NULL) {
  if (inherits(tab, "ssnavmenu")) {
    dropdown_menu(
      id = tab$id,
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
#' Create a dropdown menu for a \code{\link{navbar_page}}.
#'
#' @param title Display title for menu
#' @param ... \code{\link{tab_panel}} elements to include in the page. Can also include strings as section headers,
#' or "----" as a horizontal separator.
#' @param id The ID of the \code{navbar_menu}
#' @param icon Optional icon to appear on the tab.
#' This attribute is only valid when using a \code{tab_panel} within a \code{\link{navbar_page}}.
#'
#' @examples
#' navbar_menu(
#'   "Menu",
#'   tab_panel("Summary", shiny::plotOutput("plot")),
#'   "----",
#'   "Section header",
#'   tab_panel("Table", shiny::tableOutput("table"))
#' )
#'
#' @export
navbar_menu <- function(title, ..., id = title, icon = NULL) {
  structure(
    list(title = title, id = id, tabs = list(...), icon = icon),
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
#' @param value The value that should be sent when \code{\link{navbar_menu}} reports that this tab is selected.
#' If omitted and \code{\link{navbar_menu}} has an id, then the title will be used.
#' @param icon Optional icon to appear on the tab.
#' This attribute is only valid when using a \code{tab_panel} within a \code{\link{navbar_page}}.
#' @param type Change depending what type of tab is wanted. Default is \code{bottom attached segment}.
#'
#' @return
#' A tab that can be passed to \code{\link{navbar_menu}}.
#'
#' @seealso \code{\link{navbar_menu}}
#'
#' @examples
#' navbar_menu(
#'   tab_panel("Plot", shiny::plotOutput("plot")),
#'   tab_panel("Summary", shiny::verbatimTextOutput("summary")),
#'   tab_panel("Table", shiny::tableOutput("table"))
#' )
#'
#' @export
tab_panel <- function(title, ..., value = title, icon = NULL, type = "bottom attached segment") {
  shiny::div(
    class = paste("ui tab", type),
    `data-title` = title, `data-tab` = value, `data-icon` = icon,
    ...
  )
}
