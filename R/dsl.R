#' Create Semantic UI icon tag
#'
#' This creates an icon tag using Semantic UI styles.
#'
#' @param ... Other arguments to be added as attributes of the tag (e.g. style, class etc.)
#' @param type A name of an icon. Look at http://semantic-ui.com/elements/icon.html for all possibilities.
#'
#' @export
uiicon <- function(type = "", ...) {
  shiny::tags$i(class = paste(type, "icon"), ...)
}

#' Create Semantic UI label tag
#'
#' This creates a label tag using Semantic UI.
#'
#' @param ... Other arguments to be added such as content of the tag (text, icons) and/or attributes (style)
#' @param type Type of the label. Look at https://semantic-ui.com/elements/label.html for all possibilities.
#' @param is_link If TRUE creates label with 'a' tag, otherwise with 'div' tag.
#' #'
#' @export
uilabel <- function(..., type = "", is_link = TRUE) {
  label_tag <- if (is_link) tags$a else tags$div
  label_tag(class = paste("ui label", type),
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

#' Create dropdown Semantic UI component
#'
#' This creates a default dropdown using Semantic UI styles with Shiny input.
#' Dropdown is already initialized and available under input[[name]].
#'
#' @param name Input name. Reactive value is available under input[[name]].
#' @param choices All available options one can select from.
#' @param choices_value What reactive value should be used for corresponding
#' choice.
#' @param default_text Text to be visible on dropdown when nothing is selected.
#' @param value Pass value if you want to initialize selection for dropdown.
#'
#' @examples
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#'
#'   library(shiny)
#'   library(shiny.semantic)
#'   ui <- function() {
#'       shinyUI(
#'         semanticPage(
#'           title = "Dropdown example",
#'           suppressDependencies("bootstrap"),
#'           uiOutput("dropdown"),
#'           p("Selected letter:"),
#'           textOutput("selected_letter")
#'        )
#'      )
#'   }
#'   server <- shinyServer(function(input, output) {
#'      output$dropdown <- renderUI({
#'          dropdown("simple_dropdown", LETTERS, value = "A")
#'      })
#'      output$selected_letter <- renderText(input[["simple_dropdown"]])
#'   })
#'
#'   shinyApp(ui = ui(), server = server)
#' }
#'
#' @export
dropdown <- function(name,
                     choices,
                     choices_value = choices,
                     default_text = "Select",
                     value = NULL) {
  unique_dropdown_class <- paste0("dropdown_name_", name)
  class <- paste("ui selection fluid dropdown", unique_dropdown_class)

  shiny::tagList(
    shiny::div(class = class,
               shiny_text_input(name,
                                shiny::tags$input(type = "hidden", name = name),
                                value = value
               ),
               uiicon("dropdown"),
               shiny::div(class = "default text", default_text),
               dropdown_menu(
                          purrr::map2(choices, choices_value, ~
                                        menu_item(`data-value` = .y, .x)
                          )
               )
    ),
    shiny::tags$script(paste0(
      "$('.ui.dropdown.", unique_dropdown_class,
      "').dropdown().dropdown('set selected', '", value, "');"
    ))
  )
}

#' Create Semantic UI Dropdown
#'
#' This creates a dropdown using Semantic UI.
#'
#' @param ... Dropdown content.
#' @param type Type of the dropdown. Look at https://semantic-ui.com/modules/dropdown.html for all possibilities.
#' @param name Unique name of the created dropdown.
#' @param choices Use dropdown_menu to create set of choices, headers and dividers for the dropdown.
#' @param is_menu_item TRUE if the dropdown is a menu item. Default is FALSE.
#' @param dropdown_specs A list of dropdown functionalities. Look at https://semantic-ui.com/modules/dropdown.html#/settings for all possibilities.
#'
#' @examples
#'
#' uidropdown(
#'   "Dropdown menu",
#'   uiicon(type = "dropdown"),
#'   dropdown_menu(
#'     menu_header("Header"),
#'     menu_divider(),
#'     menu_item("Option 1"),
#'     menu_item("Option 2")
#'   ),
#'   name = "dropdown_menu",
#'   dropdown_specs = list("duration: 500")
#' )

#'
#' @export
uidropdown <- function(..., type = NULL, name, is_menu_item = FALSE, dropdown_specs = list()) {

  if (missing(name)) {
    stop("Dropdown requires unique name. Specify 'name' argument.")
  }

  unique_dropdown_class <- paste0('dropdown_name_', name)

  if (is_menu_item) {
    class <- paste("ui dropdown item", type, unique_dropdown_class)
  } else {
    class <- paste("ui dropdown", type, unique_dropdown_class)
  }

  dropdown_functionality <- paste(dropdown_specs, collapse = ", ")

  shiny::tagList(
    shiny::div(class = class,
        list(...)
    ),
    tags$script(paste0("$('.ui.dropdown.", unique_dropdown_class, "').dropdown({", dropdown_functionality, "});"))
  )
}

#' Create Semantic UI Menu inside dropdown
#'
#' This creates a menu item that allows to insert more elements inside uidropdown.
#'
#' @param ... Menu items to be created inside dropdown.
#' @param type Type of specified menu. It can be: 'left', 'right' or NULL (default).
#' @param disable_ui_class If TRUE menu is created without ui class - used when UI menu is child of other ui class.
#'
#' @export
dropdown_menu <- function(..., type = NULL) {
  uimenu(..., type = type, disable_ui_class = TRUE)
}

#' Create Semantic UI Header Item
#'
#' This creates a dropdown header item using Semantic UI.
#'
#' @param ... Content of the header: text, icons, etc.
#' @param is_item If TRUE created header is item of Semantic UI Menu.
#'
#' @export
menu_header <- function(..., is_item = TRUE) {
  class <- "header"
  if (is_item) {
    class <- paste("item", class)
  }
  div(class = class, ...)
}

#' Create Semantic UI Divider Item
#'
#' This creates a menu divider item using Semantic UI.
#'
#' @param ... Other attributes of the divider such as style.
#'
#' @export
menu_divider <- function(...) {
  div(class = "divider", ...)
}

#' Create Semantic UI Menu
#'
#' This creates a menu using Semantic UI.
#'
#' @param ... Menu items to be created. Use menu_item function to create new menu item. Use uidropdown(is_menu_item = TRUE, ...)
#' function to create new dropdown menu item. Use menu_header and menu_divider functions to customize menu format.
#' @param type Type of the menu. Look at https://semantic-ui.com/collections/menu.html for all possiblities.
#' @param disable_ui_class If TRUE menu is created without ui class - used when UI menu is child of other ui class.
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
#'       uimenu(menu_item("Menu"),
#'              uidropdown(
#'                "Action",
#'                dropdown_menu(
#'                  menu_header(uiicon("file"), "File", is_item = FALSE),
#'                  menu_item(uiicon("wrench"), "Open"),
#'                  menu_item(uiicon("upload"), "Upload"),
#'                 menu_item(uiicon("remove"), "Upload"),
#'                  menu_divider(),
#'                  menu_header(uiicon("user"), "User", is_item = FALSE),
#'                  menu_item(uiicon("add user"), "Add"),
#'                  menu_item(uiicon("remove user"), "Remove")),
#'                type = "",
#'                name = "unique_name",
#'                is_menu_item = TRUE),
#'              menu_item(uiicon("user"), "Profile", is_link = TRUE, link = "#index", item_feature = "active"),
#'              menu_item("Projects", is_link = TRUE, link = "#projects"),
#'              menu_item(uiicon("users"), "Team"),
#'              dropdown_menu(menu_item(uiicon("add icon"), "New tab"), type = "right"))
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
uimenu <- function(..., type = NULL, disable_ui_class = FALSE) {
  class <- "menu"
  if (!disable_ui_class) {
    class <- paste("ui", class)
  }
  div(class = paste(class, type),
      list(...))
}

#' Create Semantic UI Menu Item
#'
#' This creates a menu item using Semantic UI
#'
#' @param ... Content of the menu item: text, icons or labels to be displayed.
#' @param item_feature If required, add additional item feature like 'active', 'header', etc.
#' @param style Style of the item, e.g. "text-align: center".
#' @param is_link If TRUE menu item is created with 'a' tag - ortherwise with 'div' tag (default).
#' @param link If is_link is TRUE, determines to what the menu item should be linked. Ignored when is_link is FALSE.
#'
#' @export
menu_item <- function(..., item_feature = NULL, style = NULL, is_link = FALSE, link = NULL) {
  menu_item_tag <- if (is_link) tags$a else tags$div
  link <- if (is_link) link else NULL
  menu_item_tag(class = paste("item", item_feature),
                href = link,
                style = style,
                list(...))
}
