var semanticTabset = new Shiny.InputBinding();
var PREV_SEM_TAB;

$.extend(semanticTabset, {
  find: function(scope) {
    return $(scope).find('.sem.menu .item');
  },
  initialize: function(el){
    $(el).tab();
  },
  getValue: function(el) {
    var tabsetVal = $(el).attr('data-tab');
    return tabsetVal;
  },
  subscribe: function(el, callback) {

  },
  receiveMessage: function(el, data) {
   var tab_name;
   if (data.hasOwnProperty('name'))
    tab_name = data.name;
   $(el).tab('change tab', tab_name);
  },
  unsubscribe: function(el) {
    $(el).off();
  }
});

Shiny.inputBindings.register(semanticTabset, 'shiny.semanticTabset');


