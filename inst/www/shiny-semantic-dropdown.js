var semanticDropdownBinding = new Shiny.InputBinding();

$.extend(semanticDropdownBinding, {

  // This initialize input element. It extracts data-value attribute and use that as value.
  initialize: function(el) {
    $(el).dropdown();
  },

  // This returns a jQuery object with the DOM element.
  find: function(scope) {
    return $(scope).find('.semantic-select-input');
  },

  // Returns the ID of the DOM element.
  getId: function(el) {
    return el.id;
  },

  // Given the DOM element for the input, return the value as JSON.
  getValue: function(el) {
    let value = $(el).dropdown('get value');
    // Enables the dropdown to be a vector if multiple class
    if ($(el).hasClass('multiple')) {
      if (value === "") {
        return null;
      }
      value = value.split(",");
    }
    return value;
  },

  // Given the DOM element for the input, set the value.
  setValue: function(el, value) {
    if (value === '') {
      $(el).dropdown('clear');
      return;
    }
    if ($(el).hasClass('multiple')) {
      $(el).dropdown('clear', true);
      value.split(",").map(v => $(el).dropdown('set selected', v));
    } else {
      $(el).dropdown('set selected', value);
    }
  },

  // Set up the event listeners so that interactions with the
  // input will result in data being sent to server.
  // callback is a function that queues data to be sent to
  // the server.
  subscribe: function(el, callback) {
    $(el).dropdown({
      onChange: function(){
        callback();
        $(el).dropdown('hide');
      }
    });
  },

  // TODO: Remove the event listeners.
  unsubscribe: function(el) {
    $(el).off();
  },

  receiveMessage: function(el, data) {
    let value = data.value;
    if (data.hasOwnProperty('choices')) {
      // setup menu changes dropdown options without triggering onChange event
      $(el).dropdown('setup menu', data.choices);
      // either keep the value provided or use the fact that an empty string clears the input and triggers a change event
      value ||= ""
    }

    this.setValue(el, value);

    if (data.hasOwnProperty('label')) {
      $("label[for='" + el.id + "'").html(data.label);
    }
  }
});

Shiny.inputBindings.register(semanticDropdownBinding, 'shiny.semanticDropdown');

var semanticThemesDropdownBinding = new Shiny.InputBinding();
const supported_themes = ["", "cerulean", "darkly", "paper", "simplex", "superhero", "flatly", "slate", "cosmo", "readable", "united", "journal", "solar", "cyborg", "sandstone", "yeti", "lumen", "spacelab"];

function _getLinkTheme(link_el) {
  var theme = link_el.attr('href');
  theme = theme.replace(/^.*\//, '').replace(/(\.min)?\.css$/, '').replace(/^semantic\.*/, '');
  return theme;
}

function _getThemeLink() {
  var $link = $('link').filter(function() {
    var theme = _getLinkTheme($(this));
    return $.inArray(theme, supported_themes) !== -1;
  });
  return $link;
}

$.extend(semanticThemesDropdownBinding, {

  // This initialize input element. It extracts data-value attribute and use that as value.
  initialize: function(el) {
    let theme = _getLinkTheme(_getThemeLink());
    $(el).dropdown('set exactly', theme);
  },

  // This returns a jQuery object with the DOM element.
  find: function(scope) {
    return $(scope).find('.themes-dropdown');
  },

  // Returns the ID of the DOM element.
  getId: function(el) {
    return el.id;
  },

  // Given the DOM element for the input, return the value as JSON.
  getValue: function(el) {
    let value =  $(el).dropdown('get value');
    var link_el = _getThemeLink();
    let previous_value = _getLinkTheme(link_el);
    let link_el_href = link_el.attr('href');
    if (previous_value === value) {
      return value;
    }
    if (previous_value !== "") {
      link_el.attr('href', link_el_href.replace(previous_value, value).replace(/\.\./, '.'));
    } else {
      link_el.attr('href', link_el_href.replace('semantic.', 'semantic.' + value + '.'));
    }
    return value;
  },
  // Set up the event listeners so that interactions with the
  // input will result in data being sent to server.
  // callback is a function that queues data to be sent to
  // the server.
  subscribe: function(el, callback) {
    $(el).on('keyup change', function () { callback(); });
  },

  // TODO: Remove the event listeners.
  unsubscribe: function(el) {
    $(el).off('.semanticThemesDropdownBinding');
  }
});

Shiny.inputBindings.register(semanticThemesDropdownBinding, 'shiny.semanticThemesDropdownBinding');
