# Render menu link

This function renders horizontal menu item.

## Usage

``` r
render_menu_link(location, title, active_location = "", icon = NULL)
```

## Arguments

- location:

  character url with location

- title:

  name of the page

- active_location:

  name of the active subpage (if matches location then it gets
  highlighted), default empty (`""`)

- icon:

  non-mandatory parameter with icon name

## Value

shiny tag link

## See also

horizontal_menu

## Examples

``` r
render_menu_link("#subpage1", "SUBPAGE")
#> <a class="item" href="#subpage1">
#>   
#>   SUBPAGE
#> </a>
```
