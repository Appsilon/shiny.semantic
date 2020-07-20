library(shiny)
library(shiny.semantic)
library(glue)

default_grid_template <- grid_template(default = list(
  areas = rbind(c("row1"), c("row2")),
  rows_height = c("auto"),
  cols_width = c("1fr")
))

# Sidebar Panel ................................................................

sidebar_panel <- function(..., width = 25) {
  # args <- list(...)

  container_style <- "align-content: start;"

  grid(
    default_grid_template,
    container_style,
    row1 = "sidebar panel test row",
    row2 = "sidebar panel test row"
  )
}

# Main Panel ...................................................................

main_panel <- function(...) {
  # args <- list(...)

  container_style <- "align-content: start;"

  grid(
    default_grid_template,
    container_style,
    row1 = "main panel test row",
    row2 = "main panel test row"
  )
}

# Sidebar Layout ...............................................................

sidebar_layout <- function(sidebar_panel,
                          main_panel,
                          sidebar_width,
                          mirrored = FALSE,
                          min_height = "auto") {

  if (!mirrored) {
    layout <- grid_template(default = list(
      areas = rbind(c("sidebar_panel", "main_panel")),
      rows_height = c("auto"),
      cols_width = c(glue::glue("{sidebar_width}%"), "1fr")
    ))
  } else {
    layout <- grid_template(default = list(
      areas = rbind(c("main_panel", "sidebar_panel")),
      rows_height = c("auto"),
      cols_width = c("1fr", glue::glue("{sidebar_width}%"))
    ))
  }

  container_style <- glue::glue("
    align-content: start;
    border: 2px dotted black;
    height: auto;
    min-height: {min_height};
  ")

  area_styles <- list(
    sidebar_panel = "",
    main_panel = ""
  )

  grid(
    layout,
    container_style,
    area_styles,
    sidebar_panel = sidebar_panel,
    main_panel = main_panel
  )
}

# UI ...........................................................................
ui <- function() {
  shinyUI(semanticPage(
    title = "Sidebar Layout Test",
    theme = "spacelab",
    sidebar_layout(
      sidebar_panel("Side Item 1", "Side Item 2", "Side Item 3"),
      main_panel("Main 1", "Main 2", "Main 3", "Main 4"),
      sidebar_width = 30,
      min_height = "400px",
      mirrored = FALSE
    )
  ))
}

# SERVER .......................................................................
server <- shinyServer(function(input, output) {})
shinyApp(ui = ui(), server = server)
