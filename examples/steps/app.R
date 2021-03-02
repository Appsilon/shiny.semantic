library(shiny)
library(shiny.semantic)

ui <- semanticPage(
    title = "Steps Example",
    shiny::tagList(
        h2("Steps example"),
        steps(
            id = "steps",
            steps_list = list(
                single_step(
                    id = "step_1",
                    title = "Step 1",
                    description = "It's night?",
                    icon_class = "moon"
                ),
                single_step(
                    id = "step_2",
                    title = "Step 2",
                    description = "Order some food",
                    icon_class = "bug"
                ),
                single_step(
                    id = "step_3",
                    title = "Step 3",
                    description = "Feed the Kiwi",
                    icon_class = "kiwi bird"
                )
            )
        ),
        h3("Actions"),
        action_button("step_1_complete", "Make it night"),
        action_button("step_2_complete", "Call the insects"),
        action_button("step_3_complete", "Feed the Kiwi"),
        action_button("hungry_kiwi", "Kiwi is hungry again"),
    )
)

server <- function(input, output, session) {
    observeEvent(input$step_1_complete, {
        toggle_step_state("step_1")
    })
    observeEvent(input$step_2_complete, {
        toggle_step_state("step_2")
    })
    observeEvent(input$step_3_complete, {
        toggle_step_state("step_3")
    })
    observeEvent(input$hungry_kiwi, {
        toggle_step_state("step_1", FALSE)
        toggle_step_state("step_2", FALSE)
        toggle_step_state("step_3", FALSE)
    })
}

shinyApp(ui = ui, server = server)
