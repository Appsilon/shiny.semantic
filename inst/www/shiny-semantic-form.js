// Shiny input for form validation
renderFormValidation = function() {
  $('.form').each(function() { if (this.id) Shiny.setInputValue(this.id, $(this).form('is valid')); });
  $('.form').form('setting', 'onSuccess', function() { if (this.id) Shiny.setInputValue(this.id, true); });
  $('.form').form('setting', 'onFailure', function() { if (this.id) Shiny.setInputValue(this.id, false); });
};

$(window).on('shiny:connected', renderFormValidation);
