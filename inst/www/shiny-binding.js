var customShinyInputBinding = new Shiny.InputBinding();

$.extend(customShinyInputBinding, {
  initialize: function(el) {
    var val = $(el).attr('data-value');
    $(el).val(val);
  },

  // This returns a jQuery object with the DOM element
  find: function(scope) {
    return $(scope).find('.shiny-custom-input');
  },

  // return the ID of the DOM element
  getId: function(el) {
    return el.id;
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    var value = $(el).val();
    return JSON.stringify(value);
  },

  // Given the DOM element for the input, set the value
  setValue: function(el, value) {
    el.value = value;
  },

  // Set up the event listeners so that interactions with the
  // input will result in data being sent to server.
  // callback is a function that queues data to be sent to
  // the server.
  subscribe: function(el, callback) {
    $(el).change(function () { callback(true); });
  },

  // Remove the event listeners
  unsubscribe: function(el) {
  },

  // This returns a full description of the input's state.
  // Note that some inputs may be too complex for a full description of the state to be feasible.
  getState: function(el) {
    return {
      value: el.value
    };
  },

  // The input rate limiting policy
  getRatePolicy: function() {
    console.log("getRate called");
    return {
      // Can be 'debounce' or 'throttle'
      policy: 'debounce',
      delay: 500
    };
  }
});

Shiny.inputBindings.register(customShinyInputBinding, 'shiny.customShinyInput');

