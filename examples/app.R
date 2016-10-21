library(shiny)
library(shinyjs)
library(semanticui)
library(magrittr)
library(highlighter)
library(formatR)

demo <- function(code) {
  div(class = "ui raised segment",
    code,
    div(style="width: 100%; height:10px"),
    highlight(formatR::tidy_source(width.cutoff = 40, text = deparse(substitute(code)))$text.tidy)
  )
}

jsCode <- "
  $('.ui.dropdown').dropdown({});
  $('.rating').rating('setting', 'clearable', true);
"

ratedPlot <- function(name) {
  div(class = "ui raised segment",
      input(placeholder ="Filip"),
      div(class = "ui star rating")
  )
}
ratedMap <- function(name) {
  div(class = "ui raised segment",
      input(placeholder ="Filip"),
      div(class = "ui star rating")
  )
}
card <- function(content) {
  div(class="ui card",
      div(class="content",
          div(class="right floated meta", "14h"),
          img(class="ui avatar image", src="images/elliot.jpg"),
          "Elliot"
      ),
      content,
      div(class="content",
          span(class="right floated", uiicon("heart outline like"), "17 likes"),
          uiicon("comment"),
          "3 comments"
      ),
      div(class="extra content",
          div(class="ui large transparent left icon input",
              uiicon("heart ouline"),
              tags$input(type="text", placeholder ="Add Comment...")
          )
      )
  )
}

breadcrumb <- function() {
  div(class="ui huge breadcrumb", style="background: transparent",
      a(class="section", "Portfolio"),
      div(class="divider", "/"),
      a(class="section", "Agriculture"),
      div(class="divider", "/"),
      a(class="section", "Rice")
  )
}

header <- function() {
  div(
    h1(class="ui header", id="header", "Headers"),
    demo(h1(class="ui header", "First header")),
    demo(h2(class="ui header", "Second header")),
    demo(h2(class="ui icon header",
            uiicon("settings"),
            div(class="content", "Account Settings",
                div(class="sub header", "Manage your account")))),
    demo(h2(class="ui header", uiicon("plug"), div(class="content", "Second header"))),
    demo(h2(class="ui header", uiicon("settings"),
            div(class="content", "Second header",
                div(class="sub header", "Manage preferences"))))
  )
}
button <- function() {
  div(
    h1(class="ui header", id="button", "Button"),
    demo(div(class = "ui raised segment", "Raised segment")),
    demo(div(class = "ui button", "Button")),
    demo(div(class = "ui basic button", "Basic button")),
    demo(div(class = "ui basic button", uiicon("user"), "Icon button")),
    demo(div(class = "ui olive basic button", uiicon("user"), "Color icon button")),
    demo(div(class = "ui animated button", tabindex="0",
             div(class="visible content", "Next"),
             div(class="hidden content", "Step"))),
    demo(div(class = "ui labeled button", tabindex="0",
             div(class="ui button", uiicon("heart"), "Like"),
             a(class="ui basic label", "2,048"))),
    demo(div(class = "ui mini button", "Mini")),
    demo(div(class = "ui tiny button", "Tiny")),
    demo(div(class = "ui small button", "Small")),
    demo(div(class = "ui medium button", "Medium")),
    demo(div(class = "ui large button", "Large")),
    demo(div(class = "ui big button", "Big")),
    demo(div(class = "ui huge button", "Huge")),
    demo(div(class = "ui massive button", "Massive")),
    demo(div(class = "ui red button", "Red")),
    demo(div(class = "ui orange button", "Orange")),
    demo(div(class = "ui yellow button", "Yellow")),
    demo(div(class = "ui olive button", "Olive")),
    demo(div(class = "ui green button", "Green")),
    demo(div(class = "ui teal button", "Teal")),
    demo(div(class = "ui blue button", "Blue")),
    demo(div(class = "ui violet button", "Violet")),
    demo(div(class = "ui purple button", "Purple")),
    demo(div(class = "ui pink button", "Pink")),
    demo(div(class = "ui brown button", "Brown")),
    demo(div(class = "ui grey button", "Grey")),
    demo(div(class = "ui black button", "Black"))
  )
}
divider <- function() {
  div(
    h1(class="ui header", id="divider", "Divider"),
    demo(div(class="ui divider")),
    demo(div(class="ui horizontal divider", "Or")),
    demo(div(class="ui horizontal divider", uiicon("tag"), "Description"))
  )
}
uiinput <- function() {
  div(
    h1(class="ui header", id="input", "Input"),
    demo(div(class="ui input", input(placeholder="Search..."))),
    demo(div(class="ui icon input", input(placeholder="Search..."), uiicon("search"))),
    demo(div(class="ui icon input", input(placeholder="Search..."), uiicon("circular link search"))),
    demo(div(class="ui right labeled input",
             tags$input(type="text", placeholder="Enter weight..."),
             div(class="ui basic label" ,"kg")))
  )
}
section <- function() {
  div(
    h1(class="ui header", "Section"),
    demo(h1(class="ui header", "First header"))
  )
}

sidebar <- function() {
  div(class="ui sidebar inverted vertical visible menu",
      div(class="item",
          div(class="active header", "Elements"),
          div(class="menu",
              a(class="item", href="#header", "Header"),
              a(class="item", href="#divider", "Divider"),
              a(class="item", href="#input", "Input"),
              a(class="item", href="#button", "Button"))))
}

ui <- function() {
  shinyUI(semanticPage(
    useShinyjs(),
    sidebar(),
    div(style="margin-left: 210px",
      div(class="ui container",
          header(),
          button(),
          divider(),
          uiinput(),
          div(class = "ui raised segment",
              div(class="ui cards",
                  card(div(class="image", img(src="/images/wireframe.png")))
              )
          ),
          div(class="ui stackable two column grid",
              div(class="column", ratedPlot("samplePlot")),
              div(class="column", ratedMap("sampleMap"))
          )
      )
    )
  ))
}

server <- shinyServer(function(input, output) {
  runjs(jsCode)
})
shinyApp(ui = ui(), server = server)

