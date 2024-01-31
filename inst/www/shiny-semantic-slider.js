var semanticSliderBinding = new Shiny.InputBinding();

$.extend(semanticSliderBinding, {
  // This initialize input element. It extracts data-value attribute and use that as value.
  initialize: function(el) {
    var sliderData = $(el).data();
    var sliderOptions = {
      onChange: function(value) { $(el).trigger('change'); }
    };

    if (Object.keys(sliderData).includes('ticks')) {
      sliderOptions.interpretLabel = function(value, ticks = sliderData.ticks) {
        return ticks[value];
      };
      sliderOptions.start = sliderData.ticks.indexOf(sliderData.start);
      if ($(el).hasClass('range')) {
        sliderOptions.end = sliderData.ticks.indexOf(sliderData.end);
      }
      sliderOptions.max = sliderData.ticks.length - 1;
    } else {
      sliderOptions.min = Number(sliderData.min);
      sliderOptions.max = Number(sliderData.max);
      sliderOptions.step = Number(sliderData.step);
      sliderOptions.start = Number(sliderData.start);
      if ($(el).hasClass('range')) {
        sliderOptions.end = Number(sliderData.end);
      }
    }

    $(el).slider(sliderOptions);
  },

  // This returns a jQuery object with the DOM element.
  find: function(scope) {
    // checkbox with type slider was also found here causing: https://github.com/Appsilon/shiny.semantic/issues/229
    return $(scope).find('.ss-slider');
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

    if ($(el).data('ticks')) {
      return $(el).data('ticks')[value];
    } else {
      return(JSON.stringify(value))
    }
  },
  getType: function(el) {
    if ($(el).data('ticks')) {
      return false;
    } else {
      return 'shiny.semantic.vector';
    }
  },
  // Given the DOM element for the input, set the value.
  setValue: function(el, value) {
    if ($(el).data('ticks')) {
      if ($(el).hasClass('range')) {
        $(el).slider('set rangeValue', $(el).data('ticks').indexOf(value[0]), $(el).data('ticks').indexOf(value[1]));
      } else {
        $(el).slider('set value', $(el).data('ticks').indexOf(value[0]));
      }
    } else {
      if ($(el).hasClass('range')) {
        $(el).slider('set rangeValue', value[0], value[1]);
      } else {
        $(el).slider('set value', value[0]);
      }
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
