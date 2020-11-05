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

if (interactive()){
  library(shiny)
  library(shiny.semantic)
  shinyApp(
    ui = semanticPage(
      grid(myGrid,
           container_style = "border: 1px solid #f00",
           area_styles = list(header = "background: #0099f9",
                              menu = "border-right: 1px solid #0099f9"),
           header = div(shiny::tags$h1("Hello CSS Grid!")),
           menu = checkbox_input("example", "Check me", is_marked = FALSE),
           main = grid(subGrid,
                       top_left = calendar("my_calendar"),
                       top_right = div("hello 1"),
                       bottom_left = div("hello 2"),
                       bottom_right = div("hello 3")
           ),
           right1 = div(
             toggle("toggle", "let's toggle"),
             multiple_checkbox("mycheckbox", "mycheckbox",
                               c("option A","option B","option C"))),
           right2 = div("right 2")
      )
    ),
    server = shinyServer(function(input, output) {})
  )
}
