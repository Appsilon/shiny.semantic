suppressWarnings(library(shiny))
suppressWarnings(library(magrittr))

table_data <- data.frame(
  Name = c("John Smith", "Lindsay More"),
  City = c("Warsaw, Poland", "SF, United States"),
  Revenue = c("$210.50", "$172.78"))

before_ui_demo <- function() {
  fluidPage(
    title = "ui",
    div(style = "margin-left: 20px; background: white",
        div(
          div(
            a("Client's info"),
            p(),
            HTML(renderTable(table_data)())
          )
        )
    )
  )
}

after_ui_demo <- function() {
  semanticPage(
    title = "ui",
    div(class = "ui raised segment", style="margin-left: 20px; max-width: 350px; width: 100%",
      a(class="ui green ribbon label", "Client's info"),
      p(),
      xtable::xtable(table_data) %>%
        print(html.table.attributes="class = 'ui very basic collapsing celled table'",
          type = "html", include.rownames = F, print.results = F) %>%
        HTML
    )
  )
}


