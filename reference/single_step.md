# Creates a single step to be used inside of a list of steps by the steps function

Creates a single step to be used inside of a list of steps by the steps
function

## Usage

``` r
single_step(
  id,
  title,
  description = NULL,
  icon_class = NULL,
  step_class = NULL
)
```

## Arguments

- id:

  The `input` slot that will be used to access the value.

- title:

  A character that will be the title of the ste

- description:

  A character that will fill the description of the step

- icon_class:

  A character which will be correpond to a fomantic icon class to be
  used in the step

- step_class:

  A character representing a class to be passed to the step

## See also

steps
