var semanticSliderBinding = new Shiny.InputBinding();

$.extend(semanticSliderBinding, {

  // This initialize input element. It extracts data-value attribute and use that as value.
  initialize: function(el) {
    var sliderDiv = $(el);

    if ($(el).hasClass('range')) {
      $(el).slider({
        min: Number($(el).data('min')),
        max: Number($(el).data('max')),
        step: Number($(el).data('step')),
        start: Number($(el).data('start')),
        end: Number($(el).data('end')),
        onChange: function(value) { $(el).trigger('change'); }
      });
    } else {
      $(el).slider({
        min: Number($(el).data('min')),
        max: Number($(el).data('max')),
        step: Number($(el).data('step')),
        start: Number($(el).data('start')),
        onChange: function(value) { $(el).trigger('change'); }
      });
    }
  },

  // This returns a jQuery object with the DOM element.
  find: function(scope) {
    return $(scope).find('.slider');
  },

  // Returns the ID of the DOM element.
  getId: function(el) {
    return el.id;
  },

  // Given the DOM element for the input, return the value as JSON.
  getValue: function(el) {
     let value = $(el).slider('get value');
    // Takes either one or two arguments depending on if it's a range or normal slider
    if ($(el).hasClass('range')) {
      value = [$(el).slider('get thumbValue', 'first'), $(el).slider('get thumbValue', 'second')];
    }
    return value;
  },

  // Given the DOM element for the input, set the value.
  setValue: function(el, value) {
    if ($(el).hasClass('range')) {
      $(el).slider('set rangeValue', value[0], value[1]);
    } else {
      $(el).slider('set value', value);
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
    $(el).off('.semanticSliderBinding');
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

    $(el).trigger('change');
  }
});

Shiny.inputBindings.register(semanticSliderBinding, 'shiny.semanticSlider');
