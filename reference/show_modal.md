# Show, Hide or Remove Semantic UI modal

This displays a hidden Semantic UI modal.

## Usage

``` r
show_modal(id, session = shiny::getDefaultReactiveDomain(), asis = TRUE)

remove_modal(id, session = shiny::getDefaultReactiveDomain(), asis = TRUE)

remove_all_modals(session = shiny::getDefaultReactiveDomain())

removeModal(session = shiny::getDefaultReactiveDomain())

hide_modal(id, session = shiny::getDefaultReactiveDomain(), asis = TRUE)
```

## Arguments

- id:

  ID of the modal that will be displayed.

- session:

  The `session` object passed to function given to `shinyServer`.

- asis:

  A boolean indicating if the id must be handled as is (TRUE) or FALSE
  if it meants to be namespaced

## See also

modal
