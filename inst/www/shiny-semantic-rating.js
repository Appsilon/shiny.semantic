var semanticRatingBinding = new Shiny.InputBinding();
$.extend(semanticRatingBinding, {
  find: function(scope) {
    return $(scope).find(".ui.rating");
  },
  initialize: function(el){
    $("#" + el.id).rating('setting', 'clearable', true);
  },
  getValue: function(el) {
    return $(el).rating('get rating') || 0;
  },
  subscribe: function(el, callback) {
    $(el).rating('setting', 'onRate', function() {
      callback();
    });
  },
  receiveMessage: function(el, data) {
    var $el = $(el);
    if (data.hasOwnProperty('label')) {
      $('label[for="' + el.id + '"]').html(data.label);
    }
    if (data.hasOwnProperty('value')) {
      $(el).rating('set rating', data.value);
    }
  },
  unsubscribe: function(el) {
    $(el).off();
  }
});
Shiny.inputBindings.register(semanticRatingBinding, 'shiny.semanticRating');
