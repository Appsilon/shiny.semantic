context("grid")

test_that("test data_frame_to_css_grid_template_areas", {
  areas_dataframe <- rbind(
     c("header", "header", "header"),
     c("menu",   "main",   "right1"),
     c("menu",   "main",   "right2")
  )
  expect_equal(
    data_frame_to_css_grid_template_areas(areas_dataframe),
    "'header header header' 'menu main right1' 'menu main right2'"
  )

  areas_dataframe <- rbind(
    c("a", "b"),
    c("c", "d")
  )
  expect_equal(
    data_frame_to_css_grid_template_areas(areas_dataframe),
    "'a b' 'c d'"
  )
})


test_that("test grid_container_css", {
  expected_result <- paste(
    "display: grid;",
    "height: 100%;",
    "grid-template-rows: 50% 50%;",
    "grid-template-columns: 100px 2fr 1fr;",
    "grid-template-areas: 'a a a' 'b b b';",
    "{{ custom_style_grid_container }}"
  )
  expect_equal(
    grid_container_css("'a a a' 'b b b'", c("50%", "50%"), c("100px", "2fr", "1fr")),
    expected_result
  )
})


test_that("test list_of_area_tags", {
  expected_result <- list(
    HTML('<div id="{{ grid_id }}-header" style="grid-area: header; {{ header_custom_css }}">{{ header }}</div>'),
    HTML('<div id="{{ grid_id }}-main" style="grid-area: main; {{ main_custom_css }}">{{ main }}</div>'),
    HTML('<div id="{{ grid_id }}-footer" style="grid-area: footer; {{ footer_custom_css }}">{{ footer }}</div>')
  )
  expect_equal(list_of_area_tags(c("header", "main", "footer")), expected_result)
  expect_equal(list_of_area_tags(c()), list())
})


remove_whitespace <- function (string) gsub('[\n ]', '', as.character(string))

test_that("test grid_template", {
  myGrid <- grid_template(default = list(
   areas = rbind(
     c("header", "header", "header"),
     c("menu",   "main",   "right1"),
     c("menu",   "main",   "right2")
   ),
   rows_height = c("50px", "auto", "100px"),
   cols_width = c("100px", "2fr", "1fr")
  ))

  expected_template <- HTML('
    <style>
      #{{ grid_id }} {
        display: grid;
        height: 100%;
        grid-template-rows: 50px auto 100px;
        grid-template-columns: 100px 2fr 1fr;
        grid-template-areas: \'header header header\' \'menu main right1\' \'menu main right2\';
        {{ custom_style_grid_container }}
      }
    </style>
    <div id="{{ grid_id }}">
      <div id="{{ grid_id }}-header" style="grid-area: header; {{ header_custom_css }}">{{ header }}</div>
      <div id="{{ grid_id }}-menu" style="grid-area: menu; {{ menu_custom_css }}">{{ menu }}</div>
      <div id="{{ grid_id }}-main" style="grid-area: main; {{ main_custom_css }}">{{ main }}</div>
      <div id="{{ grid_id }}-right1" style="grid-area: right1; {{ right1_custom_css }}">{{ right1 }}</div>
      <div id="{{ grid_id }}-right2" style="grid-area: right2; {{ right2_custom_css }}">{{ right2 }}</div>
    </div>
  ')

  expected_area_names <- c("header", "menu", "main", "right1", "right2")

  expect_equal(remove_whitespace(myGrid$template), remove_whitespace(expected_template))
  expect_equal(myGrid$area_names, expected_area_names)
})


test_that("test grid_template with mobile version", {
  myGrid <- grid_template(
    default = list(
      areas = rbind(
        c("header", "header", "header"),
        c("menu",   "main",   "right1"),
        c("menu",   "main",   "right2")
      ),
      rows_height = c("50px", "auto", "100px"),
      cols_width = c("100px", "2fr", "1fr")
    ),
    mobile = list(
      areas = rbind(
        "header",
        "menu",
        "main",
        "right1",
        "right2"
      ),
      rows_height = c("50px", "50px", "auto", "100px", "100px"),
      cols_width = c("100%")
    )
  )

  expected_template <- HTML('
    <style>
      #{{ grid_id }} {
        display: grid;
        height: 100%;
        grid-template-rows: 50px auto 100px;
        grid-template-columns: 100px 2fr 1fr;
        grid-template-areas: \'header header header\' \'menu main right1\' \'menu main right2\';
        {{ custom_style_grid_container }}
      }
    </style>
    <style>
      @media screen and (max-width: 768px) {
        #{{ grid_id }} {
          display: grid;
          height: 100%;
          grid-template-rows: 50px 50px auto 100px 100px;
          grid-template-columns: 100%;
          grid-template-areas: \'header\' \'menu\' \'main\' \'right1\' \'right2\';
          {{ custom_style_grid_container }}
        }
      }
    </style>
    <div id="{{ grid_id }}">
      <div id="{{ grid_id }}-header" style="grid-area: header; {{ header_custom_css }}">{{ header }}</div>
      <div id="{{ grid_id }}-menu" style="grid-area: menu; {{ menu_custom_css }}">{{ menu }}</div>
      <div id="{{ grid_id }}-main" style="grid-area: main; {{ main_custom_css }}">{{ main }}</div>
      <div id="{{ grid_id }}-right1" style="grid-area: right1; {{ right1_custom_css }}">{{ right1 }}</div>
      <div id="{{ grid_id }}-right2" style="grid-area: right2; {{ right2_custom_css }}">{{ right2 }}</div>
    </div>
  ')

  expected_area_names <- c("header", "menu", "main", "right1", "right2")

  expect_equal(remove_whitespace(myGrid$template), remove_whitespace(expected_template))
  expect_equal(myGrid$area_names, expected_area_names)
})


test_that("test grid", {
  simpleGrid <- grid_template(
    default = list(
      areas = rbind(c("a","b")),
      rows_height = "100%",
      cols_width = "50%", "50%"
    )
  )

  gridHTML <- grid(simpleGrid,
                   id = "test_grid",
                   container_style = "",
                   area_styles = list(),
                   a = shiny::tags$div("hello"),
                   b = shiny::tags$div("world"))

  expected_html <- HTML('
    <style>
      #test_grid {
        display: grid;
        height: 100%;
        grid-template-rows: 100%;
        grid-template-columns: 50%;
        grid-template-areas: \'a b\';
      }
    </style>
    <div id="test_grid">
      <div id="test_grid-a" style="grid-area: a; "><div>hello</div></div>
      <div id="test_grid-b" style="grid-area: b; "><div>world</div></div>
    </div>
  ')

  expect_equal(remove_whitespace(gridHTML), remove_whitespace(expected_html))

  # Display mode
  gridHTML <- grid(simpleGrid,
                   id = "test_grid",
                   container_style = "",
                   area_styles = list(),
                   display_mode = TRUE,
                   a = shiny::tags$div("hello"),
                   b = shiny::tags$div("world"))

  expected_html <- HTML('
    <style>
      #test_grid {
        display: grid;
        height: 100%;
        grid-template-rows: 100%;
        grid-template-columns: 50%;
        grid-template-areas: \'a b\';
      }
    </style>
    <div id="test_grid">
      <div id="test_grid-a" style="grid-area: a; ">a</div>
      <div id="test_grid-b" style="grid-area: b; ">b</div>
    </div>
  ')

  expect_equal(remove_whitespace(gridHTML), remove_whitespace(expected_html))
})
