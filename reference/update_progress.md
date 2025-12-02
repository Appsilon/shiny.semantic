# Update progress Semantic UI component

Change the value of a
[`progress`](https://appsilon.github.io/shiny.semantic/reference/progress.md)
input on the client.

## Usage

``` r
update_progress(
  session,
  input_id,
  type = c("increment", "decrement", "label", "value"),
  value = 1
)
```

## Arguments

- session:

  The `session` object passed to function given to `shinyServer`.

- input_id:

  The id of the input object

- type:

  Whether you want to increase the progress bar (`"increment"`),
  decrease the progress bar (`"decrement"`), update the label `"label"`,
  or set it to a specific value (`"value"`)

- value:

  The value to increase/decrease by, or the value to be set to
