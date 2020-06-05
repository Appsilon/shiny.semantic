#' Helper function that transforms digits to words
#'
#' @param number numeric digits from 1 to 10
#'
#' @return character with number word
#'
#' @examples
#' digits2words(2) # 'two'
digits2words <- function(number) {
  textrep <- c("one","two","three","four","five",
               "six","seven","eight","nine", "ten")
  if(is.numeric(number)) {
    if (number >= 11 || number <= 0)
      stop("Number must be between 1 and 10")
    return(textrep[number])
  }
  else
    stop("Not a number")
}

#' Render menu link
#'
#' This function renders horizontal menu item.
#'
#' @param location character url with location
#' @param title name of the page
#' @param active_location name of the active subpage (if matches location then
#' it gets highlighted), default empty (\code{""})
#' @param icon non-mandatory parameter with icon name
#'
#' @return shiny.tag.a link
#' @export
#'
#' @examples
#' render_menu_link("#subpage1", "SUBPAGE")
render_menu_link <- function(location, title, active_location = "", icon = NA) {
  class <- if (active_location == location) "active item" else "item"
  if (is.na(icon))
    icon_ui <- ""
  else
    icon_ui <- uiicon(icon)
  shiny::tags$a(class = class, href = location, icon_ui, title)
}

#' Horizontal menu
#'
#' Renders UI with horizontal menu
#'
#' @param menu_items data.frame with columns: "name", "link" and optional "icon"
#' @param active_location active location of the menu (should match
#' one from "link")
#' @param logo optional argument that displays logo on the left
#' of horizontal menu, can be character with image location, or shiny image object
#'
#' @return shiny div with horizontal menu
#' @export
#'
#' @examples
#' menu_content <- data.frame(
#'  name = paste("Menu", 1:3),
#'  link = paste("page", 1:3),
#'  icon = c("home", "car", 'tree')
#' )
#' if (interactive()){
#'   ui <- semanticPage(
#'    horizontal_menu(menu_content)
#'   )
#'   server <- function(input, output, session) {}
#'   shinyApp(ui, server)
#' }
horizontal_menu <- function(menu_items, active_location = "", logo = NULL) {
  number_items <- nrow(menu_items)
    if (is.null(logo))
      logo_ui <- ""
    else {
      number_items <- nrow(menu_items) + 1
      if (class(logo) == "shiny.tag")
        logo_ui <- shiny::div(class = "item",
                              logo)
      else
        logo_ui <- shiny::div(class = "item",
                              shiny::img(src = logo,
                                         style = "max-width: 100%; width: 200px"))
    }
  number_items <- digits2words(number_items)
  if (!is.data.frame(menu_items))
    stop("'menu_items' must be a data.frame with specific columns. Check docs.")
  is_icon <- "icon" %in% colnames(menu_items)
  div(class = glue::glue("ui {number_items} item menu"),
      id = "menu_panel",
      logo_ui,
      purrr::map(menu_items %>% purrr::transpose(),
                 function(x) {
                   render_menu_link(x$link,
                                    x$name,
                                    active_location,
                                    ifelse(is_icon, x$icon, NA))
                 })
  )
}
