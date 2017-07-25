#' Create Semantic UI icon tag
#'
#' This creates an icon tag using Semantic UI styles.
#'
#' @param type A name of an icon. Look at http://semantic-ui.com/elements/icon.html for all possibilities.
#' @param ... Other arguments to be added as attributes of the tag (e.g. style, class etc.)
#'
#' @export
uiicon <- function(type = "", ...) {
  shiny::tags$i(class = paste(type, "icon"), ...)
}

icon_if_present <- function(icon = "") {
  if(icon != "") {
    uiicon(icon)
  }
}

#' Create Semantic UI label tag
#' 
#' This creates a label tag using Semantic UI.
#' 
#' @param type Type of the label. Look at https://semantic-ui.com/elements/label.html for all possibilities.
#' @param ... Other arguments to be added such as content of the tag (text, icons) and/or attributes (style)
uilabel <- function(type = "", ...) {
  div(class = paste("ui label", type),
      list(...))
}

#' Create Semantic UI tabs
#'
#' This creates tabs with content using Semantic UI styles.
#'
#' @param tabs A list of tabs. Each tab is a list of two elements - first element defines menu item, second element defines tab content.
#' @param id Id of the menu element (default: randomly generated id)
#' @param menu_class Class for the menu element (default: "top attached tabular")
#' @param tab_content_class Class for the tab content (default: "bottom attached segment")
#'
#' @export
tabset <- function(tabs, id = generate_random_id("menu"), menu_class = "top attached tabular", tab_content_class = "bottom attached segment") {
  identifiers <- replicate(length(tabs), list(id = generate_random_id("tab")), simplify = FALSE)
  tabsWithId <- purrr::map2(identifiers, tabs, ~ c(.x, .y))

  shiny::tagList(
    shiny::div(id = id,
               class = paste("ui menu", menu_class),
               purrr::map(tabsWithId, ~
                            shiny::a(class = paste("item", if (.$id == tabsWithId[[1]]$id) "active" else ""),
                                     `data-tab`=.$id,
                                     .$menu
                            )
               )
    ),
    purrr::map(tabsWithId, ~
                 shiny::div(class = paste("ui tab", tab_content_class, if (.$id == tabsWithId[[1]]$id) "active" else ""),
                            `data-tab`=.$id,
                            .$content
                 )
    ),
    shiny::tags$script(paste0("$('#", id, ".menu .item').tab({onVisible: function() {$(window).resize()} });"))
  )
}

generate_random_id <- function(prefix, id_length = 20) {
  random_id <- paste(sample(letters, id_length, replace = TRUE), collapse = "")
  paste0(prefix, "-", random_id)
}

#' Create Semantic UI Dropdown
#' 
#' This creates a dropdown using Semantic UI.
#' 
#' @param type Type of the dropdown. Look at https://semantic-ui.com/modules/dropdown.html for all possibilities.
#' @param name Unique name of the created dropdown.
#' @param text Text displayed on the dropdown.
#' @param left_icon Icon diplayed on the left of the text in the dropdown.
#' @param right_icon Icon displayed on the right of the text in the dropdown.
#' @param in_menu TRUE if the dropdown is a menu item. Default is FALSE.
#' @param ... Dropdown items to be created. Use dropdown_item to create new dropdown item.
#' 
#' @export
uidropdown <- function(type = "", name = "", text = "", in_menu = "FALSE", ..., value = NULL) {
  unique_dropdown_class <- paste0('dropdown_name_', name)
  
  if (in_menu) {
    class <- paste("ui dropdown item", type, unique_dropdown_class)
  } else {
    class <- paste("ui dropdown", type, unique_dropdown_class)
  }
  
  div(class = class,
      shiny_text_input(name, tags$input(type = "hidden", name = name), value = value),
      
      div(class = "text", text),
      div(class = "menu",
          list(...)
      ),
      tags$script(paste0("$('.ui.dropdown.", unique_dropdown_class, "').dropdown();"))
  )
}



#' Create Semantic UI Dropdown Choice Item
#' 
#' This creates a dropdown item using Semantic UI.
#' 
#' @param text Text displayed on the dropdown choice item
#' @param left_icon Icon on the left of the text
#' @param right_icon Icon on the right of the text
#' 
#' @export
dropdown_choice <- function(text = "", left_icon = "", right_icon = "") {
  div(class = "item",
      `data-value` = text,
      icon_if_present(left_icon),
      text,
      icon_if_present(right_icon)
  )
}

#' Create Semantic UI Menu Item
#' 
#' This creates a menu items on the right of a Sematic UI Menu.
#' 
#' @param ... Menu items to be created in the menu on the right.
#' 
#' @export
right_menu <- function(...) {
  div(class = "right menu",
      list(...))
}


#' Create Semantic UI Menu Hyperlink Item
#' 
#' This creates a hyperlink menu item using Semantic UI
#' 
#' @param link To what the menu item should be linked. Default is "".
#' @param ... Content of the hyperlink menu item: text, icons or labels to be displayed. 
#' @param style Style of the item, e.g. "text-align: center".
#' @param item_feature If required, add additional item feature like 'active', 'header', etc.
#' 
#' @export
hyperlink_item <- function(link = "", ...,  item_feature = "", style = "") {
  a(class = paste("item", item_feature),
    href = link,
    list(...))
}

#' Create Semantic UI Menu Hyperlink Item
#' 
#' This creates a hyperlink menu item using Semantic UI
#' 
#' @param ... Other attributes of the menu item such as style and also content of the item: text, icons or labels to be displayed. 
#' @param item_feature If required, add additional item feature like 'active', 'header', etc.
#' 
#' @export
static_item <- function(..., item_feature = "", style = "") {
  div(class = paste("item", item_feature),
      style = style,
      list(...))
}

#' Create Semantic UI Menu
#' 
#' This creates a menu using Semantic UI.
#' 
#' @param type Type of the menu. Look at https://semantic-ui.com/collections/menu.html for all possiblities.
#' @param ... Menu items to be created. Use menu_item function to create new menu item. Use uidropdown(in_menu = TRUE, ...) to create a dropdown item. Use right_menu to create a submenu on the right.
#' 
#' @examples 
#' library(shiny)
#' library(shiny.semantic)
#' 
#' ui <- function() {
#'   shinyUI(
#'     semanticPage(
#'       title = "My page",
#'       suppressDependencies("bootstrap"),
#'       uimenu("pointing",
#'              static_item("Menu"),
#'              hyperlink_item("/index", uiicon("user"), "Profile", item_feature = "active"),
#'              hyperlink_item("Projects", link = "/projects"),
#'              uidropdown("", "unique_name", "UIDropdown", in_menu = TRUE, dropdown_choice("Open", "wrench icon"), dropdown_choice("Save", "user"), dropdown_choice("Undo", "inbox icon")),
#'              hyperlink_item(link = "", uiicon("users"), "Team"),
#'              right_menu(hyperlink_item(link = "", uiicon("add icon"), "New tab")))
#'     )
#'   )
#' }
#' 
#' server <- shinyServer(function(input, output) {
#' })
#' 
#' shinyApp(ui = ui(), server = server)
#' 
#' # Note that shiny::tags$a generates the same output as hyperlink_item. You can use shiny html tags to create more complex menu items if you label them with "item" class.
#' 
#' ui <- function() {
#'   shinyUI(
#'     semanticPage(
#'       title = "My page",
#'       suppressDependencies("bootstrap"),
#'       uimenu("vertical",
#'              a(class = "item teal",
#'                href = "",
#'                uiicon("users"), "User", uiicon("user"), uilabel("", 51)),
#'              hyperlink_item(link = "", item_feature = "teal", uiicon("users"), "User", uiicon("user"), uilabel("", 51)),
#'              static_item(h4(class = "ui icon header",
#'                             uiicon("user"),
#'                             div(class = "content", "File")),
#'                          item_feature = "",
#'                          style = "text-align: center"),
#'              static_item("", "", "Static")
#'       )
#'     )
#'   )
#' }
#' 
#' server <- shinyServer(function(input, output) {
#' })
#' 
#' shinyApp(ui = ui(), server = server)
#' 
#' @export
uimenu <- function(type = "", ...) {
  div(class = paste("ui menu", type),
      list(...))
}