library(shiny)
library(shiny.semantic)
library(glue)

# sidebar
semanticSidebar <- function(sidebarPanel,
                            mainPanel,
                            position = c("left", "right"),
                            fluid = TRUE) {
  position <- match.arg(position)
  if (position == "left") {
    firstPanel <- sidebarPanel
    secondPanel <- mainPanel
  }
  else if (position == "right") {
    firstPanel <- mainPanel
    secondPanel <- sidebarPanel
  }
  if (fluid)
    fluidRow(class = "sem-fluid", firstPanel, secondPanel)
  else
    fixedRow(class = "sem-fixed", firstPanel, secondPanel)
}

# panel
semanticSidebarPanel <- function(..., width = 4) {
  div(style = glue("flex-grow: {width}"),
      tags$form(class = "well",
                ...))
}

# main
semanticMainPanel <- function(..., width = 8) {
  div(style = glue("flex-grow: {width}"),
      ...)
}


ui <- function() {
  shinyUI(semanticPage(

    tags$head(
      tags$style(HTML("

      .sem-fluid {
        border: 1px solid black;
        display: flex;
      }

      .sem-row {

      }

    "))
    ),

    semanticSidebar(
      semanticSidebarPanel("sidebar",
                           width = 10),
      semanticMainPanel("main",
                        width = 7),
      position = "left",
      fluid = TRUE
    )
  ))
}

server <- shinyServer(function(input, output) {
})

shinyApp(ui = ui(), server = server)
