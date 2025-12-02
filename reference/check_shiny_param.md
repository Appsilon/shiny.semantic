# Checks whether argument included as shiny exclusive parameter

A quick function to check a shiny.semantic wrapper of a shiny function
to see whether any extra arguments are called that aren't required for
the shiny.semantic version

## Usage

``` r
check_shiny_param(name, func, ...)
```

## Arguments

- name:

  Function argument name

- func:

  Name of the function in the

- ...:

  Arguments passed to the shiny.semantic version of the shiny function

## Value

If the shiny exclusive argument is called in a shiny.semantic, then a
message is posted in the UI
