HTMLWidgets.widget({

  name: 'uirender',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    return {

      renderValue: function(x) {
        console.log(x)

        // TODO: code to render the widget, e.g.
        el.innerHTML = x.ui;

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
