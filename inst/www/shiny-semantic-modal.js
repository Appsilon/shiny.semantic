Shiny.addCustomMessageHandler('showSemanticModal', function(message){
  $('#' + message.id).modal(message.action)
});

Shiny.initSemanticModal = function(id) {
  $('[id="' + id + '"]:not(:first)').remove();
  $('#' + id).modal({
     onShow: function () {
       Shiny.bindAll();
     }
   });
}
