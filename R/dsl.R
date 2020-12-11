#' Create Semantic UI icon tag
#'
#' This creates an icon tag using Semantic UI styles.
#'
#' @param class A name of an icon. Look at
#' http://semantic-ui.com/elements/icon.html for all possibilities.
#' @param ... Other arguments to be added as attributes of the
#' tag (e.g. style, class etc.)
#'
#' @example inst/examples/icon.R
#'
#'
#' @export
icon <- function(class = "", ...) {
  shiny::tags$i(class = paste(class, "icon"), ...)
}

#' Create Semantic UI label tag
#'
#' This creates a `div` or `a` tag with with class `ui label` using Semantic UI.
#'
#' @param ... Other arguments to be added such as content of the tag (text, icons) and/or attributes (style)
#' @param class class of the label. Look at https://semantic-ui.com/elements/label.html for all possibilities.
#' @param is_link If TRUE creates label with 'a' tag, otherwise with 'div' tag.
#' #'
#' @example inst/examples/label.R
#' @export
#'
#' @import shiny
label <- function(..., class = "", is_link = TRUE) {
  label_container <- if (is_link) tags$a else tags$div
  label_container(class = paste("ui label", class),
            list(...))
}

#' Sets tab id if not provided
#'
#' Sets tab id if it wasn't provided
#'
#' @param tab A tab. Tab is a list of three elements - first
#' element defines menu item, second element defines tab content, third optional element defines tab id.
set_tab_id <- function(tab) {
  id <- tab$id
  menu <- tab$menu
  content <- tab$content
  list(id = if (!is.null(id)) id else generate_random_id("tab"),
       menu = menu, content = content)
}

#' Create Semantic UI tabs
#'
#' This creates tabs with content using Semantic UI styles.
#'
#' @param tabs A list of tabs. Each tab is a list of three elements - first
#' element defines menu item, second element defines tab content, third optional element defines tab id.
#' @param active Id of the active tab. If NULL first tab will be active.
#' @param id Id of the menu element (default: randomly generated id)
#' @param menu_class Class for the menu element (default: "top attached
#' tabular")
#' @param tab_content_class Class for the tab content (default: "bottom attached
#' segment")
#'
#' @details You may access active tab id with `input$<id>_tab`.
#'
#' @export
#'
#' @example inst/examples/tabset.R
#'
tabset <- function(tabs,
                   active = NULL,
                   id = generate_random_id("menu"),
                   menu_class = "top attached tabular",
                   tab_content_class = "bottom attached segment") {
  id_tabs <- tabs %>% purrr::map(~ set_tab_id(.x))
  valid_ids <- id_tabs %>% purrr::map_chr(~ .x$id)
  active_tab <- if (!is.null(active)) active else valid_ids[1] # nolint
  script_code <- paste0(
    " $(document).on('shiny:sessioninitialized', function(event) {
        Shiny.onInputChange('", id, "_tab', '", active_tab, "');
      });
      // Code below is needed to trigger visibility on reactive Shiny outputs.
      // Thanks to that users do not have to set suspendWhenHidden to FALSE.
      var previous_tab;
      $('#", id, ".menu .item').tab({
        onVisible: function(target) {
          if (previous_tab) {
            $(this).trigger('hidden');
          }
          $(window).resize();
          $(this).trigger('shown');
          previous_tab = this;
          Shiny.onInputChange('", id, "_tab', $(this).attr('data-tab'))
        }
      });")
  shiny::tagList(
    shiny::div(id = id,
               class = paste("ui menu", menu_class),
               purrr::map(id_tabs, ~ {
                 class <- paste("item", if (.$id == active_tab) "active" else "") # nolint
                 shiny::a(class = class, `data-tab` = .$id, .$menu)
               })
    ),
    purrr::map(id_tabs, ~ {
      class <- paste("ui tab", tab_content_class,
                     if (.$id == active_tab) "active" else "") # nolint
      shiny::div(class = class, `data-tab` = .$id, .$content)
    }),
    shiny::tags$script(script_code)
  )
}

#' Create Semantic UI header
#'
#' This creates a header with optional icon using Semantic UI styles.
#'
#' @param title Header title
#' @param description Subheader text
#' @param icon Optional icon name
#'
#' @example inst/examples/header.R
#'
#' @export
header <- function(title, description, icon = NULL) {
  shiny::h2(class = "ui header",
            if (!is.null(icon)) icon(icon),
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
#' @example inst/examples/cards.R
#'
#' @export
cards <- function(..., class = "") {
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
#' @example inst/examples/card.R
#'
#' @export
card <- function(..., class = "") {
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
#' @example inst/examples/segment.R
#'
#' @export
segment <- function(..., class = "") {
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
#' @example inst/examples/form.R
#'
#' @export
form <- function(..., class = "") {
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
#' @example inst/examples/fields.R
#'
#' @export
fields <- function(..., class = "") {
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
#' @example inst/examples/field.R
#'
#' @export
field <- function(..., class = "") {
  shiny::div(class = paste("field", class), ...)
}

#' Create Semantic UI Message box
#'
#' @param header Header of the message box
#' @param content Content of the message box . If it is a vector, creates a list
#' of vector's elements
#' @param class class of the message. Look at
#' https://semantic-ui.com/collections/message.html for all possibilities.
#' @param icon_name If the message is of the type 'icon', specify the icon.
#' Look at http://semantic-ui.com/elements/icon.html for all possibilities.
#' @param closable Determines whether the message should be closable.
#' Default is FALSE - not closable
#'
#' @example inst/examples/message_box.R
#'
#' @export
message_box <- function(header, content, class = "", icon_name, closable = FALSE) {
  if (length(content) > 1) {
    content <- shiny::tags$ul(class = "list", lapply(content, shiny::tags$li))
  }
  if (grepl("icon", class)) {
    if (missing(icon_name)) {
      stop("If you give a class 'icon', then an icon_name argument is required")
    }
    icon_else_header <- icon(icon_name)
    message_else_content <- shiny::div(class = "content",
                                       shiny::div(class = "header", header),
                                       content)
  } else {
    icon_else_header <- shiny::div(class = "header", header)
    message_else_content <- content
  }
  div(class = paste("ui message", class),
      if (closable) {
        closable_messages <- "$('.message .close')
          .on('click', function() {
            $(this)
              .closest('.message')
              .transition('fade')
            ;
          })
        ;"
        icon("close icon", shiny::tags$script(shiny::HTML(closable_messages)))
      },
      icon_else_header,
      message_else_content)
}

#' Create Semantic UI Menu
#'
#' This creates a menu using Semantic UI.
#'
#' @param ... Menu items to be created. Use menu_item function to create new menu item.
#' Use dropdown_menu(is_menu_item = TRUE, ...) function to create new dropdown menu item.
#' Use menu_header and menu_divider functions to customize menu format.
#' @param class Class extension.Look at https://semantic-ui.com/collections/menu.html
#' for all possibilities.
#'
#' @rdname menu
#'
#' @example inst/examples/menu.R
#'
#' @export
menu <- function(..., class = "") {
  class <- paste("ui menu", class)
  div(class =  class,
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
#' @seealso menu
#' @export
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
#' @param class class of the dropdown. Look at https://semantic-ui.com/modules/dropdown.html for all possibilities.
#' @param name Unique name of the created dropdown.
#' @param is_menu_item TRUE if the dropdown is a menu item. Default is FALSE.
#' @param dropdown_specs A list of dropdown functionalities.
#' Look at https://semantic-ui.com/modules/dropdown.html#/settings for all possibilities.
#'
#' @example inst/examples/dropdown_menu.R
#'
#' @import shiny
#' @export
dropdown_menu <- function(..., class = "", name, is_menu_item = FALSE, dropdown_specs = list()) {

  if (missing(name)) {
    stop("Dropdown requires unique name. Specify \"name\" argument.")
  }

  unique_dropdown_class <- paste0("dropdown_name_", name)

  if (is_menu_item) {
    class <- paste("ui dropdown item", class, unique_dropdown_class)
  } else {
    class <- paste("ui dropdown", class, unique_dropdown_class)
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
#' @seealso menu
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
#' @seealso menu
#'
#' @export
#'
menu_divider <- function(...) {
  shiny::div(class = "divider", ...)
}

#' Helper function to render list element
#'
#' @param header character with header element
#' @param description character with content of the list
#' @param icon_name character with optional icon
#'
#' @import shiny
list_element <- function(header = NULL, description = NULL, icon_name = NULL) {
  div(class = "item",  if (!is.null(icon)) icon(icon_name) else "",
      div(class = "content",
          div(class = "header", header),
          div(class = "description", description))
  )
}

#' Create Semantic UI list with header, description and icons
#'
#' This creates a list with icons using Semantic UI
#'
#' @param content_list list of lists with fields: `header` and/or `description`,
#' `icon` containing the list items headers, descriptions (one of these is mandatory)
#' and icons. Icon column should contain strings with icon names available
#' here: https://fomantic-ui.com/elements/icon.html
#' @param is_divided If TRUE created list elements are divided
#'
#' @export
#' @import shiny
#' @import magrittr
#'
#' @example inst/examples/list_container.R
#'
list_container <- function(content_list, is_divided = FALSE) {
  divided_list <- ifelse(is_divided, "divided", "")
  list_class <- paste("ui", divided_list, "list")
  div(class = list_class,
      content_list %>% purrr::map(function(x) {
        if (is.null(x$header) && is.null(x$description))
          stop("content_list needs to have either header or description.")
        list_element(x$header, x$description, x$icon)
      })
  )
}


#' Accordion UI
#'
#' In accordion you may display a list of elements that can be hidden or
#' shown with one click.
#'
#' @param accordion_list list with lists with fields: `title` and `content`
#' @param fluid if accordion is fluid then it takes width of parent div
#' @param active_title if active title matches `title` from `accordion_list`
#' then this element is active by default
#' @param styled if switched of then raw style (no boxes) is used
#' @param custom_style character with custom style added to CSS of accordion (advanced use)
#'
#' @return shiny tag list with accordion UI
#' @export
#'
#' @example inst/examples/accordion.R
#'
accordion <- function(accordion_list, fluid = TRUE, active_title = "",
                      styled = TRUE, custom_style = "") {
  fluid <- ifelse(fluid, "fluid", "")
  styled <- ifelse(styled, "styled", "")
  accordion_class = glue::glue("ui {styled} {fluid} accordion")
  shiny::tagList(
    div(class = accordion_class, style = custom_style,
        accordion_list %>% purrr::map(function(x) {
          if (is.null(x$title) || is.null(x$content))
            stop("There must be both title and content fields in `accordion_list`")
          active <- ifelse(x$title == active_title, "active", "")
          shiny::tagList(
            div(class = paste("title", active), icon("dropdown"), x$title),
            div(class = paste("content", active),
                p(class = "transition hidden",
                  if (class(x$content) == "shiny.tag") x$content else div(x$content)
                )
            )
          )
        })
    ),
    shiny::tags$script(HTML(
      glue::glue("$('.ui.accordion').accordion();")
    ))
  )
}
