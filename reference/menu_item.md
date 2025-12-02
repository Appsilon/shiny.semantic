# Create Semantic UI Menu Item

This creates a menu item using Semantic UI

## Usage

``` r
menu_item(..., item_feature = "", style = NULL, href = NULL)
```

## Arguments

- ...:

  Content of the menu item: text, icons or labels to be displayed.

- item_feature:

  If required, add additional item feature like 'active', 'header', etc.

- style:

  Style of the item, e.g. "text-align: center".

- href:

  If NULL (default) menu_item is created with 'div' tag. Otherwise it is
  created with 'a' tag, and parameeter defines its href attribute.

## See also

menu
