// Shiny input for progress bars
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

// JS to handle the Progress object similar to shiny
Shiny.addCustomMessageHandler('ssprogress', function(message) {
  if (message.type && message.message) {
    var handler = ssProgressHandlers[message.type];
    if (handler)
      handler.call(this, message.message);
  }
});

var ssProgressHandlers = {
  // Open a page-level progress bar
  open: function(message) {
    var sem_progress = document.createElement('div');
    sem_progress.setAttribute('id', `ss-progress-${message.id}`);
    sem_progress.setAttribute('class', `ui small indicating progress`);
    sem_progress.setAttribute('data-value', message.min);
    sem_progress.setAttribute('data-total', message.max);
      sem_progress.innerHTML = `
      <div class="bar"><div class="progress"></div></div><div class="label">message</div></div>
    `;
      var sem_toast = $('body').toast({
      position: 'bottom right',
      displayTime: 0,
      closeIcon: true,
      message: sem_progress
    });
    $(sem_toast).attr('id', `ss-toast-${message.id}`);
    $(sem_toast).attr('style', $(sem_toast).attr('style') + ' padding-top: 1.75em;');

    $(`#ss-progress-${message.id}`).progress();
  },

  // Update page-level progress bar
  update: function(message) {
    // For new-style (starting in Shiny 0.14) progress indicators that use
    // the notification API.
    var progress = $('#ss-progress-' + message.id);

    if (progress.length === 0)
      return;

    if (typeof(message.message) !== 'undefined') {
      progress.progress('set label', message.message);
    }
    if (typeof(message.value) !== 'undefined' && message.value !== null) {
      progress.progress('set progress', message.value);
      }

  },

  // Close page-level progress bar
  close: function(message) {
    $(`#ss-toast-${message.id}`).toast('close');
  }
};
