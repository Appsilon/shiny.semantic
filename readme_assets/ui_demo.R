library(shiny)
#devtools::install_github("Appsilon/shiny.semantic")
library(shiny.semantic)

jsCode <- "
$('.ui.dropdown').dropdown({});
$('.rating').rating('setting', 'clearable', true);
$('.disabled .rating').rating('disable');
"
before_ui_demo <- function() {
  fluidPage(
    title = "ui",
    div(style="margin-left: 20px; background: white",
        div(
          div(
            a("Client's info"),
              p(),
              shiny::tags$table(
                shiny::tags$tbody(
                  shiny::tags$tr( shiny::tags$td("Name"), shiny::tags$td("John Smith") ),
                  shiny::tags$tr( shiny::tags$td("City"), shiny::tags$td("Warsaw, Poland") )
                )
              ))
        )
    )
  )
}

after_ui_demo <- function() {
  semanticPage(
    title = "ui",
    shinyjs::useShinyjs(),
    div(class="ui grid", style="margin-left: 20px",
      div(class="column",
        div(class = "ui raised segment",
        a(class="ui green ribbon label", "Client's info"),
        p(),
        shiny::tags$table(
          style = "ui very basic collapsing celled table",
          shiny::tags$tbody(
            shiny::tags$tr( shiny::tags$td("Name"), shiny::tags$td("John Smith") ),
            shiny::tags$tr( shiny::tags$td("City"), shiny::tags$td("Warsaw, Poland") )
          )
        ))
      )
    )
  )
}


