library(shiny)
library(shinyjs)
library(shiny.semantic)
library(plotly)
library(leaflet)
library(magrittr)
library(mosaic)
library(quantmod)
library(tidyr)
library(chartjs)
library(DT)
library(visNetwork)

input <- function(class = "ui input", style = "", type = "text", name = "", placeholder = "") {
  div(class = class, style = style,
      tags$input(type = type, name = name, placeholder = placeholder)
  )
}

menu <- function(class = "ui item menu", ...) {
  div(class = class, ...)
}

menuItem <- function(..., class = "item") {
  tags$a(class = class, ...)
}
divMenuItem <- function(content, class = "item") {
  div(class = class, content)
}
img <- function(src, ...) {
  tags$img(src = src, ...)
}

jsCode <- "
$('.ui.dropdown').dropdown({});
$('.rating').rating('setting', 'clearable', true);
"

cities <- read.csv("worldcities.csv")

breadcrumb <- function() {
  div(class="ui huge breadcrumb", style="background: transparent",
      a(class="section", "Portfolio"),
      div(class="divider", "/"),
      a(class="section", "Agriculture"),
      div(class="divider", "/"),
      a(class="section", "Rice")
  )
}

userCard <- function() {
  div(class = "ui card",
    div(class = "content",
      div(class = "right floated meta", "7 minutes ago"),
      img(class = "ui avatar image", src = "images/elliot.jpg"),
      "John Smith"),
    div(class = "content",
      a(class="header", "Top indicators"),
      div(class="ui divided list",
       div(class="item",
         uiicon('large green plus middle aligned'),
         div(class="content",
           a(class="header", "Strong network"),
           div(class="description", "Healthy user network")
         )
       ),
       div(class="item",
         uiicon('large green plus middle aligned'),
         div(class="content",
           a(class="header", "Social media"),
           div(class="description", "Profiles authentic and reliable")
         )
       ),
       div(class="item",
         uiicon('large green plus middle aligned'),
         div(class="content",
           a(class="header", "Location"),
           div(class="description", "Regular user location (work)")
         )
       ),
       div(class="item",
         uiicon('large red minus middle aligned'),
         div(class="content",
           a(class="header", "Short transactions history"),
           div(class="description", "User performed less transactions than average")
         )
       )
      )
    ),
    div(class="extra content",
      "Positive indicators"
    )
  )
}

ui <- function() {
  shinyUI(semanticPage(
    style="min-height: 100%; background: black",
    useShinyjs(),
        menu(class = "ui four item inverted menu",
             divMenuItem(img(src = "images/logo-appsilon.png", style="width:135px")),
             menuItem("Clients data"),
             menuItem("Settings"),
             menuItem("Log out")),
        div(class = "ui two column grid",
            style = "height: 100%",
            div(class = "column",
                div(class = "ui raised inverted segment",
                    leafletOutput("worldMap", height="800")
                )),
            div(class = "column",
                div(class = "ui raised segment",
                    a(class="ui red ribbon label", "Manual review"),
                    shiny::tags$span("Transaction data"),
                    p(),
                    div(class = "ui grid",
                        div(class = "eight wide column",
                          div(class = "ui horizontal divider", uiicon("users"), "Network"),
                          visNetworkOutput("network", height = "200px"),
                          div(class = "ui horizontal divider", uiicon("tag"), "Transactions"),
                          DT::dataTableOutput("transactionRadarSummary")
                        ),
                        div(class = "eight wide column",
                          userCard(),
                          div(class = "ui horizontal divider", uiicon("user"), "Profile"),
                          div(chartjsOutput("transactionRadar", width="400px", height="300px")),
                          p()
                          )
                      ),
                    div(class="ui two bottom attached buttons",
                      div(class = "ui red basic button", uiicon("user"), "Reject"),
                      div(class = "ui green basic button", uiicon("user"), "Approve")
                    )
                  )
                )
            )
  ))
}


addFlights <- function(map, flights) {
  for(i in 1:nrow(flights)) {
    from <- cities[flights[i, 1],] %>% { c(.$longitude, .$latitude) }
    to <- cities[flights[i, 2],] %>% { c(.$longitude, .$latitude) }

    route <- geosphere::gcIntermediate(from, to, n=100, addStartEnd=T, sp=T, breakAtDateLine=T)
    map <- map %>%
      leaflet::addPolylines(data = route, color = "#fff", fillOpacity = 0.7, weight = 2)
  }

  map
}


server <- shinyServer(function(input, output) {
  airports <- reactive({
    do(10) * sample(1:nrow(cities), 3)
  })

  output$worldMap <- renderLeaflet({
    airports <- airports()
    leaflet() %>%
      addCircleMarkers(data = cities[airports %>% unlist,], radius = 1, color="white") %>%
      addFlights(airports %>% tidyr::gather(V1) %>% .[, c(1,3)]) %>%
      addProviderTiles("CartoDB.DarkMatter")
  })

  output$transactionRadar <- renderChartjs({
    chartjs(height = "200px") %>%
      cjsRadar(labels = c("Social media", "History", "Location", "Device", "Network")) %>%
      cjsSeries(label="John Smiths", data = c(6, 7, 8, 5, 9)) %>%
      cjsSeries(label="Recommended", data = c(4, 8, 5, 6, 4)) %>%
      cjsEditScale(axis = NULL, ticks = list(beginAtZero = TRUE)) %>%
      cjsLegend
  })
  output$transactionRadarSummary <- DT::renderDataTable({
    frame <- data.frame(date = as.Date(c("2016/07/16","2016/07/25","2016/08/03")),
                        spendings = c(127.78, 1000.00, 17.83))
    datatable(frame, options = list(pageLength = 5))
  })
  output$network <- renderVisNetwork({
    nodes <- data.frame(id = 1:10, color="#f6f6f6")
    edges <- data.frame(from = round(runif(15)*10), to = round(runif(15)*10))

    visNetwork(nodes, edges)
  })

  runjs(jsCode)
})
shinyApp(ui = ui(), server = server)
