$.fn.modal.settings.onShow = function(){Shiny.bindAll()};

Shiny.addCustomMessageHandler('showSemanticModal', function(message){
  $('#' + message.id).modal(message.action)
});

Shiny.initSemanticModal = function(id) {
  $('[id="' + id + '"]:not(:first)').remove();
}

Shiny.addCustomMessageHandler('createSemanticModal', function(message){
  let id = $(message.ui_modal)
    .modal()
    .attr("id")

  Shiny.initSemanticModal(id)

  $('#' + id).modal(message.action)
});

Shiny.addCustomMessageHandler('hideAllSemanticModals', function(message){
  $(".ui .modal").modal('hide');
});

