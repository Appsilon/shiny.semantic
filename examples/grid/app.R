library(shiny)
library(shiny.semantic)

myGrid <- grid_template(default = list(
  areas = rbind(
    c("header", "header", "header"),
    c("menu",   "main",   "right1"),
    c("menu",   "main",   "right2")
  ),
  rows_height = c("50px", "auto", "100px"),
  cols_width = c("100px", "2fr", "1fr")
))

subGrid <- grid_template(default = list(
  areas = rbind(
    c("top_left", "top_right"),
    c("bottom_left", "bottom_right")
  ),
  rows_height = c("50%", "50%"),
  cols_width = c("50%", "50%")
))

ui <- semanticPage(
  grid(myGrid,
       container_style = "border: 5px solid #3d7ea6",
       area_styles = list(header = "border-bottom: 3px solid #5c969e",
                          menu = "border-right: 3px solid #5c969e",
                          main = "border-right: 3px solid #5c969e",
                          right1 = "border-bottom: 3px solid #5c969e"),
       header = div(shiny::tags$h1("Hello CSS Grid!")),
       menu = div("menu"),
       main = grid(subGrid,
                   container_style = "padding: 5px;",
                   area_styles = list(top_left = "border: 3px solid #ffa5a5;",
                                      top_right = "border: 3px solid #ffa5a5;",
                                      bottom_left = "border: 3px solid #ffa5a5;",
                                      bottom_right = "border: 3px solid #ffa5a5;"),
                   top_left = div("main top left"),
                   top_right = div("main top right"),
                   bottom_left = div("main bottom left"),
                   bottom_right = div("main bottom right")
       ),
       right1 = div("right 1"),
       right2 = div("right 2")
  )
)

server <- function(input, output, session) {
}

shinyApp(ui = ui, server = server)
