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
#' @param choices Use dropdown_menu to create set of choices, headers and dividers for the dropdown.
#' @param ... Dropdown items to be created. Use dropdown_item to create new dropdown item.
#' @param in_menu TRUE if the dropdown is a menu item. Default is FALSE.
#' @param dropdown_specs A list of dropdown functionalities. Look at https://semantic-ui.com/modules/dropdown.html#link3 for all possibilities.
#' @param value Default value of the dropdown. Useful when using selection dropdowns with default value selected.
#' 
#' @export
uidropdown <- function(type = "", name, choices = dropdown_menu(), ..., in_menu = "FALSE", dropdown_specs = list(), value = NULL) {
  
  if (missing(name)) {
    stop("Dropdown requires unique name. Specify 'name' argument.")
  }
  
  unique_dropdown_class <- paste0('dropdown_name_', name)
  
  if (in_menu) {
    class <- paste("ui dropdown item", type, unique_dropdown_class)
  } else {
    class <- paste("ui dropdown", type, unique_dropdown_class)
  }
  
  dropdown_functionality <- paste(dropdown_specs, collapse = ", ")
  
  div(class = class,
      shiny_text_input(name, tags$input(type = "hidden", name = name), value = value),
      list(...),
      choices,
      tags$script(paste0("$('.ui.dropdown.", unique_dropdown_class, "').dropdown({", dropdown_functionality, "});"))
  )
}

#' Create Semantic UI Dropdown Menu
#' 
#' @param ... Dropdown content. Use dropdown_choice to create dropdown item. Use dropdown_header to create dropdown header item.
#' Use dropdown_divider to create divider item.
#' 
#' @export
dropdown_menu <- function(...) {
  div(class = "menu",
      list(...)
  )
}

#' Create Semantic UI Dropdown Choice Item
#' 
#' This creates a dropdown item using Semantic UI.
#' 
#' @param name Name of the dropdown choice. This corresponds to 'value' argument for uidropdown.
#' @param ... Content of the dropdown choice such as text, icons, labels.
#' @param link To what dropdown choice should be linked. If not specified, dropdown choice is not linked.
#' 
#' @export
dropdown_choice <- function(name, ..., link) {
  if(missing(name)){
    stop("Dropdown choice requires a name!")
  }
  if (missing(link)) {
    div(class = "item",
        `data-value` = name,
        list(...)
    )
  } else {
    a(class = "item",
      href = link,
      `data-value` = name,
      list(...)
    )
  }
}

#' Create Semantic UI Hedaer Item
#' 
#' This creates a dropdown header item using Semantic UI.
#' 
#' @param ... Content of the header: text, icons, etc.
#' 
#' @export
dropdown_header <- function(...) {
  div(class = "header", ...)
}

#' Create Semantic UI Hedaer Item
#' 
#' This creates a dropdown header item using Semantic UI.
#' 
#' @param ... Other attributes of the divider such as style.
#' 
#' @export
dropdown_divider <- function(...) {
  div(class = "divider", ...)
}

#' Create Semantic UI Menu
#' 
#' This creates a menu using Semantic UI.
#' 
#' @param type Type of the menu. Look at https://semantic-ui.com/collections/menu.html for all possiblities.
#' @param ... Menu items to be created. Use hyperlink_item function to create new linked menu item. Use static_item 
#' function to create new static menu item. Use uidropdown(in_menu = TRUE, ...) to create a dropdown item. Use
#' right_menu to create a submenu on the right.
#' 
#' @examples 
#' library(shiny)
#' library(shiny.semantic)
#' 
#' ui <- function() {
#' shinyUI(
#'   semanticPage(
#'     title = "My page",
#'     suppressDependencies("bootstrap"),
#'     uimenu("secondary vertical",
#'            hyperlink_item("", "Account", item_feature = "active"),
#'            hyperlink_item("", "Settings"),
#'            uidropdown(type = "",
#'                       name = "unique_name",
#'                       in_menu = TRUE,
#'                       choices = dropdown_menu(dropdown_header("Text Size"),
#'                                               dropdown_choice("Small", "Small"),
#'                                               dropdown_choice("Medium", "Medium"),
#'                                               dropdown_choice("Large", "Large")),
#'                       value = NULL,
#'                       dropdown_specs = list("transition: 'drop'"),
#'                       uiicon("dropdown icon"),
#'                       "Display Options"))
#'   )
#' )
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
#' shinyUI(
#'   semanticPage(
#'     title = "My page",
#'     suppressDependencies("bootstrap"),
#'     uimenu("pointing",
#'            static_item("Menu"),
#'            uidropdown(type = "",
#'                       name = "unique_name",
#'                       in_menu = TRUE,
#'                       choices = dropdown_menu(
#'                         dropdown_header("File"),
#'                         dropdown_choice("Open", uiicon("wrench icon"), "Open"),
#'                         dropdown_choice("Save", uiicon("user")),
#'                         dropdown_choice("Undo", uiicon("inbox icon"), uiicon("users"), uiicon("user")),
#'                         dropdown_divider(),
#'                         dropdown_header("Home"),
#'                         dropdown_choice("Close", uiicon("wrench icon"), "Close")),
#'                       value = "Open",
#'                       uiicon("world icon"), 
#'                       span(class = "text", "Dropdown")),
#'            hyperlink_item("/index", uiicon("user"), "Profile", item_feature = "active"),
#'            hyperlink_item("Projects", link = "/projects"),
#'            hyperlink_item(link = "", uiicon("users"), "Team"),
#'            right_menu(hyperlink_item("", uiicon("add icon"), "New tab")))
#'   )
#' )
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

#' Create Semantic UI Menu on the right
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
#' @param style Style of the static menu item, e.g. "text-align: center"
#' 
#' @export
static_item <- function(..., item_feature = "", style = "") {
  div(class = paste("item", item_feature),
      style = style,
      list(...))
}