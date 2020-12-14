var semanticTabset = new Shiny.InputBinding();
var PREV_SEM_TAB;

$.extend(semanticTabset, {
  find: function(scope) {
    return $(scope).find('.tabular.menu');
  },
  initialize: function(el){
    $(el).find('.item').tab();
  },
  getValue: function(el) {
    var tabsetVal = $(el).find('.active.item').attr('data-tab');
    return tabsetVal;
  },
  subscribe: function(el, callback) {

  },
  receiveMessage: function(el, data) {
    var tab_name;
    if (data.hasOwnProperty('name'))
      tab_name = data.name;
    $(el).tab('change tab', data);
  },
  unsubscribe: function(el) {
    $(el).off();
  }
});

Shiny.inputBindings.register(semanticTabset, 'shiny.semanticTabset');
