# Styleguide

## Variables and argument names

Variables follow snake case naming style (unless they overlap with `Shiny` syntax).
Try to give meaningful and self explanatory names.

```r

my_variable <- 33

function(input, another_argument){}

```

## Constants

Constants are defined with capital letter snake case.

```r
COLORS <- c("red", "green", "blue")
```

## Function names

TODO

## Overriding shiny functions

When overriding shiny functions we usually follow `shiny` styling. Usually it requires
creating a function with `shiny.semantic` syntax and then implementing a wrapper that
follows `shiny` syntax.

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

