var customShinyTextInputBinding = new Shiny.InputBinding();

$.extend(customShinyTextInputBinding, {

  // This initialize input element. It extracts data-value attribute and use that as value.
  initialize: function(el) {
    var val = $(el).attr('data-value');
    $(el).val(val);
  },

  // This returns a jQuery object with the DOM element.
  find: function(scope) {
    return $(scope).find('.shiny-custom-text-input');
  },

  // Returns the ID of the DOM element.
  getId: function(el) {
    return el.id;
  },

  // Given the DOM element for the input, return the value as JSON.
  getValue: function(el) {
    var value = $(el).val();
    return value;
  },

  // Given the DOM element for the input, set the value.
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

  // TODO: Remove the event listeners.
  unsubscribe: function(el) {
  },

  // This returns a full description of the input's state.
  getState: function(el) {
    return {
      value: el.value
    };
  },

  // The input rate limiting policy.
  getRatePolicy: function() {
    return {
      // Can be 'debounce' or 'throttle':
      policy: 'debounce',
      delay: 500
    };
  },

  receiveMessage: function(el, data) {
    if (data.hasOwnProperty('value'))
      this.setValue(el, data.value);

    if (data.hasOwnProperty('label')) {
      var input = $(el).closest(".ui");
      if (data.label === "") {
        input.dropdown('remove selected')
      } else {
        input.dropdown('set selected', data.label)
      }
    }

    $(el).trigger('change');
  }
});

Shiny.inputBindings.register(customShinyTextInputBinding, 'shiny.customShinyTextInput');

