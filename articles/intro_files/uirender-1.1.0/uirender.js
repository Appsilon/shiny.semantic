HTMLWidgets.widget({
  name: 'uirender',
  type: 'output',

  factory: function(el, width, height) {
    console.log('uirender');
    return {
      renderValue: function(x) {
        el.innerHTML = x.ui;
      },

      resize: function(width, height) {
        // TODO: code to re-render the widget with a new size
      }
    };
  }
});
