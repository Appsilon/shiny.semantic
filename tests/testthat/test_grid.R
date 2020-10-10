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
    shiny::tags$div(id = "area-header", style="grid-area: header; {{ header_custom_css }}", "{{ header }}"),
    shiny::tags$div(id = "area-main", style="grid-area: main; {{ main_custom_css }}", "{{ main }}"),
    shiny::tags$div(id = "area-footer", style="grid-area: footer; {{ footer_custom_css }}", "{{ footer }}")
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

  expected_template <- "<div style=\"
    display: grid;
    height: 100%;
    grid-template-rows: 50px auto 100px;
    grid-template-columns: 100px 2fr 1fr;
    grid-template-areas: &#39;header header header&#39; &#39;menu main right1&#39; &#39;menu main right2&#39;;
    {{ custom_style_grid_container }}\">
      <div id=\"area-header\" style=\"grid-area: header; {{ header_custom_css }}\">{{ header }}</div>
      <div id=\"area-menu\" style=\"grid-area: menu; {{ menu_custom_css }}\">{{ menu }}</div>
      <div id=\"area-main\" style=\"grid-area: main; {{ main_custom_css }}\">{{ main }}</div>
      <div id=\"area-right1\" style=\"grid-area: right1; {{ right1_custom_css }}\">{{ right1 }}</div>
      <div id=\"area-right2\" style=\"grid-area: right2; {{ right2_custom_css }}\">{{ right2 }}</div>
    </div>"

  expected_area_names <- c("header", "menu", "main", "right1", "right2")

  expect_equal(remove_whitespace(myGrid$template), remove_whitespace(expected_template))
  expect_equal(myGrid$area_names, expected_area_names)
})


test_that("test grid", {
  simpleGrid <- grid_template(default = list(areas = rbind(c("a","b"))))

  gridHTML <- grid(simpleGrid,
                   container_style = "",
                   area_styles = list(),
                   a = shiny::tags$div("hello"),
                   b = shiny::tags$div("world"))

  expected_html <- "<div style=\"display: grid;
                                 height: 100%;
                                 grid-template-rows: ;
                                 grid-template-columns: ;
                                 grid-template-areas: &#39;a b&#39;; \">
      <div id=\"area-a\" style=\"grid-area: a; \">
        <div>hello</div>
      </div>
      <div id=\"area-b\" style=\"grid-area: b; \">
        <div>world</div>
      </div>
    </div>"

  expect_equal(remove_whitespace(gridHTML), remove_whitespace(expected_html))

  # Display mode
  gridHTML <- grid(simpleGrid,
                   container_style = "",
                   area_styles = list(),
                   display_mode = TRUE,
                   a = shiny::tags$div("hello"),
                   b = shiny::tags$div("world"))

  expected_html <- "<div style=\"display: grid;
                                 height: 100%;
                                 grid-template-rows: ;
                                 grid-template-columns: ;
                                 grid-template-areas: &#39;a b&#39;; \">
      <div id=\"area-a\" style=\"grid-area: a; \">
        a
      </div>
      <div id=\"area-b\" style=\"grid-area: b; \">
        b
      </div>
    </div>"

  expect_equal(remove_whitespace(gridHTML), remove_whitespace(expected_html))
})
