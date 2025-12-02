# Generate CSS string representing grid template areas.

Generate CSS string representing grid template areas.

## Usage

``` r
data_frame_to_css_grid_template_areas(areas_dataframe)
```

## Arguments

- areas_dataframe:

  data.frame of character representing grid areas

## Value

character

## Details

This is a helper function used in grid_template()

    areas_dataframe <- rbind(
       c("header", "header", "header"),
       c("menu",   "main",   "right1"),
       c("menu",   "main",   "right2")
    )

    result == "'header header header' 'menu main right1' 'menu main right2'"
