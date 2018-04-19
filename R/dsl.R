#' Create Semantic UI icon tag
#'
#' This creates an icon tag using Semantic UI styles.
#'
#' @param type A name of an icon. Look at
#' http://semantic-ui.com/elements/icon.html for all possibilities.
#' @param ... Other arguments to be added as attributes of the
#' tag (e.g. style, class etc.)
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
#'
#' @import shiny
uilabel <- function(..., type = "", is_link = TRUE) {
  label_tag <- if (is_link) tags$a else tags$div
  label_tag(class = paste("ui label", type),
      list(...))
}

#' Create Semantic UI tabs
#'
#' This creates tabs with content using Semantic UI styles.
#'
#' @param tabs A list of tabs. Each tab is a list of two elements - first
#' element defines menu item, second element defines tab content.
#' @param id Id of the menu element (default: randomly generated id)
#' @param menu_class Class for the menu element (default: "top attached
#' tabular")
#' @param tab_content_class Class for the tab content (default: "bottom attached
#' segment")
#'
#' @export
tabset <- function(tabs,
                   id = generate_random_id("menu"),
                   menu_class = "top attached tabular",
                   tab_content_class = "bottom attached segment") {
  identifiers <- replicate(length(tabs),
                           list(id = generate_random_id("tab")),
                           simplify = FALSE)
  id_tabs <- purrr::map2(identifiers, tabs, ~ c(.x, .y))
  script_code <- paste0(
    " // Code below is needed to trigger visibility on reactive Shiny outputs.
      // Thanks to that users do not have to set suspendWhenHidden to FALSE.
      var previous_tab;
      $('#", id, ".menu .item').tab({
      onVisible: function(target) {
      if (previous_tab) {
      $(this).trigger('hidden');
      }
      $(window).resize();
      $(this).trigger('shown');
      previous_tab = this;}});")
  shiny::tagList(
    shiny::div(id = id,
               class = paste("ui menu", menu_class),
               purrr::map(id_tabs, ~ {
                 class <- paste("item", if (.$id == id_tabs[[1]]$id) "active" else "")
                 shiny::a(class = class, `data-tab` = .$id, .$menu)
               })
    ),
    purrr::map(id_tabs, ~ {
      class <- paste("ui tab", tab_content_class,
                     if (.$id == id_tabs[[1]]$id) "active" else "")
      shiny::div(class = class, `data-tab` = .$id, .$content)
    }),
    shiny::tags$script(script_code)
  )
}

generate_random_id <- function(prefix, id_length = 20) {
  random_id <- paste(sample(letters, id_length, replace = TRUE), collapse = "")
  paste0(prefix, "-", random_id)
}

#' Create Semantic UI header
#'
#' This creates a header with optional icon using Semantic UI styles.
#'
#' @param title Header title
#' @param description Subheader text
#' @param icon Optional icon name
#'
#' @export
uiheader <- function(title, description, icon = NULL) {
  shiny::h2(class = "ui header",
            if (!is.null(icon)) uiicon(icon),
            shiny::div(class = "content", title,
                       shiny::div(class = "sub header", description)
            )
  )
}

#' Create Semantic UI cards tag
#'
#' This creates a cards tag using Semantic UI styles.
#'
#' @param ... Other arguments to be added as attributes of the
#' tag (e.g. style, class or childrens etc.)
#' @param class Additional classes to add to html tag.
#'
#' @export
uicards <- function(..., class = "") {
  shiny::div(class = paste("ui cards", class), ...)
}

#' Create Semantic UI card tag
#'
#' This creates a card tag using Semantic UI styles.
#'
#' @param ... Other arguments to be added as attributes of the
#' tag (e.g. style, class or childrens etc.)
#' @param class Additional classes to add to html tag.
#'
#' @export
uicard <- function(..., class = "") {
  shiny::div(class = paste("ui card", class), ...)
}

#' Create Semantic UI segment
#'
#' This creates a segment using Semantic UI styles.
#'
#' @param ... Other arguments to be added as attributes of the
#' tag (e.g. style, class or childrens etc.)
#' @param class Additional classes to add to html tag.
#'
#' @export
uisegment <- function(..., class = "") {
  shiny::div(class = paste("ui segment", class), ...)
}

#' Create Semantic UI form tag
#'
#' This creates a form tag using Semantic UI styles.
#'
#' @param ... Other arguments to be added as attributes of the
#' tag (e.g. style, class or childrens etc.)
#' @param class Additional classes to add to html tag.
#'
#' @export
uiform <- function(..., class = "") {
  shiny::tags$form(class = paste("ui form", class),
                   ...
  )
}

#' Create Semantic UI fields tag
#'
#' This creates a fields tag using Semantic UI styles.
#'
#' @param ... Other arguments to be added as attributes of the
#' tag (e.g. style, class or childrens etc.)
#' @param class Additional classes to add to html tag.
#'
#' @export
uifields <- function(..., class = "") {
  shiny::div(class = paste("fields", class), ...)
}

#' Create Semantic UI field tag
#'
#' This creates a field tag using Semantic UI styles.
#'
#' @param ... Other arguments to be added as attributes of the
#' tag (e.g. style, class or childrens etc.)
#' @param class Additional classes to add to html tag.
#'
#' @export
uifield <- function(..., class = "") {
  shiny::div(class = paste("field", class), ...)
}

#' Create HTML label tag
#'
#' This creates a HTML label tag.
#'
#' @param ... Other arguments to be added as attributes of the
#' tag (e.g. style, class or childrens etc.)
#'
#' @export
label <- function(...) {
  shiny::tags$label(...)
}

#' Create Semantic UI Message
#'
#' @param header Header of the message
#' @param content Content of the message. If it is a vector, creates a list of
#' vector's elements
#' @param type Type of the message. Look at
#' https://semantic-ui.com/collections/message.html for all possibilities.
#' @param icon If the message is of the type 'icon', specify the icon.
#' Look at http://semantic-ui.com/elements/icon.html for all possibilities.
#' @param closable Determines whether the message should be closable.
#' Default is FALSE - not closable
#'
#' @export
uimessage <- function(header, content, type = "", icon, closable = FALSE) {
  if (length(content) > 1) {
    content <- shiny::tags$ul(class = "list", lapply(content, shiny::tags$li))
  }
  if (grepl("icon", type)) {
    if (missing(icon)) {
      stop("Type 'icon' requires an icon!")
    }
    icon_else_header <- uiicon(icon)
    message_else_content <- shiny::div(class = "content",
                                       shiny::div(class = "header", header),
                                       content)
  } else {
    icon_else_header <- shiny::div(class = "header", header)
    message_else_content <- content
  }
  div(class = paste("ui message", type),
      if (closable) {
        closable_messages <- "$('.message .close')
          .on('click', function() {
            $(this)
              .closest('.message')
              .transition('fade')
            ;
          })
        ;"
        uiicon("close icon", shiny::tags$script(shiny::HTML(closable_messages)))
      },
      icon_else_header,
      message_else_content)
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
               uimenu(
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

#' Create Semantic UI Menu
#'
#' This creates a menu using Semantic UI.
#'
#' @param ... Menu items to be created. Use menu_item function to create new menu item. Use uidropdown(is_menu_item = TRUE, ...)
#' function to create new dropdown menu item. Use menu_header and menu_divider functions to customize menu format.
#' @param type Type of the menu. Look at https://semantic-ui.com/collections/menu.html for all possiblities.
#'
#' @examples
#'
#' if (interactive()){
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
#'                uimenu(
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
#'              menu_item(uiicon("user"), "Profile", href = "#index", item_feature = "active"),
#'              menu_item("Projects", href = "#projects"),
#'              menu_item(uiicon("users"), "Team"),
#'              uimenu(menu_item(uiicon("add icon"), "New tab"), type = "right"))
#'     )
#'   )
#' }
#'
#' server <- shinyServer(function(input, output) {
#' })
#'
#' shinyApp(ui = ui(), server = server)
#'}
#' @export
uimenu <- function(..., type = "") {
  class <- "ui menu"
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
#' @param href If NULL (default) menu_item is created with 'div' tag. Otherwise it is created with 'a' tag, and
#' parameeter defines its href attribute.
#'
#' @export
#'
#' @import shiny
menu_item <- function(..., item_feature = "", style = NULL, href = NULL) {
  menu_item_tag <- if (!is.null(href)) tags$a else tags$div
  menu_item_tag(class = paste("item", item_feature),
                href = href,
                style = style,
                ...)
}

#' Create Semantic UI Dropdown
#'
#' This creates a dropdown using Semantic UI.
#'
#' @param ... Dropdown content.
#' @param type Type of the dropdown. Look at https://semantic-ui.com/modules/dropdown.html for all possibilities.
#' @param name Unique name of the created dropdown.
#' @param is_menu_item TRUE if the dropdown is a menu item. Default is FALSE.
#' @param dropdown_specs A list of dropdown functionalities. Look at https://semantic-ui.com/modules/dropdown.html#/settings for all possibilities.
#'
#' @examples
#'
#' uidropdown(
#'   "Dropdown menu",
#'   uiicon(type = "dropdown"),
#'   uimenu(
#'     menu_header("Header"),
#'     menu_divider(),
#'     menu_item("Option 1"),
#'     menu_item("Option 2")
#'   ),
#'   name = "dropdown_menu",
#'   dropdown_specs = list("duration: 500")
#' )
#' @import shiny
#' @export
uidropdown <- function(..., type = "", name, is_menu_item = FALSE, dropdown_specs = list()) {

  if (missing(name)) {
    stop("Dropdown requires unique name. Specify \"name\" argument.")
  }

  unique_dropdown_class <- paste0("dropdown_name_", name)

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

#' Create Semantic UI Header Item
#'
#' This creates a dropdown header item using Semantic UI.
#'
#' @param ... Content of the header: text, icons, etc.
#' @param is_item If TRUE created header is item of Semantic UI Menu.
#'
#' @export
#'
#' @import shiny
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
#'
menu_divider <- function(...) {
  shiny::div(class = "divider", ...)
}

#' Helper function to render list element
#'
#' @param data data to list
#' @param is_description description flag
#' @param icon Icon character
#' @param row row character
#'
#' @import shiny
list_element <- function(data, is_description, icon, row) {
  div(class = "item",  if (icon == "") "" else uiicon(icon),
      if (is_description) {
        div(class = "content",
            div(class = "header", data$header[row]),
            div(class = "description", data$description[row]))
      } else {
        div(class = "content", data$header[row])
      }
      )
}

#' Create Semantic UI list with header, description and icons
#'
#' This creates a list with icons using Semantic UI
#'
#' @param data A dataframe with columns `header` and/or `description` containing the list items
#' headers and descriptions. `description` column is optional and should be provided
#' if `is_description` parameter TRUE.
#' @param icon A string with icon name. Empty string will render list without icons.
#' @param is_divided If TRUE created list elements are divided
#' @param is_description If TRUE created list will have a description
#'
#' @export
#' @import shiny
#' @examples
#'
#' list_content <- data.frame(
#'   header = paste("Header", 1:5),
#'   description = paste("Description", 1:5),
#'   stringsAsFactors = FALSE
#' )
#'
#' # Create a 5 element divided list with alert icons and description
#' uilist(list_content, "alert", is_divided = TRUE, is_description = TRUE)
uilist <- function(data, icon, is_divided = FALSE, is_description = FALSE){
  divided_list <- ifelse(is_divided, "divided", "")
  list_class <- paste("ui", divided_list, "list")

  div(class = list_class,
      1:nrow(data) %>% purrr::map(function(row){
        list_element(data, is_description, icon, row)
        })
  )
}
