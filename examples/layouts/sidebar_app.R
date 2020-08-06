library(shiny)
library(shiny.semantic)

grid_cell_style = "
  align-items: center;
  border: 1px solid #ccc;
  display: flex;
  justify-content: center;
"

ui <- function() {
  shinyUI(semanticPage(
    title = "Sidebar Layout Test",
    sidebar_layout(
      sidebar_panel(
        width = 1,
        h1("Hello shiny.semantic!"),
        sliderInput("obs1", "Select value A:", min = 0, max = 800, value = 200),
        sliderInput("obs2", "Select value B:", min = 0, max = 1000, value = 400),
        sliderInput("obs3", "Select value C:", min = 0, max = 600, value = 500),
        sliderInput("obs4", "Select value D:", min = 0, max = 700, value = 300)
      ),
      main_panel(
        width = 2,
        h2("Selected values:"),
        grid(
          grid_template = grid_template(default = list(
            areas = rbind(
              c("top_left", "top_right"),
              c("bottom_left", "bottom_right")
            ),
            cols_width = c("1fr", "1fr"),
            rows_height = c("1fr", "1fr")
          )),
          container_style = "gap: 10px;",
          area_styles = list(
            top_left = grid_cell_style,
            top_right = grid_cell_style,
            bottom_left = grid_cell_style,
            bottom_right = grid_cell_style
          ),
          top_left = h3(textOutput("obs1")),
          top_right = h3(textOutput("obs2")),
          bottom_left = h3(textOutput("obs3")),
          bottom_right = h3(textOutput("obs4")),
        ),
        p("Have a nice day!")
      ),
      min_height = "400px",
      mirrored = FALSE,
      container_style = "background-color: white;",
      area_styles = list(
        sidebar_panel = "border: 1px solid #888;",
        main_panel = "border: 1px solid #ccc;"
      )
    )
  ))
}

server <- shinyServer(function(input, output) {
  output$obs1 <- renderText({ glue::glue("Value A: {input$obs1}") })
  output$obs2 <- renderText({ glue::glue("Value B: {input$obs2}") })
  output$obs3 <- renderText({ glue::glue("Value C: {input$obs3}") })
  output$obs4 <- renderText({ glue::glue("Value D: {input$obs4}") })
})

shinyApp(ui = ui(), server = server)
