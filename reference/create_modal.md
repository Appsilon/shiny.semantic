# Allows for the creation of modals in the server side without being tied to a specific HTML element.

Allows for the creation of modals in the server side without being tied
to a specific HTML element.

## Usage

``` r
create_modal(
  ui_modal,
  show = TRUE,
  session = shiny::getDefaultReactiveDomain()
)

showModal(ui, session = shiny::getDefaultReactiveDomain())
```

## Arguments

- ui_modal:

  HTML containing the modal.

- show:

  If the modal should only be created or open when called (open by
  default).

- session:

  Current session.

- ui:

  Same as `ui_modal` in show modal

## See also

modal
