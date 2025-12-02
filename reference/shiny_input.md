# Create universal Shiny input binding

Universal binding for Shiny input on custom user interface. Using this
function one can create various inputs ranging from text, numerical,
date, dropdowns, etc. Value of this input is extracted via jQuery using
\$().val() function and default exposed as serialized JSON to the Shiny
server. If you want to change type of exposed input value specify it via
type param. Currently list of supported types is "JSON" (default) and
"text".

## Usage

``` r
shiny_input(input_id, shiny_ui, value = NULL, type = "JSON")
```

## Arguments

- input_id:

  String with name of this input. Access to this input within server
  code is normal with input\[\[input_id\]\].

- shiny_ui:

  UI of HTML component presenting this input to the users. This UI
  should allow to extract its value with jQuery \$().val() function.

- value:

  An optional argument with value that should be set for this input. Can
  be used to store persisten input valus in dynamic UIs.

- type:

  Type of input value (could be "JSON" or "text").

## Examples

``` r
library(shiny)
library(shiny.semantic)
# Create a week field
uirender(
  tagList(
    div(class = "ui icon input",
        style = NULL,
        "",
        shiny_input(
          "my_id",
          tags$input(type = "week", name = "my_id", min = NULL, max = NULL),
          value = NULL,
          type = "text"),
        icon("calendar"))
  )
)

{"x":{"ui":"<div class=\"ui icon input\">\n  \n  <input type=\"week\" name=\"my_id\" class=\"shiny-custom-input \" id=\"my_id\" data-value-type=\"text\"/>\n  <i class=\"far fa-calendar\" role=\"presentation\" aria-label=\"calendar icon\"><\/i>\n<\/div>"},"evals":[],"jsHooks":[]}
```
