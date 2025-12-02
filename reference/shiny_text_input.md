# Create universal Shiny text input binding

Universal binding for Shiny text input on custom user interface. Value
of this input is extracted via jQuery using \$().val() function. This
function is just a simple binding over shiny_input. Please take a look
at shiny_input documentation for more information.

## Usage

``` r
shiny_text_input(...)
```

## Arguments

- ...:

  Possible arguments are the same as in shiny_input() method: input_id,
  shiny_ui, value. Type is already predefined as "text"

## Examples

``` r
library(shiny)
library(shiny.semantic)
# Create a color picker
uirender(
  tagList(
    div(class = "ui input",
        style = NULL,
        "Color picker",
        shiny_text_input(
          "my_id",
          tags$input(type = "color", name = "my_id", value = "#ff0000"))
    )
  ))

{"x":{"ui":"<div class=\"ui input\">\n  Color picker\n  <input type=\"color\" name=\"my_id\" value=\"#ff0000\" class=\"shiny-custom-input \" id=\"my_id\" data-value-type=\"text\"/>\n<\/div>"},"evals":[],"jsHooks":[]}
```
