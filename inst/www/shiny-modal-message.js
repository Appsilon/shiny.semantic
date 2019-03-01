Shiny.addCustomMessageHandler('showSemanticModal', function(message){
  $('#' + message.id).modal(message.action)
});
