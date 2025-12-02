# Render semanticui htmlwidget

htmlwidget that adds semanticui dependencies and renders in viewer or
rmarkdown.

## Usage

``` r
uirender(ui, width = NULL, height = NULL, element_id = NULL)
```

## Arguments

- ui:

  UI, which will be wrapped in an htmlwidget.

- width:

  Fixed width for widget (in css units). The default is NULL, which
  results in intelligent automatic sizing.

- height:

  Fixed height for widget (in css units). The default is NULL, which
  results in intelligent automatic sizing.

- element_id:

  Use an explicit element ID for the widget (rather than an
  automatically generated one).

## Examples

``` r
library(shiny)
library(shiny.semantic)
uirender(
  card(
    div(
      class="content",
      div(class="header", "Elliot Fu"),
      div(class="meta", "Friend"),
      div(class="description", "Elliot Fu is a film-maker from New York.")
    )
  )
)

{"x":{"ui":"<div class=\"ui card \">\n  <div class=\"content\">\n    <div class=\"header\">Elliot Fu<\/div>\n    <div class=\"meta\">Friend<\/div>\n    <div class=\"description\">Elliot Fu is a film-maker from New York.<\/div>\n  <\/div>\n<\/div>"},"evals":[],"jsHooks":[]}
```
