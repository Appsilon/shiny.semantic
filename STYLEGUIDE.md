# Styleguide

## Variables and argument names

Variables follow snake case naming style (unless they overlap with `Shiny` syntax).
Try to give meaningful and self explanatory names.

```r

my_variable <- 33

function(input, another_argument){}

```

## Constants

Constants are defined with capital letter snake case and kept in the
`constants.R` script (unless they're internal).

```r
COLORS <- c("red", "green", "blue")
```

## Function names

Function are called with `snake_case`.

- Functions that define UI should contain name of the element, eg. `box`, `horizontal_menu`

- Functions that define active elements should contain `input` in their name, eg. `checkbox_input`.

## Overriding shiny functions

When overriding shiny functions we usually follow `shiny` styling. Usually it requires
creating a function with `shiny.semantic` syntax and then implementing a wrapper that
follows `shiny` syntax.

**!!** Here argument names can actually follow `camelCase` syntax.

Example:

```r
# semantic styling
action_button <- function(input_id, label, icon = NULL, width = NULL, ...) {
  ...
}

# shiny styling
actionButton <- function(inputId, label, icon = NULL, width = NULL, ...) {
  ...
}
```

