# Vertical layout

Lays out elements vertically, one by one below one another.

## Usage

``` r
vertical_layout(
  ...,
  rows_heights = NULL,
  cell_args = "",
  adjusted_to_page = TRUE
)

verticalLayout(..., fluid = NULL)
```

## Arguments

- ...:

  Unnamed arguments will become child elements of the layout.

- rows_heights:

  Character or numeric vector indicating the widths of the individual
  cells. Recycling will be used if needed.

- cell_args:

  character with additional attributes that should be used for each cell
  of the layout.

- adjusted_to_page:

  if TRUE it adjust elements position in equal spaces to the size of the
  page

- fluid:

  not supported yet (here for consistency with `shiny`)

## Value

vertical layout grid object

## Examples

``` r
if (interactive()) {
  ui <- semanticPage(
    verticalLayout(
      a(href="http://example.com/link1", "Link One"),
      a(href="http://example.com/link2", "Link Two"),
      a(href="http://example.com/link3", "Link Three")
    )
  )
  shinyApp(ui, server = function(input, output) { })
}
if (interactive()) {
  ui <- semanticPage(
    vertical_layout(h1("Title"), h4("Subtitle"), p("paragraph"), h3("footer"))
  )
  shinyApp(ui, server = function(input, output) { })
}
```
