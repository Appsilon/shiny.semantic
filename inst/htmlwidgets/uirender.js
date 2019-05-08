HTMLWidgets.widget({
  name: 'uirender',
  type: 'output',

  factory: function(el, width, height) {
    return {
      renderValue: function(x) {
        var tag_js = "<script src='" + x.shiny_custom_semantic + "/semantic.min.js'></script>"
        var tag_css = "<link href='" + x.shiny_custom_semantic + "/semantic.min.css' rel='stylesheet'>"
        el.innerHTML = x.ui + tag_js + tag_css;
        },

      resize: function(width, height) {
        // TODO: code to re-render the widget with a new size
      }
    };
  }
});
