# Update slider Semantic UI component

Change the value of a
[`slider_input`](https://appsilon.github.io/shiny.semantic/reference/slider.md)
input on the client.

## Usage

``` r
update_slider(session, input_id, value)

update_range_input(session, input_id, value, value2)

updateSliderInput(session, inputId, value, ...)
```

## Arguments

- session:

  The `session` object passed to function given to `shinyServer`.

- input_id:

  The id of the input object

- value:

  The value to be selected for the sldier (lower value if using range).

- value2:

  The upper value of the range.

- inputId:

  Input name.

- ...:

  additional arguments

## See also

slider_input

## Examples

``` r
## Only run this example in interactive R sessions
if (interactive()) {
  shinyApp(
    ui = semanticPage(
      p("The first slider controls the second"),
      slider_input("control", "Controller:", min = 0, max = 20, value = 10,
                   step = 1),
      slider_input("receive", "Receiver:", min = 0, max = 20, value = 10,
                   step = 1)
    ),
    server = function(input, output, session) {
      observe({
        update_slider(session, "receive", value = input$control)
      })
    }
  )
}
```
