const _toggleStepCompleteState = (stepId, state = true) => {
    state ? $(`#${stepId}`).addClass("completed") : $(`#${stepId}`).removeClass("completed")
}

const toggleCompletedState = (message) => {
    console.log(message)
    let stepId = message.step_id ? message.step_id : false;
    let state = message.state;
    if (!stepId) {
        return
    }
    console.log(`id is ${stepId} and state is ${state}`)
    _toggleStepCompleteState(stepId, state)
}

Shiny.addCustomMessageHandler("toggle_step_state", toggleCompletedState)