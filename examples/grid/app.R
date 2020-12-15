library(shiny)
library(shiny.semantic)

# Here we define the grid_template that we will pass to our grid
myGrid <- grid_template(
  default = list(
    # Here we define the data.frame describing our layout
    # The easiest way is to use rbind so that the layout can be 'visualized' in code
    areas = rbind(
      c("header", "header", "header"),
      c("menu",   "main",   "right1"),
      c("menu",   "main",   "right2")
    ),
    # Then we define the dimensions of the different elements of the layout
    # We can use any valid css units to make the layout behave exactly as desired
    rows_height = c("50px", "auto", "100px"),
    cols_width = c("100px", "2fr", "1fr")
  ),
  # This is optional, but we can define a specific layout for mobile (screen width below 768px)
  mobile = list(
    areas = rbind(
      c("header", "header", "header"),
      c("menu",   "main",   "right1"),
      c("menu",   "main",   "right2")
    ),
    rows_height = c("50px", "2fr", "1fr"), # Notice how we changed the rows heights here
    cols_width = c("100px", "2fr", "1fr")
  )
)

# We can use nested grids to precisely control the layout of all the elements
# Here we define another grid_template to use in one of the elements of the parent grid
subGrid <- grid_template(
  default = list(
    areas = rbind(
      c("top_left", "top_right"),
      c("bottom_left", "bottom_right")
    ),
    rows_height = c("50%", "50%"),
    cols_width = c("50%", "50%")
  ),
  # This is optional, but we can define a specific layout for mobile (screen width below 768px)
  mobile = list(
    areas = rbind(
      c("top_left"),
      c("top_right"),
      c("bottom_left"),
      c("bottom_right")
    ),
    rows_height = c("25%", "25%", "25%", "25%"),
    cols_width = c("100%")
  )
)

ui <- semanticPage(
  grid(myGrid,
       # We can define the css style of the grid using container_style
       container_style = "border: 5px solid #3d7ea6",
       # We can define the css style of each of the grid elements using area_styles
       area_styles = list(header = "border: 3px solid #5c969e",
                          menu = "border: 3px solid #5c969e",
                          main = "border: 3px solid #5c969e",
                          right1 = "border: 3px solid #5c969e",
                          right2 = "border: 3px solid #5c969e"),
       # Finally, we define the ui content we would like to have inside each element
       header = div(shiny::tags$h1("Hello CSS Grid!")),
       menu = div("menu"),
       main = grid(subGrid,
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
