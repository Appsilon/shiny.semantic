# Generate template string representing CSS styles of grid container div.

Generate template string representing CSS styles of grid container div.

## Usage

``` r
grid_container_css(css_grid_template_areas, rows_height, cols_width)
```

## Arguments

- css_grid_template_areas:

  character, CSS value for grid-template-areas

- rows_height:

  vector of character

- cols_width:

  vector of character

## Value

character

## Details

This is a helper function used in grid_template()

      grid_container_css(
        "'a a a' 'b b b'",
        c("50%", "50%"),
        c("100px", "2fr", "1fr")
      )

returns

      "display: grid;
       height: 100%;
       grid-template-rows: 50% 50%;
       grid-template-columns: 100px 2fr 1fr;
       grid-template-areas: 'a a a' 'b b b';
       {{ custom_style_grid_container }}"
