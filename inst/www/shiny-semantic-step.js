const resetAllSteps = (stepperId) => {
    $(`#${stepperId}`).children(".step").addClass("disabled");
    $(`#${stepperId}`).children(".step").removeClass("completed");
    // Activating first step
    $(`#${stepperId}`).children(".step").first().addClass("active")
    $(`#${stepperId}`).children(".step").first().removeClass("disabled");
}

const _toggleStepCompleteState = (stepId, state,  automaticSteps) => {
    state ? _addCompletedState(stepId) : _removeCompletedState(stepId);
    _removeActiveState(stepId);
    if (automaticSteps) {
        _toggleNextStep(stepId, state);
    } 
}

const _toggleNextStep = (stepId, state) => {
    let next_step = _getNextStep(stepId);
    if (next_step) {
        state ? _removeDisabledState(next_step.attr("id")) : _addDisabledState(next_step.attr("id"));
        state ? _addActiveState(next_step.attr("id")) : _removeActiveState(next_step.attr("id"));
    } 
}

const _removeCompletedState = (stepId) => {
    $(`#${stepId}`).removeClass("completed");
}

const _addCompletedState = (stepId, autodisable = true) => {
    $(`#${stepId}`).addClass("completed");
    autodisable ? _removeDisabledState(stepId) : null;
}

const _removeDisabledState = (stepId) => {
    $(`#${stepId}`).removeClass("disabled");
}

const _addDisabledState = (stepId) => {
    $(`#${stepId}`).addClass("disabled");
}

const _removeActiveState = (stepId) => {
    $(`#${stepId}`).removeClass("active")
}

const _addActiveState = (stepId) => {
    $(`#${stepId}`).addClass("active")
}

const _getNextStep = (stepId) => {
    let siblingStep = $(`#${stepId}`).next(".step");
    return siblingStep.length > 0 ? siblingStep : false
}


const toggleCompletedState = (message) => {
    let stepId = message.step_id ? message.step_id : false;
    let state = message.state;
    let automaticSteps = message.automatic_steps ? true : false;
    if (!stepId) {
        return
    }
    _toggleStepCompleteState(stepId, state, automaticSteps)
}

Shiny.addCustomMessageHandler("toggle_step_state", toggleCompletedState)