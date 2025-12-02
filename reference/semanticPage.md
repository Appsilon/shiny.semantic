# Semantic UI page

This creates a Semantic page for use in a Shiny app.

## Usage

``` r
semanticPage(
  ...,
  title = "",
  theme = NULL,
  suppress_bootstrap = TRUE,
  margin = "10px"
)
```

## Arguments

- ...:

  Other arguments to be added as attributes of the main div tag wrapper
  (e.g. style, class etc.)

- title:

  A title to display in the browser's title bar.

- theme:

  Theme name or path. Full list of supported themes you will find in
  [`semantic.assets::SUPPORTED_THEMES`](https://rdrr.io/pkg/semantic.assets/man/SUPPORTED_THEMES.html)
  or at http://semantic-ui-forest.com/themes.

- suppress_bootstrap:

  boolean flag that supresses bootstrap when turned on

- margin:

  character with body margin size

## Details

Inside, it uses two crucial options:

\(1\) `shiny.minified` with a logical value, tells whether it should
attach min or full semnatic css or js (TRUE by default). (2)
`shiny.custom.semantic` if this option has not NULL character
`semanticPage` takes dependencies from custom css and js files specified
in this path (NULL by default). Depending on `shiny.minified` value the
folder should contain either "min" or standard version. The folder
should contain: `semantic.css` and `semantic.js` files, or
`semantic.min.css` and `semantic.min.js` in `shiny.minified = TRUE`
mode.

## Examples

``` r
## Only run examples in interactive R sessions
if (interactive()) {
library(shiny)
library(shiny.semantic)

ui <- semanticPage(
  title = "Hello Shiny Semantic!",
  tags$label("Number of observations:"),
  slider_input("obs", value = 500, min = 0, max = 1000),
  segment(
    plotOutput("dist_plot")
  )
)

server <- function(input, output) {
  output$dist_plot <- renderPlot({
    hist(rnorm(input$obs))
  })
}

shinyApp(ui, server)
}
```
