Shiny.initSemanticToast = function(id) {
  $('[id="ss-toast-' + id + '"]:not(:first)').remove();
};

Shiny.addCustomMessageHandler('createSemanticToast', function(message) {
  Shiny.initSemanticToast(message.id);
  $('body').toast(message.message);
});
