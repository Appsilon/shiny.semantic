# Flow layout

Lays out elements in a left-to-right, top-to-bottom arrangement. The
elements on a given row will be top-aligned with each other.

## Usage

``` r
flow_layout(
  ...,
  cell_args = list(),
  min_cell_width = "208px",
  max_cell_width = "1fr",
  column_gap = "12px",
  row_gap = "0px"
)

flowLayout(..., cellArgs = list())
```

## Arguments

- ...:

  Unnamed arguments will become child elements of the layout. Named
  arguments will become HTML attributes on the outermost tag.

- cell_args:

  Any additional attributes that should be used for each cell of the
  layout.

- min_cell_width:

  The minimum width of the cells.

- max_cell_width:

  The maximum width of the cells.

- column_gap:

  The spacing between columns.

- row_gap:

  The spacing between rows.

- cellArgs:

  Same as `cell_args`.

## Details

The width of the elements and spacing between them is configurable.
Lengths can be given as numeric values (interpreted as pixels) or
character values (interpreted as CSS lengths). With the default settings
this layout closely resembles the `flowLayout` from Shiny.

## Examples

``` r
if (interactive()) {
  ui <- semanticPage(
    flow_layout(
      numericInput("rows", "How many rows?", 5),
      selectInput("letter", "Which letter?", LETTERS),
      sliderInput("value", "What value?", 0, 100, 50)
    )
  )
  shinyApp(ui, server = function(input, output) {})
}
```
