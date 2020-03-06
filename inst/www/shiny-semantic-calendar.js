// Convert a number to a string with leading zeros
function padZeros(n, digits) {
  var str = n.toString();
  while (str.length < digits)
    str = "0" + str;
  return str;
}

// Given a Date object, return a string in the local time zone.
function formatDate(date) {
  if (date instanceof Date) {
    return date.getFullYear() + '-' +
           padZeros(date.getMonth()+1, 2) + '-' +
           padZeros(date.getDate(), 2);
  } else {
    return null;
  }
}

var semanticDateBinding = new Shiny.InputBinding();

$.extend(semanticDateBinding, {

  // This initialize input element. It extracts data-value attribute and use that as value.
  initialize: function(el) {
    $(el).calendar({
      onChange: function(date, text, mode) {
        $(el).trigger('change');
      }
    });
  },

  // This returns a jQuery object with the DOM element.
  find: function(scope) {
    return $(scope).find('.ss-input-date');
  },

  getType: function(el) {
    return "shiny.date";
  },

  // Return the date in an unambiguous format, yyyy-mm-dd (as opposed to a
  // format like mm/dd/yyyy)
  getValue: function(el) {
    var date = $(el).calendar('get date');
    return formatDate(date);
  },

  // value must be an unambiguous string like '2001-01-01', or a Date object.
  setValue: function(el, value) {
    // R's NA, which is null here will remove current value
    if (value === null) {
      $(el).calendar('clear');
      return;
    }

    $(el).calendar('set date', value);
  },

  getState: function(el) {
    var min = $(el).calendar('get minDate');
    var max = $(el).calendar('get maxDate');

    // Stringify min and max. If min and max aren't set, they will be
    // -Infinity and Infinity; replace these with null.
    min = (min === -Infinity) ? null : formatDate(min);
    max = (max ===  Infinity) ? null : formatDate(max);

    // startViewMode is stored as a number; convert to string
    return {
      value: $(el).calendar('get date'),
      min: min,
      max: max
    };
  },

  subscribe: function(el, callback) {
    $(el).on('keyup change ', function(event) { callback(true); });
  },

  unsubscribe: function(el) {
    $(el).off('.semanticDateBinding');
  },

  getRatePolicy: function() {
    return {
      policy: 'debounce',
      delay: 250
    };
  },

  receiveMessage: function(el, data) {
    if (data.hasOwnProperty('min'))
      $(el).calendar('set minDate', data.min);
      $(el).attr("data-min-date", data.min);

    if (data.hasOwnProperty('max'))
      $(el).calendar('set maxDate', data.max);
      $(el).attr("data-max-date", data.max);

    // Must set value only after min and max have been set. If new value is
    // outside the bounds of the previous min/max, then the result will be a
    // blank input.
    if (data.hasOwnProperty('value'))
      this.setValue(el, data.value);
      $(el).attr("data-date", this.getValue(el));

    $(el).trigger('change');
  }
});

Shiny.inputBindings.register(semanticDateBinding, 'shiny.semanticDate');
