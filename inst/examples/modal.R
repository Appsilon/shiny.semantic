## Create a simple server modal
if (interactive()) {
  library(shiny)
  library(shiny.semantic)
  
  ui <- function() {
    shinyUI(
      semanticPage(
        actionButton("show", "Show modal dialog")
      )
    )
  }
  
  server = function(input, output) {
    observeEvent(input$show, {
      create_modal(modal(
        id = "simple-modal",
        header = h2("Important message"),
        "This is an important message!"
      ))
    })
  }
  shinyApp(ui, server)
}
## Create a simple UI modal

if (interactive()) {
  library(shiny)
  library(shiny.semantic)
  ui <- function() {
    shinyUI(
      semanticPage(
        title = "Modal example - Static UI modal",
        div(id = "modal-open-button", class = "ui button", "Open Modal"),
        modal(
          div("Example content"),
          id = "example-modal",
          target = "modal-open-button"
        )
      )
    )
  }
  
  ## Observe server side actions
  library(shiny)
  library(shiny.semantic)
  ui <- function() {
    shinyUI(
      semanticPage(
        title = "Modal example - Server side actions",
        uiOutput("modalAction"),
        actionButton("show", "Show by calling show_modal")
      )
    )
  }
  
  server <- shinyServer(function(input, output) {
    observeEvent(input$show, {
      show_modal('action-example-modal')
    })
    observeEvent(input$hide, {
      hide_modal('action-example-modal')
    })
    
    output$modalAction <- renderUI({
      modal(
        actionButton("hide", "Hide by calling hide_modal"),
        id = "action-example-modal",
        header = "Modal example",
        footer = "",
        class = "tiny"
      )
    })
  })
  shinyApp(ui, server)
}
## Changing attributes of header and content.
if (interactive()) {
  library(shiny)
  library(shiny.semantic)
  
  ui <- function() {
    shinyUI(
      semanticPage(
        actionButton("show", "Show modal dialog")
      )
    )
  }
  
  server = function(input, output) {
    observeEvent(input$show, {
      create_modal(modal(
        id = "simple-modal",
        title = "Important message",
        header = list("!!!", style = "background: lightcoral"),
        content = list(style = "background: lightblue",
                       `data-custom` = "value", "This is an important message!"),
        p("This is also part of the content!")
      ))
    })
  }
  shinyApp(ui, server)
}
if (interactive()) {
  library(shiny)
  library(shiny.semantic)
  shinyApp(
    ui = semanticPage(
      actionButton("show", "Show modal dialog")
    ),
    server = function(input, output) {
      observeEvent(input$show, {
        showModal(modalDialog(
          title = "Important message",
          "This modal will close after 3 sec.", easyClose = FALSE
        ))
        Sys.sleep(3)
        removeModal()
      })
    }
  )
}
