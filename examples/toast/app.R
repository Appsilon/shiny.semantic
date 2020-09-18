library(shiny)
library(shiny.semantic)

ui <- semanticPage(
  segment(
    class = "basic",
    button("button", "Show a basic toast"),
    button("button2", "Show a warning toast in bottom right"),
    button("button3", "Show a toast with a button"),
    button("button4", "Show a toast that doesn't close")
  )
)


server <- shinyServer(function(input, output, session) {
  observeEvent(input$button, toast("Simple toast", session = session))

  observeEvent(
    input$button2,
    toast(
      "Simple toast", class = "warning", session = session,
      toast_tags = list(position = "bottom right", showIcon = "exclamation triangle")
    )
  )

  observeEvent(
    input$button3,
    toast(
      "Simple toast", class = "olive", session = session,
      action = list(
        list(
          text = "Yes", icon = "check", class = "green",
          click = "(function() { $('body').toast({message:'You clicked \"yes\", toast closes by default'}); })"
        ),
        list(
          text = "No", icon = "times", class = "red",
          click = "(function() { $('body').toast({message:'You clicked \"no\", toast closes by default'}); })"
        )
      )
    )
  )

  observeEvent(
    input$button4,
    toast("This toast won't close unless you click me!", duration = 0, session = session)
  )
})

shinyApp(ui = ui, server = server)
