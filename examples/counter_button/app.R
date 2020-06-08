library(shiny)
library(shiny.semantic)
big_mark_reqex <- function(big_mark) {
  if (big_mark == " ") {
    return("\\s")
  } else {
    return(big_mark)
  }
}

counter_button <- function(inputId, label, icon, value = 0, big.mark = " ") {
  big_mark_regex <- big_mark_reqex(big.mark)
  shiny::div(
    class = "ui labeled button", tabindex = "0",
    shiny::tagList(
      uibutton(name = inputId, label, icon),
      shiny::tags$span(class = "ui basic label", format(value, big.mark = big.mark)),
      shiny::tags$script(HTML(
        glue::glue("$('#{inputId}').on('click', function() {{
          let $label = $('#{inputId} + .label')
          let value = parseInt($label.html().replace(/{big_mark_regex}/g, ''))
          $label.html((value + 1).toString().replace(/\\B(?=(\\d{{3}})+(?!\\d))/g, '{big.mark}'))
        }})")
      ))
    )
  )
}

ui <- function() {
  shinyUI(
    semanticPage(
      counter_button("likes", "Like", uiicon("heart"), value = 1000)
    )
  )
}

server <- shinyServer(function(input, output, session) {

})

shinyApp(ui = ui(), server = server)

