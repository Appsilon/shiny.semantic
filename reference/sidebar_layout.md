# Creates div containing children elements of sidebar panel

Creates div containing children elements of sidebar panel

Creates div containing children elements of main panel

Creates grid layout composed of sidebar and main panels

## Usage

``` r
sidebar_panel(..., width = 1)

main_panel(..., width = 3)

sidebar_layout(
  sidebar_panel,
  main_panel,
  mirrored = FALSE,
  min_height = "auto",
  container_style = "",
  area_styles = list(sidebar_panel = "", main_panel = "")
)

sidebarPanel(..., width = 6)

mainPanel(..., width = 10)

sidebarLayout(
  sidebarPanel,
  mainPanel,
  position = c("left", "right"),
  fluid = TRUE
)
```

## Arguments

- ...:

  Container's children elements

- width:

  Width of main panel container as relative value

- sidebar_panel:

  Sidebar panel component

- main_panel:

  Main panel component

- mirrored:

  If TRUE sidebar is located on the right side, if FALSE - on the left
  side (default)

- min_height:

  Sidebar layout container keeps the minimum height, if specified. It
  should be formatted as a string with css units

- container_style:

  CSS declarations for grid container

- area_styles:

  List of CSS declarations for each grid area inside

- sidebarPanel:

  same as `sidebar_panel`

- mainPanel:

  same as `main_panel`

- position:

  vector with position of sidebar elements in order sidebar, main

- fluid:

  TRUE to use fluid layout; FALSE to use fixed layout.

## Value

Container with sidebar and main panels

## Examples

``` r
if (interactive()){
  library(shiny)
  library(shiny.semantic)
  ui <- semanticPage(
    titlePanel("Hello Shiny!"),
    sidebar_layout(
      sidebar_panel(
        shiny.semantic::sliderInput("obs",
                                    "Number of observations:",
                                    min = 0,
                                    max = 1000,
                                    value = 500),
                                    width = 3
      ),
      main_panel(
        plotOutput("distPlot"),
        width = 4
      ),
      mirrored = TRUE
    )
  )
  server <- function(input, output) {
    output$distPlot <- renderPlot({
      hist(rnorm(input$obs))
    })
  }
  shinyApp(ui, server)
}
```
