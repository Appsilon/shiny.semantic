library(shiny)
library(shinyjs)
library(semanticui)
library(plotly)
library(leaflet)
library(magrittr)
library(quantmod)
library(rgdal)

source("traders.R")

jsCode <- "
  $('.ui.dropdown').dropdown({});
  $('.rating').rating('setting', 'clearable', true);
"

area <- readOGR("area.json", "OGRGeoJSON")

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
      menu(class = "ui three item menu",
           divMenuItem(img(src = "/images/logo-appsilon.png", style="width:135px")),
           menuItem("Settings"),
           menuItem("Log out")),
      breadcrumb(),
      div(class = "ui raised segment",
        plotlyOutput('traderPlot')
      ),
      div(class = "ui stackable grid",
          div(class = "five wide column",
            div(class = "ui raised segment",
                a(class="ui red ribbon label", "Map"),
                span("Büyük Tokaç, Turkey"),
                p(),
                leafletOutput("worldMap", height="250"))),
          div(class = "six wide column",
            div(class = "ui raised segment",
                a(class="ui red ribbon label", "Sattelite"),
                span("16th of July, 2016"),
                p(),
                img(src = "/images/red.png", style="width:360px"))),
          div(class = "five wide column",
            div(class = "ui raised segment",
                a(class="ui red ribbon label", "Business insights"),
                p(),
                div(class="ui red icon message", uiicon("angle down"), "-12% of corn yield year to year."),
                div(class="ui blue icon message", uiicon("angle right"), "No drought risks. Wetness correct."),
                div(class="ui green icon message", uiicon("angle up"), "107% of expected rice efficiency.")
                )))
    )
  ))
}


server <- shinyServer(function(input, output) {
  output$traderPlot <- renderPlotly(traders)

  output$worldMap <- renderLeaflet({
    center <- colMeans(area@polygons[[1]]@Polygons[[1]]@coords)
    leaflet() %>%
      setView(lng = center[1], lat = center[2], zoom = 12) %>%
      addProviderTiles("CartoDB.Positron") %>%
      addPolygons(data = area, color = "red")
  }
  )
  runjs(jsCode)
})
shinyApp(ui = ui(), server = server)

