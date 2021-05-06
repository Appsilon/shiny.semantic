library(shiny)
library(shiny.semantic)

ui <- navbar_page(
  title = "Hello Shiny Semantic!",
  tab_panel(
    "Content",
    tags$label("Number of observations:"),
    slider_input("obs", value = 500, min = 0, max = 1000),
    segment(
      plotOutput("dist_plot")
    )
  ),
  tab_panel(
    "Icon", icon = "r project",
    "A tab with an icon in the menu"
  ),
  tab_panel(
    "A Very Long Tab Name",
    "Example of a tab name which is very long",
    dropdown_input("letters", LETTERS)
  ),
  navbar_menu(
    "Menu",
    "Section 1",
    tab_panel("Part 1", h3("Section 1 - Part 1"), value = "sec1_part1"),
    "----",
    "Section 2",
    tab_panel("Part 1", h3("Section 2 - Part 1"), value = "sec2_part1"),
    tab_panel("Part 2")
  )
)

server <- function(input, output) {
  output$dist_plot <- renderPlot({
    hist(rnorm(input$obs))
  })
}

shinyApp(ui, server)
