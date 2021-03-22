var semanticCheckboxBinding = new Shiny.InputBinding();

$.extend(semanticCheckboxBinding, {

  // This initialize input element. It extracts data-value attribute and use that as value.
  initialize: function(el) {
    $(el).checkbox({
      fireOnInit: true
    });
  },

  // This returns a jQuery object with the DOM element.
  find: function(scope) {
    return $(scope).find('.ss-checkbox-input');
  },

  // Returns the ID of the DOM element.
  getId: function(el) {
    return el.id;
  },

  // Given the DOM element for the input, return the value as JSON.
  getValue: function(el) {
    var checkboxes = $(el).find('.ui.checkbox');
    var checkboxCheck = checkboxes.checkbox('is checked');
    var checkboxValues = $.map(checkboxes.find('input'), function(n) { return n.value; });
    return checkboxValues.filter(x => checkboxCheck[checkboxValues.indexOf(x)]);
  },

  // Given the DOM element for the input, set the value.
  setValue: function(el, value) {
    var checkboxes = $(el).find('.ui.checkbox');
    checkboxes.checkbox('unckecked');
    return null;
  },

  // Set up the event listeners so that interactions with the
  // input will result in data being sent to server.
  // callback is a function that queues data to be sent to
  // the server.
  subscribe: function(el, callback) {
    $(el).checkbox({
      onChange: function() {
        callback();
      }
    });
  },

  // TODO: Remove the event listeners.
  unsubscribe: function(el) {
    $(el).off();
  },

  receiveMessage: function(el, data) {
    if (data.hasOwnProperty('choices')) {
    }

    if (data.hasOwnProperty('value')) {
      this.setValue(el, data.value);
    }

    if (data.hasOwnProperty('label')) {
      $("label[for='" + el.id + "'").html(data.label);
    }
  }
});

Shiny.inputBindings.register(semanticCheckboxBinding, 'shiny.semanticCheckbox');
