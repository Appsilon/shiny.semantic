var semanticDropdownBinding = new Shiny.InputBinding();

$.extend(semanticDropdownBinding, {

  // This initialize input element. It extracts data-value attribute and use that as value.
  initialize: function(el) {
    let value = $(el).children('input').val();
    // Enables the dropdown to be a vector if multiple class
    if ($(el).hasClass('multiple')) {
      value.split(",").map(v => $(el).dropdown('set selected', v));
    } else {
      $(el).dropdown('set exactly', value);
    }
  },

  // This returns a jQuery object with the DOM element.
  find: function(scope) {
    return $(scope).find('.dropdown');
  },

  // Returns the ID of the DOM element.
  getId: function(el) {
    return el.id;
  },

  // Given the DOM element for the input, return the value as JSON.
  getValue: function(el) {
    let value = $(el).children('input').val();
    // Enables the dropdown to be a vector if multiple class
    if ($(el).hasClass('multiple')) {
      value = value.split(",");
    }
    return value;
  },

  // Given the DOM element for the input, set the value.
  setValue: function(el, value) {
    if ($(el).hasClass('multiple')) {
      $(el).dropdown('set exactly', '');
      value.split(",").map(v => $(el).dropdown('set selected', v));
    } else {
      $(el).dropdown('set exactly', value);
    }
  },

  // Set up the event listeners so that interactions with the
  // input will result in data being sent to server.
  // callback is a function that queues data to be sent to
  // the server.
  subscribe: function(el, callback) {
    $(el).on('keyup change', function () { callback(true); });
  },

  // TODO: Remove the event listeners.
  unsubscribe: function(el) {
    $(el).off('.semanticDropdownBinding');
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
    if (data.hasOwnProperty('choices')) {
      $(el).dropdown('change values', data.choices);
    }

    if (data.hasOwnProperty('value')) {
      this.setValue(el, data.value);
    }

    $(el).trigger('change');
  }
});

Shiny.inputBindings.register(semanticDropdownBinding, 'shiny.semanticDropdown');
