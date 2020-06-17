var semanticProgressBinding = new Shiny.InputBinding();

$.extend(semanticProgressBinding, {

  // This initialize input element. It extracts data-value attribute and use that as value.
  initialize: function(el) {
    $(el).progress({
      text: {
        active: $(el).data('label'),
        success: $(el).data('label-complete')
      }
    });
  },

  // This returns a jQuery object with the DOM element.
  find: function(scope) {
    return $(scope).find('.ss-progress');
  },

  // Returns the ID of the DOM element.
  getId: function(el) {
    return el.id;
  },

  // Given the DOM element for the input, return the value as JSON.
  getValue: function(el) {
    if ($(el).data('value')) {
      return $(el).progress('get value');
    } else {
      return $(el).progress('get percent');
    }
  },

  // Given the DOM element for the input, set the value.
  setValue: function(el, value) {
    if ($(el).data('value')) {
      return $(el).progress('set progress', value);
    } else {
      return $(el).progress('set percent', value);
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
    $(el).off('.semanticProgressBinding');
  },

  // This returns a full description of the input's state.
  getState: function(el) {
    return {
      value: this.getValue(el)
    };
  },

  // The input rate limiting policy.
  getRatePolicy: function() {
    return {
      // Can be 'debounce' or 'throttle':
      policy: 'debounce',
      delay: 50
    };
  },

  receiveMessage: function(el, data) {
    if (data.hasOwnProperty('value')) {
      this.setValue(el, data.value);
    }

    if (data.hasOwnProperty('label')) {
      $(el).progress('set label', data.label);
    }

    if (data.hasOwnProperty('increment')) {
      $(el).progress('increment', Number(data.increment));
    }

    if (data.hasOwnProperty('decrement')) {
      $(el).progress('decrement', Number(data.decrement));
    }

    $(el).trigger('change');
  }
});

Shiny.inputBindings.register(semanticProgressBinding, 'shiny.semanticProgress');
