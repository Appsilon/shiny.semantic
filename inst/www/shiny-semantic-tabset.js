var semanticTabset = new Shiny.InputBinding();

$.extend(semanticTabset, {
  find: function(scope) {
    return $(scope).find('.ui.menu.sem');
  },
  initialize: function(el){
    $(el).find('.item').tab();
  },
  getValue: function(el) {
    var tabsetVal = $(el).find('.active.item').attr('data-tab');
    return tabsetVal;
  },
  subscribe: function(el, callback) {
    $(el).on('change', function(event) {
      $(this).trigger('shown');
      callback();
    });
    $(el).find('.item').on('click', function(event) {
      $(this).trigger('shown');
      callback();
    });
  },
  receiveMessage: function(el, data) {
    var tab_id;
    if (data.hasOwnProperty('selected'))
      tab_id = data.selected;
    $(el).find('.item').tab('change tab', tab_id);
    $(el).trigger('change');
  },
  unsubscribe: function(el) {
    $(el).off();
  }
});

Shiny.inputBindings.register(semanticTabset, 'shiny.semanticTabset');
