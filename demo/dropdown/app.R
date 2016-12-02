library(shiny)
library(shinyjs)
library(semanticui)
library(magrittr)

js_code <- "
$( document ).ready(function() {
  $('.ui.dropdown').dropdown();
});"

customer_input <- function(input) {
  name <- "customer"
  print("customer input")
  val <- input[[name]]
  val <- jsonlite::fromJSON(ifelse(is.null(val), '""', val))
  print(val)

  div(class = "ui selection dropdown",
    semanticui::shiny_input(name,
      shiny::tags$input(type = "hidden", name = "customer"),
      value = val
    ),
    tags$script(paste0("$('.ui.dropdown').dropdown('set selected', '", val,"');")),
    uiicon("dropdown"),
    div(class = "default text", "Select customer"),
    div(class = "menu", 1:4 %>% purrr::map(~ div(class = "item", .)) %>% shiny::tagList() )
  )
}

ui <- shinyUI(semanticPage(
  title = "Dropdown demo",
  useShinyjs(),
  div(class = "ui container",
    shiny::actionButton("click", label = "toggle"),
    uiOutput("reactive_ui")
  ),
  textOutput("out")
))

normal_input <- function(input) {
  name <- "normalSelect"
  shiny::selectInput(name, "Normal", 1:5, selected = input[[name]])
}

mem_input <- function(name, input) {
  prev_value <- input[[name]]
  shiny::selectInput(name, "mem", 1:5, selected = prev_value)
}

server <- shinyServer(function(input, output) {
  counter <- 0

  output$reactive_ui <- renderUI({
    input$click
    counter <<- counter + 1

    if (counter %% 2 < 1) {
      shiny::tagList(
        h2("Option A"),
        customer_input(input),
        normal_input(input),
        mem_input("mem", input)
      )
    } else {
      shiny::tagList(
        h2("Option B"),
        customer_input(input),
        normal_input(input),
        mem_input("mem", input)
      )
    }
  })

  output$out <- renderText({
    input$customer
  })
})

shinyApp(ui = ui, server = server)
