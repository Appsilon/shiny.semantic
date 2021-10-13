var semanticTabset = new Shiny.InputBinding();

$.extend(semanticTabset, {
  find: function(scope) {
    return $(scope).find('.ss-menu');
  },

  initialize: function(el) {
    if (el.classList.contains('navbar-page-menu') && el.dataset.hashHistory === 'true') {
      $(el).find('a.item').tab({
        history: true,
        historyType: 'hash'
      });
    } else {
      $(el).find('.item').tab();
    }
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

Shiny.addCustomMessageHandler('toggleSemanticNavbarTab', function(message) {
  var tabs = $(`#${message.id}`).find('.item');
  var sel_tab = tabs.filter((index, element) => $(element).data('tab') === `${message.target}`)
  if (message.toggle === 'show') {
    sel_tab.show();
  } else {
    sel_tab.hide();
  }
});
