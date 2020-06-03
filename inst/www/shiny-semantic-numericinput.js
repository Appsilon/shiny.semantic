var semanticNumericInput = new Shiny.InputBinding();

// sourced from https://github.com/rstudio/shiny/blob/master/inst/www/shared/shiny.js
function updateLabel(labelTxt, labelNode) {
  // Only update if label was specified in the update method
  if (typeof labelTxt === "undefined") return;
  if (labelNode.length !== 1) {
    throw new Error("labelNode must be of length 1");
  }

  // Should the label be empty?
  var emptyLabel = $.isArray(labelTxt) && labelTxt.length === 0;

  if (emptyLabel) {
    labelNode.addClass("shiny-label-null");
  } else {
    labelNode.text(labelTxt);
    labelNode.removeClass("shiny-label-null");
  }
}

// based on https://github.com/rstudio/shiny/blob/master/inst/www/shared/shiny.js
// slightly changed due to different dom structure for labels
$.extend(semanticNumericInput, {
  find: function find(scope) {
    return $(scope).find('input[type="number"]');
  },
  getValue: function getValue(el) {
    var numberVal = $(el).val();
    if (/^\s*$/.test(numberVal)) // Return null if all whitespace
      return null;else if (!isNaN(numberVal)) // If valid Javascript number string, coerce to number
      return +numberVal;else return numberVal; // If other string like "1e6", send it unchanged
  },
  setValue: function setValue(el, value) {
    el.value = value;
  },
  subscribe: function subscribe(el, callback) {
    $(el).on('keyup.semanticNumericInput input.semanticNumericInput', function (event) {
      // true for using ratePolicy (results with short delay when user inputs values)
      callback(true);
    });
    $(el).on('change.semanticNumericInput', function (event) {
      // immediate change after triggering change event (while updaing)
      callback(false);
    });
  },
  receiveMessage: function receiveMessage(el, data) {
    if (data.hasOwnProperty('value')) el.value = data.value;
    if (data.hasOwnProperty('min')) el.min = data.min;
    if (data.hasOwnProperty('max')) el.max = data.max;
    if (data.hasOwnProperty('step')) el.step = data.step;

    updateLabel(data.label, this._getLabelNode(el));

    $(el).trigger('change');
  },
  getState: function getState(el) {
    return { label: this._getLabelNode(el).text(),
      value: this.getValue(el),
      min: Number(el.min),
      max: Number(el.max),
      step: Number(el.step) };
  },
  getRatePolicy: function getRatePolicy() {
    return {
      policy: 'debounce',
      delay: 250
    };
  },
  _getLabelNode: function _getLabelNode(el) {
    return $('label[for="' + el.id + '"]');
  }
});
Shiny.inputBindings.register(semanticNumericInput, 'shiny.semanticNumericInput');
