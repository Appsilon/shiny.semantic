Shiny.initSemanticToast = function(id) {
  $('[id="' + id + '"]:not(:first)').remove();
};

Shiny.addCustomMessageHandler('createSemanticToast', function(message) {
  Shiny.initSemanticToast(message.id);

  const toast_message = message.message;
  // Changes character string into function
  if (toast_message.hasOwnProperty('actions')) {
    for (i = 0; i < toast_message.actions.length; i++) {
      if (toast_message.actions[i].hasOwnProperty('click')) {
        toast_message.actions[i].click = eval(toast_message.actions[i].click);
      }
    }
  }

  const sem_toast = $('body').toast(toast_message);
  $(sem_toast).attr('id', `${message.id}`);
});

Shiny.addCustomMessageHandler('closeSemanticToast', function(message) {
  $(`#${message.id}`).toast('close');
});
