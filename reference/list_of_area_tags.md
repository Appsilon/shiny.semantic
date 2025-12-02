# Generate list of HTML div elements representing grid areas.

Generate list of HTML div elements representing grid areas.

## Usage

``` r
list_of_area_tags(area_names)
```

## Arguments

- area_names:

  vector with area names

## Value

list of `shiny::tags$div`

## Details

This is a helper function used in grid_template()

      list_of_area_tags(c("header", "main", "footer"))

returns the following list:

      [[1]] <div id="{{ grid_id }}-header" style="grid-area: header; {{ header_custom_css }}">{{ header }}</div>
      [[2]] <div id="{{ grid_id }}-main" style="grid-area: main; {{ main_custom_css }}">{{ main }}</div>
      [[3]] <div id="{{ grid_id }}-footer" style="grid-area: footer; {{ footer_custom_css }}">{{ footer }}</div>
