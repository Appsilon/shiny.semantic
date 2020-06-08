var semanticRatingBinding = new Shiny.InputBinding();
$.extend(semanticRatingBinding, {
  find: function(scope) {
    console.log('find');
    return $(scope).find(".rating");
  },
  initialize: function(el){
    console.log('initialize');
    $("#" + el.id).rating('setting', 'clearable', true);
  },
  getValue: function(el) {
    console.log('get value');
    return $(el).data('rating') || 0;
  },
  setValue: function(el, value) {
    console.log('set value');
    $(el).rating('set rating', value);
  },
  subscribe: function(el, callback) {
    console.log('subscribe');
    $(el).rating('setting', 'onRate', function(value) {
      console.log('click');
      var $el = $(this);
      var val = $el.rating('get rating') || 0;
      $el.data('rating', val);

      callback();
    });
  },
  receiveMessage: function(el, data) {
    var $el = $(el);
    if (data.hasOwnProperty('label')) {
      $('label[for="' + el.id + '"]').html(data.label);
    }
    if (data.hasOwnProperty('value')) {
      this.setValue($el, data.value);
    }
  },
  unsubscribe: function(el) {
    $(el).off(".semanticRatingBinding");
  }
});
Shiny.inputBindings.register(semanticRatingBinding, 'shiny.semanticRating');
