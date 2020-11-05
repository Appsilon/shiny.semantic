if (interactive()) {
  library(shiny)
  library(shiny.semantic)
  accordion_content <- list(
    list(title = "AA", content = h2("a a a a")),
    list(title = "BB", content = p("b b b b"))
  )
  shinyApp(
    ui = semanticPage(
      accordion(accordion_content, fluid = F, active_title = "AA",
                custom_style = "background: #babade;")
    ),
    server = function(input, output) {}
  )
}
