library(shiny)
library(shinyjs)
library(semanticui)
library(plotly)
library(leaflet)
library(magrittr)
library(mosaic)
library(quantmod)
library(tidyr)
library(chartjs)
library(DT)
library(visNetwork)

options(shiny.maxRequestSize = 100 * 1024^2)

jsCode <- "
$('.ui.dropdown').dropdown({});
$('.rating').rating('setting', 'clearable', true);
$('.disabled .rating').rating('disable');
"

ui <- function() {
  shinyUI(semanticPage(
    style="min-height: 100%;",
    useShinyjs(),
    menu(class = "ui four item menu",
         divMenuItem(img(src = "/images/logo-appsilon.png", style="width:135px")),
         menuItem(uiicon("hourglass end"), "Pending actions"),
         menuItem(uiicon("settings"), "Settings"),
         menuItem(uiicon("user"), "Log out")),
    div(class = "ui three column grid", style = "height: 100%; width: 90%; margin: auto",
        div(class = "column",
            div(class = "ui raised segment",
                a(class="ui green ribbon label", "Client's info"),
                p(), p(),
                shiny::tags$table(class="ui very basic collapsing celled table",
                  shiny::tags$tbody(
                    shiny::tags$tr( shiny::tags$td("Name"), shiny::tags$td("John Smiths") ),
                    shiny::tags$tr( shiny::tags$td("City"), shiny::tags$td("Warsaw, Poland") ),
                    shiny::tags$tr( shiny::tags$td("Client since"), shiny::tags$td("07/2014") ),
                    shiny::tags$tr( shiny::tags$td("Our rating"), shiny::tags$td(
                       div(class="disabled",
                        div(class="ui star rating", 'data-rating'="4", 'data-max-rating'="5")
                       )
                    ) ),
                    shiny::tags$tr( shiny::tags$td("Monthly spendings"), shiny::tags$td("$2500 aprox.") )
                  ))
            ),
            div(class = "ui raised segment",
                a(class="ui green ribbon label", "Calls history"),
                p(), p(),
                DT::dataTableOutput("callsHistory")
            )
        ),
        div(class = "column",
          div(class="ui cards",
            div(class="ui centered red card",
              div(class="content",
                  div(class="header", "Convert to 'Pay as you go' plan"),
                  div(class="meta", "Estimated reduction"),
                  div(class="description", "33% cost reduction based on historical data")
                  ),
                div(class="ui white bottom attached button", uiicon("add"), "Proceed")
            ),
            div(class="ui centered yellow card",
              div(class="content",
                  div(class="header", "Offer health insurance"),
                  div(class="meta", "Upselling opportunity"),
                  div(class="description", "Clients of following profile are 2 times more likely to accept our health insurance plan")
                  ),
                div(class="ui white bottom attached button", uiicon("add"), "Proceed")
            ),
            div(class="ui centered green card",
              div(class="content",
                  div(class="header", "Sell credit card for spouse"),
                  div(class="meta", "Upselling opportunity"),
                  div(class="description", "Accounts used by familiy members are likely to accept additional card and increase number of transactions.")
                  ),
                div(class="ui white bottom attached button", uiicon("add"), "Proceed")
            )
          )
        ),
        div(class = "column",
            div(class = "ui raised segment",
                a(class="ui blue ribbon label", "Current call"),
                p(),
                div(class="ui huge center aligned header", style="font-size: 5em", "05:37"),
                div(class = "ui horizontal divider", "Emotions"),
                div(
                  C3::C3GaugeOutput("emotionsGauge", width = "100%", height = "150px")
                ),
                div(class="ui center aligned header", "Voice analysis: Interested"),

                div(class = "ui horizontal divider", "Feedback"),

                h5(class="ui header", "Score client: "), div(class="ui star rating", 'data-max-rating'="5"),
                h5(class="ui header", "Churn risk - your feelings: "), div(class="ui rating", 'data-max-rating'="5")
            )
        )
    )
  )
  )
}

server <- shinyServer(function(input, output) {
  runjs(jsCode)
  output$emotionsGauge <- C3::renderC3Gauge({
    C3::C3Gauge(76)
  })
  output$callsHistory <- DT::renderDataTable({
    DT::datatable(data.frame(
      Date = Sys.Date() + sort(sample(1:100, 4)),
      Topic = c("Connection problem", "New plan", "Resume services", "Suspension of service"),
      Consultant = c("Kate Lees", "You", "Mike Bradley", "Kate Lees")
    ))
  })
})

shinyApp(ui = ui(), server = server)
