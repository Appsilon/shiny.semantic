library(shiny)
library(shinyjs)
library(shiny.semantic)
library(magrittr)
library(highlighter)
library(formatR)
library(httr)
library(rjson)

demo <- function(code) {
  div(class = "ui raised segment",
      code,
      div(style = "width: 100%; height:10px"),
      highlight(formatR::tidy_source(width.cutoff = 40,
                                     text = deparse(substitute(code)))$text.tidy)
  )
}

options(semantic.themes = TRUE)

input <- function(class = "ui input", style = "", type = "text", name = "", placeholder = "") {
  div(class = class, style = style,
      tags$input(type = type, name = name, placeholder = placeholder)
  )
}

jsCode <- "
$('.accordion').accordion({selector: {trigger: '.title .icon'}}).accordion('close');
$('.ui.dropdown').dropdown({});
$('.rating').rating('setting', 'clearable', true);
"

header <- function() {
  div(
    h1(class="ui header", id="header", "Headers"),
    demo(h1(class="ui header", "First header")),
    demo(h2(class="ui header", "Second header")),
    demo(h2(class="ui icon header",
            icon("settings"),
            div(class="content", "Account Settings",
                div(class="sub header", "Manage your account")))),
    demo(h2(class="ui header", icon("plug"), div(class="content", "Second header"))),
    demo(h2(class="ui header", icon("settings"),
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
breadcrumb <- function() {
  div(
    h1(class="ui header", id="breadcrumb", "Breadcrumb"),
    demo(div(class="ui breadcrumb",
             a(class="section", "Home"),
             div(class="divider", "/"),
             a(class="section", "Store"),
             div(class="divider", "/"),
             a(class="section", "T-shirts"))),
    demo(div(class="ui breadcrumb",
             a(class="section", "Home"),
             uiicon("right angle divider"),
             a(class="section", "Store"),
             uiicon("right angle divider"),
             a(class="section", "T-shirts"))),
    demo(div(class="ui huge breadcrumb",
             a(class="section", "Home"),
             uiicon("right angle divider"),
             a(class="section", "Store"),
             uiicon("right angle divider"),
             a(class="section", "T-shirts")))
  )
}
accordion <- function() {
  div(
    h1(class="ui header", id="accordion", "Accordion"),
    demo(div(class="ui styled accordion",
             div(class="active title", uiicon('dropdown icon'), "What is dog?"),
             div(class="active content", p("A dog is a type of domesticated animal. Known for its loyalty and faithfulness, it can be found as a welcome guest in many households across the world.")),
             div(class="title", uiicon('dropdown icon'), "What kinds of dogs are there?"),
             div(class="content", p("There are many breeds of dogs. Each breed varies in size and temperament. Owners often select a breed of dog that they find to be compatible with their own lifestyle and desires from a companion."))
    )
    )
  )
}
grid <- function() {
  div(
    h1(class="ui header", id="grid", "Grid"),
    demo(div(class="ui grid",
             div(class="four wide column", "Column"),
             div(class="four wide column", "Column"),
             div(class="four wide column", "Column"),
             div(class="four wide column", "Column"))),
    demo(div(class="ui stackable four column grid",
             div(class="column", "Column"),
             div(class="column", "Column"),
             div(class="column", "Column"),
             div(class="column", "Column")))
  )
}
card <- function() {
  div(
    h1(class="ui header", id="card", "Card"),
    demo(
      uicard(
        div(class="content",
            div(class="header", "Elliot Fu"),
            div(class="meta", "Friend"),
            div(class="description", "Elliot Fu is a film-maker from New York.")
        )
      )
    ),
    demo(
      uicards(
        class = "three",
        mtcars %>% tibble::rownames_to_column() %>% head %>%
          purrrlyr::by_row(~ {
            uicard(
              div(class="content",
                  div(class="header", .$rowname),
                  div(class="meta", paste("Number of cylinders:", .$cyl)),
                  div(class="description", paste("1/4 mile time:", .$qsec))
              )
            )
          }) %>% {.$.out}
      )
    ),
    demo(
      uicard(
        div(class="content",
            div(class="header", "Elliot Fu"),
            div(class="meta", "Friend"),
            div(class="description", "Elliot Fu is a film-maker from New York.")
        )
      )
    ),
    demo(
      div(class="ui card",
          div(class="content",
              div(class="right floated meta", "14h"),
              img(class="ui avatar image", src="images/elliot.jpg"),
              "Elliot"
          ),
          div(class="image", img(src="images/wireframe.png")),
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
    )
  )
}
uilabel <- function() {
  div(
    h1(class="ui header", id="label", "Label"),
    demo(h1(class="ui header", "First header"))
  )
}

rating <- function() {
  div(
    h1(class="ui header", id="rating", "Rating"),
    demo(div(class = "ui star rating"))
  )
}
tabs <- function () {
  div(
    h1(class="ui header", id="tabset", "Tabset"),
    demo(
      tabset(list(
        list(menu = div("First link"), content = div("First content")),
        list(menu = div("Second link"), content = div("Second content")),
        list(menu = div("Third link"), content = div("Third content"))
      ))
    )
  )
}
uilist_demo <- function() {
  list_content <- data.frame(
    header = paste("Header", 1:5),
    description = paste("Description", 1:5),
    stringsAsFactors = FALSE,
    icon = "alarm"
  )

  div(
    h1(class="ui dividing header", id="list", "List"),
    demo(uilist(list_content, is_divided = FALSE)),
    demo(uilist(list_content, is_divided = TRUE))
  )
}

section <- function() {
  div(
    h1(class="ui dividing header", id="section", "Section"),
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
              a(class="item", href="#label", "Label"),
              a(class="item", href="#list", "List"),
              a(class="item", href="#button", "Button"))),
      div(class="item",
          div(class="active header", "Collections"),
          div(class="menu",
              a(class="item", href="#grid", "Grid"),
              a(class="item", href="#breadcrumb", "Breadcrumb"))),
      div(class="item",
          div(class="active header", "Views"),
          div(class="menu",
              a(class="item", href="#card", "Card"))),
      div(class="item",
          div(class="active header", "Modules"),
          div(class="menu",
              a(class="item", href="#accordion", "Accordion"),
              a(class="item", href="#rating", "Rating"),
              a(class="item", href="#tabset", "Tabset")
          )))
}
css <- "
#examples > div > .header {
margin-top: 1em;
}"

ui <- function() {
  shinyUI(semanticPage(
    tags$head(tags$style(HTML(css))),
    useShinyjs(),
    sidebar(),
    div(style="margin-left: 210px",
        div(id="examples", class="ui container",
            header(),
            button(),
            divider(),
            uiinput(),
            uilabel(),
            uilist_demo(),
            grid(),
            breadcrumb(),
            card(),
            accordion(),
            rating(),
            tabs()
        )
    ), theme = "yeti" # a list of all available themes sits in SUPPORTED_THEMES
  ))
}

server <- shinyServer(function(input, output, session) {
  runjs(jsCode)
})

shinyApp(ui = ui(), server = server)
