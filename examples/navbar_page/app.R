library(shiny)
library(shiny.semantic)

ui <- navbar_page(
  title = "Hello Shiny Semantic!",
  id = "page_navbar",
  collapsible = TRUE,

  tab_panel(
    title = "Content",
    value = "content",
    form(multiple_radio("toggle", "Show Menu Dropdown", c("Yes", "No"), c("show", "hide"), "show"))
  ),
  tab_panel(
    title = "Icon",
    value = "icon",
    icon = "r project",
    "A tab with an icon in the menu",
  ),
  tab_panel(
    title = "A Very Long Tab Name",
    value = "long_tab_name",
    "Example of a tab name which is very long",
    tags$br(),
  ),
  navbar_menu(
    "Menu",
    "Section 1",
    tab_panel(
      title = "Part 1",
      value = "sec1_part1",
    ),
    "----",
    "Section 2",
    tab_panel(
      title = "Part 1",
      value = "sec2_part1",
      h3("Section 2 - Part 1")
    ),
    tab_panel(
      title = "Part 2",
      value = "sec2_part2"
    )
  )
)

server <- function(input, output, session) {
  observeEvent(input$toggle, {
    if (input$toggle == "hide") {
      hide_tab(session, "page_navbar", target = "Menu")
    } else {
      show_tab(session, "page_navbar", target = "Menu")
    }
  }, ignoreInit = TRUE)
}

shinyApp(ui, server)
