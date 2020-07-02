library(shiny)
library(shiny.semantic)
library(glue)

numbers <- c("one", "two", "three", "four", "five", "six", "seven", "eight",
             "nine", "ten", "eleven", "twelve", "thirteen", "fourteen",
             "fifteen", "sixteen")

get_row <- function(arg) {
  class <- "row"
  style <- "padding: 20px;"
  HTML(glue::glue("<div class='{class}' style='{style}'>{arg}</div>"))
}

get_width <- function(percent) {
  width <- round(percent / 100 * 16, digits = 0)
  width <- min(15, max(1, width))
}

# sidebar panel.................................................................
sidebar_panel <- function(..., width = 25) {
  args <- list(...)
  style <- "padding: 20px;"
  width <- numbers[get_width(width)]
  div(
    class = glue::glue("{width} wide column center aligned grey"),
    style = style,
    lapply(args, get_row)
  )
}





# main panel....................................................................
main_panel <- function(...) {
  args <- list(...)
  style <- "flex-grow: 1"
  div(
    class = glue::glue("column center aligned"),
    style = style,
      lapply(args, get_row)
  )
}



# sidebar layout................................................................
sidebar_layout <- function(sidebar_panel,
                           main_panel,
                           mirrored = FALSE,
                           min_height = "auto") {
  class <- "ui celled relaxed grid divided"
  style <- glue::glue("min-height: {min_height};")
  if (mirrored) {
    div(class = class, style = style, main_panel, sidebar_panel)
  } else {
    div(class = class, style = style, sidebar_panel, main_panel)
  }
}





#...............................................................................
ui <- function() {
  shinyUI(semanticPage(
    title = "Sidebar Layout Test",
    theme = "spacelab",
    sidebar_layout(
      sidebar_panel("Side Item 1", "Side Item 2", "Side Item 3", width = 20),
      main_panel("Main 1", "Main 2", "Main 3", "Main 4"),
      mirrored = FALSE,
      min_height = "400px"
    )
  ))
}
#...............................................................................
server <- shinyServer(function(input, output) {})
shinyApp(ui = ui(), server = server)
