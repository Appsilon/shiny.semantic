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
               shiny::div(class = "menu",
                          purrr::map2(choices, choices_value, ~
                                        div(class = "item", `data-value` = .y, .x)
                          )
               )
    ),
    shiny::tags$script(paste0(
      "$('.ui.dropdown.", unique_dropdown_class,
      "').dropdown().dropdown('set selected', '", value, "');"
    ))
  )
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
    shiny::tags$script(paste0(
      "/* Code below is needed to trigger visibility on reactive Shiny outputs. */
       /* Thanks to that users do not have to set suspendWhenHidden to FALSE.   */
       var previous_tab;
       $('#", id, ".menu .item').tab({
       onVisible: function(target) {
         if (previous_tab) {
          $(this).trigger('hidden');
         }
       $(window).resize();
       $(this).trigger('shown');
       previous_tab = this;}});"))
  )
}

generate_random_id <- function(prefix, id_length = 20) {
  random_id <- paste(sample(letters, id_length, replace = TRUE), collapse = "")
  paste0(prefix, "-", random_id)
}

#' Create Semantic UI Message
#'
#' This creates a message using Semantic UI
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
