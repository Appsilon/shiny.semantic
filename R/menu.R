#' Helper function that transforms digits to words
#'
#' @param number numeric digits from 1 to 10
#'
#' @return character with number word
digits2words <- function(number) {
  textrep <- c("one","two","three","four","five",
               "six","seven","eight","nine", "ten")
  if(is.numeric(number)) {
    if (number >= 11 || number <= 0 || number %% 1 != 0)
      stop("Number must be an integer between 1 and 10")
    return(textrep[number])
  }
  else {
    stop("Not a number")
  }
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
render_menu_link <- function(location, title, active_location = "", icon = NULL) {
  class <- if (active_location == location) "active item" else "item"
  if (is.null(icon))
    icon_ui <- ""
  else
    icon_ui <- icon(icon)
  shiny::tags$a(class = class, href = location, icon_ui, title)
}

#' Horizontal menu
#'
#' Renders UI with horizontal menu
#'
#' @param menu_items list with list that can have fields: "name" (mandatory),
#' "link" and "icon"
#' @param active_location active location of the menu (should match
#' one from "link")
#' @param logo optional argument that displays logo on the left
#' of horizontal menu, can be character with image location, or shiny image object
#'
#' @return shiny div with horizontal menu
#' @export
#'
#' @examples
#' library(shiny.semantic)
#' menu_content <- list(
#'  list(name = "AA", link = "http://example.com", icon = "dog"),
#'  list(name = "BB", link = "#", icon="cat"),
#'  list(name = "CC")
#' )
#' if (interactive()){
#'   ui <- semanticPage(
#'    horizontal_menu(menu_content)
#'   )
#'   server <- function(input, output, session) {}
#'   shinyApp(ui, server)
#' }
horizontal_menu <- function(menu_items, active_location = "", logo = NULL) {
  if (!is.list(menu_items))
    stop("'menu_items' must be a list with specific entry names Check docs.")
  number_items <- length(menu_items)
  if (number_items == 0)
    stop("Empty list! No menu elements detected. Check docs.")
  if (is.null(logo))
    logo_ui <- ""
  else {
    number_items <- length(menu_items) + 1
    if (class(logo) == "shiny.tag")
      logo_ui <- shiny::div(class = "item",
                            logo)
    else
      logo_ui <- shiny::div(class = "item",
                            shiny::img(src = logo,
                                       style = "max-width: 100%; width: 200px"))
  }
  number_items <- digits2words(number_items)
  div(class = glue::glue("ui {number_items} item menu"),
      id = "menu_panel",
      logo_ui,
      purrr::map(menu_items,
                 function(x) {
                   if (is.null(x$name)) stop("Menu list entry needs to have a name")
                   if (is.null(x$link)) x$link <- "#"
                   render_menu_link(x$link,
                                    x$name,
                                    active_location,
                                    x$icon)
                 })
  )
}
