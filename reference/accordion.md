# Accordion UI

In accordion you may display a list of elements that can be hidden or
shown with one click.

## Usage

``` r
accordion(
  accordion_list,
  fluid = TRUE,
  active_title = "",
  styled = TRUE,
  custom_style = ""
)
```

## Arguments

- accordion_list:

  list with lists with fields: \`title\` and \`content\`

- fluid:

  if accordion is fluid then it takes width of parent div

- active_title:

  if active title matches \`title\` from `accordion_list` then this
  element is active by default

- styled:

  if switched of then raw style (no boxes) is used

- custom_style:

  character with custom style added to CSS of accordion (advanced use)

## Value

shiny tag list with accordion UI

## Examples

``` r
if (interactive()) {
library(shiny)
library(shiny.semantic)
accordion_content <- list(
  list(title = "AA", content = h2("a a a a")),
  list(title = "BB", content = p("b b b b"))
)
shinyApp(
  ui = semanticPage(
    accordion(accordion_content, fluid = F, active_title = "AA",
              custom_style = "background: #babade;")
  ),
  server = function(input, output) {}
)
}
```
