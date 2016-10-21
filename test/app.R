library(shiny)
library(shinyjs)
library(semanticui)
library(plotly)
library(leaflet)
library(magrittr)
library(quantmod)

source("traders.R")

jsCode <- "
  $('.ui.dropdown').dropdown({});
  $('.rating').rating('setting', 'clearable', true);
"

ratedPlot <- function(name) {
  div(class = "ui raised segment",
    input(placeholder ="Filip"),
    plotlyOutput(name),
    div(class = "ui star rating")
  )
}
ratedMap <- function(name) {
  div(class = "ui raised segment",
    input(placeholder ="Filip"),
    leaflet::leafletOutput(name),
    div(class = "ui star rating")
  )
}
card <- function(content) {
  div(class="ui card",
    div(class="content",
      div(class="right floated meta", "14h"),
      img(class="ui avatar image", src="images/elliot.jpg"),
      "Elliot"
    ),
    content,
    div(class="content",
      span(class="right floated", uiicon("heart outline like"), "17 likes"),
      uiicon("comment"),
      "3 comments"
    ),
    div(class="extra content",
      div(class="ui large transparent left icon input",
        uiicon("heart ouline"),
        tags$input(type="text", placeholder ="Add Comment...")
      )
    )
  )
}

breadcrumb <- function() {
  div(class="ui huge breadcrumb", style="background: transparent",
    a(class="section", "Portfolio"),
    div(class="divider", "/"),
    a(class="section", "Agriculture"),
    div(class="divider", "/"),
    a(class="section", "Rice")
  )
}

ui <- function() {
  shinyUI(semanticPage(
    useShinyjs(),
    div(class="ui container",
      menu(class = "ui item menu",
           divMenuItem(img(src = "/images/logo-appsilon.png", style="width:135px")),
           menuItem("Settings"),
           menuItem("Log out")),
      breadcrumb(),
      div(class = "ui raised segment",
        plotlyOutput('traderPlot')
      ),
      div(class = "ui raised segment",
        div(class = "ui button", "Follow"),
        div(class = "ui basic button", "Add friend"),
        div(class = "ui basic button", uiicon("user"), "Add friend"),
        div(class = "ui red basic button", uiicon("user"), "Remove friend"),
        div(class = "ui olive basic button", uiicon("user"), "Remove friend"),
        div(class = "ui teal basic button", uiicon("user"), "Remove friend"),
        div(class = "ui brown basic button", uiicon("user"), "Remove friend")
      ),
      div(class = "ui raised segment",
        div(class="ui cards",
          card(div(class="image", img(src="/images/wireframe.png"))),
          card(leafletOutput("sampleMap2", height=240))
        )
      ),
      div(class="ui stackable two column grid",
        div(class="column", ratedPlot("samplePlot")),
        div(class="column", ratedMap("sampleMap"))
      )
    )
  ))
}

server <- shinyServer(function(input, output) {
  output$samplePlot <- renderPlotly({
    plot_ly(mtcars, x = ~mpg, y = ~wt)
  })

  points <- cbind(rnorm(40) * 2 + 13, rnorm(40) + 48)

  output$traderPlot <- renderPlotly(traders)
  output$sampleMap <- renderLeaflet({
    leaflet() %>%
      addProviderTiles("CartoDB.Positron",
         options = providerTileOptions(noWrap = TRUE)
      ) %>%
      addMarkers(data = points)
  })
  output$sampleMap2 <- renderLeaflet({
    leaflet() %>%
      addProviderTiles("CartoDB.Positron",
         options = providerTileOptions(noWrap = TRUE)
      ) %>%
      addMarkers(data = points)
  })
  runjs(jsCode)
})
shinyApp(ui = ui(), server = server)

