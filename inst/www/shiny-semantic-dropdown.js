var semanticDropdownBinding = new Shiny.InputBinding();

$.extend(semanticDropdownBinding, {

  // This initialize input element. It extracts data-value attribute and use that as value.
  initialize: function(el) {
    $(el).dropdown();
  },

  // This returns a jQuery object with the DOM element.
  find: function(scope) {
    return $(scope).find('.ui.dropdown');
  },

  // Returns the ID of the DOM element.
  getId: function(el) {
    return el.id;
  },

  // Given the DOM element for the input, return the value as JSON.
  getValue: function(el) {
    let value = $(el).dropdown('get value');
    // Enables the dropdown to be a vector if multiple class
    if ($(el).hasClass('multiple')) {
      if (value === "") {
        return null;
      }
      value = value.split(",");
    }
    return value;
  },

  // Given the DOM element for the input, set the value.
  setValue: function(el, value) {
    if ($(el).hasClass('multiple')) {
      $(el).dropdown('clear', true);
      value.split(",").map(v => $(el).dropdown('set selected', v));
    } else {
      $(el).dropdown('set selected', value);
    }
  },

  // Set up the event listeners so that interactions with the
  // input will result in data being sent to server.
  // callback is a function that queues data to be sent to
  // the server.
  subscribe: function(el, callback) {
    $(el).dropdown({
      onChange: function(value, text, $selectedItem) {
        callback();
      }
    })
  },

  // TODO: Remove the event listeners.
  unsubscribe: function(el) {
    $(el).off();
  },

  receiveMessage: function(el, data) {
    if (data.hasOwnProperty('choices')) {
      // setup menu changes dropdown options without triggering onChange event
      $(el).dropdown('setup menu', data.choices);
      // when no value passed, return null for multiple dropdown and first value for single one
      if (!data.hasOwnProperty('value')) {
        let value = ""
        if (!$(el).hasClass('multiple')) {
          value = data.choices.values[0].value
        }
        this.setValue(el, value);
      }
    }

    if (data.hasOwnProperty('value')) {
      this.setValue(el, data.value);
    }

    if (data.hasOwnProperty('label')) {
      $("label[for='" + el.id + "'").html(data.label);
    }
  }
});

Shiny.inputBindings.register(semanticDropdownBinding, 'shiny.semanticDropdown');
