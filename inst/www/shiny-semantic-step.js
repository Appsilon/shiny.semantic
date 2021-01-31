const _toggleStepCompleteState = (stepId, state = true) => {
    state ? $(`#${stepId}`).addClass("completed") : $(`#${stepId}`).removeClass("completed")
}

const toggleCompletedState = (message) => {
    let stepId = message.step_id ? message.step_id : false;
    let state = message.state;
    if (!stepId) {
        return
    }
    _toggleStepCompleteState(stepId, state)
}

Shiny.addCustomMessageHandler("toggle_step_state", toggleCompletedState)