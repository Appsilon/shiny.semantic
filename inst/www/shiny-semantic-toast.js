Shiny.initSemanticToast = function(id) {
  $('[id="' + id + '"]:not(:first)').remove();
};

Shiny.addCustomMessageHandler('createSemanticToast', function(message) {
  Shiny.initSemanticToast(message.id);
  const sem_toast = $('body').toast(message.message);
  $(sem_toast).attr('id', `${message.id}`);
});

Shiny.addCustomMessageHandler('closeSemanticToast', function(message) {
  $(`#${message.id}`).toast('close');
});
