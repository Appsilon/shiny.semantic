library(shiny)
library(shiny.semantic)

ui <- navbar_page(
  title = "Hello Shiny Semantic!",
  # id = "page_navbar",
  collapsible = TRUE,

  tab_panel(
    title = "Content",
    numeric_input("obs", "Number of observations:", value = 500, min = 0, max = 1000),
    segment(plotOutput("dist_plot"))
  ),
  tab_panel(
    title = "Icon",
    icon = "r project",
    "A tab with an icon in the menu"
  ),
  tab_panel(
    title = "A Very Long Tab Name",
    "Example of a tab name which is very long",
    form(field(tags$label("Test dropdown"), dropdown_input("letters", LETTERS))),
    segment("Letter chosen:", textOutput("letter", inline = TRUE))
  ),
  navbar_menu(
    "Menu",
    "Section 1",
    tab_panel(
      title = "Part 1",
      value = "sec1_part1",
      segment("Number chosen:", textOutput("number", inline = TRUE))
    ),
    "----",
    "Section 2",
    tab_panel(
      title = "Part 1",
      value = "sec2_part1",
      h3("Section 2 - Part 1")
    ),
    tab_panel(
      title = "Part 2"
    )
  )
)

server <- function(input, output) {
  output$dist_plot <- renderPlot({
    hist(rnorm(input$obs))
  })

  output$letter <- renderText(input$letters)
  output$number <- renderText(input$obs)
}

shinyApp(ui, server)
