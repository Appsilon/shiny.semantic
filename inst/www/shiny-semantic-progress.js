// Shiny input for progress bars
renderProgressBars = function() {
  $('.progress').progress({
    text: {
      active: $(this).data('label'),
      success: $(this).data('label-complete')
    },
    onActive: function() {
      Shiny.setInputValue(this.id, $(this).progress('get value'));
    },
    onChange: function() {
      Shiny.setInputValue(this.id, $(this).progress('get value'));
    }
  });
};

$(window).on('load', renderProgressBars);

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

  change: function(message) {
    var progress = $('#' + message.id);

    if (message.type === 'label') {
      progress.progress('set label', message.value);
    } else if (message.type === 'value') {
      progress.progress('set progress', message.value);
    } else {
      progress.progress(message.type, message.value);
    }
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
