HTMLWidgets.widget({
  name: 'uirender',
  type: 'output',

  factory: function(el, width, height) {
    return {
      renderValue: function(x) {
        let script = document.createElement('script')
        script.src = `${x.shiny_custom_semantic}/semantic.min.js`
        let css = document.createElement('link')
        css.rel = 'stylesheet'
        css.href = `${x.shiny_custom_semantic}/semantic.min.css`
        document.head.appendChild(css)
        document.head.appendChild(script)

        el.innerHTML = x.ui;
      },

      resize: function(width, height) {
        // TODO: code to re-render the widget with a new size
      }
    };
  }
});
