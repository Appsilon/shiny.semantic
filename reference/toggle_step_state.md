# Toggle step state

Toggle step state

## Usage

``` r
toggle_step_state(id, state = TRUE, automatic_steps = TRUE, asis = TRUE)
```

## Arguments

- id:

  ID of step to be toggled

- state:

  State of the step, `TRUE` stands for enabled

- automatic_steps:

  Whether to toggle focus of next step automatically

- asis:

  When used inside of Shiny module, `TRUE` will disable adding the
  namespace to `id`

## See also

steps
