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
    "{custom_style_grid_container}"
  )
  expect_equal(
    grid_container_css("'a a a' 'b b b'", c("50%", "50%"), c("100px", "2fr", "1fr")),
    expected_result
  )
})


test_that("test list_of_area_tags", {
  expected_result <- list(
    shiny::tags$div(style="grid-area: header; {custom_style_grid_area_header}", "{{ header }}"),
    shiny::tags$div(style="grid-area: main; {custom_style_grid_area_main}", "{{ main }}"),
    shiny::tags$div(style="grid-area: footer; {custom_style_grid_area_footer}", "{{ footer }}")
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
    {custom_style_grid_container}\">
      <div style=\"grid-area: header; {custom_style_grid_area_header}\">{{ header }}</div>
      <div style=\"grid-area: menu; {custom_style_grid_area_menu}\">{{ menu }}</div>
      <div style=\"grid-area: main; {custom_style_grid_area_main}\">{{ main }}</div>
      <div style=\"grid-area: right1; {custom_style_grid_area_right1}\">{{ right1 }}</div>
      <div style=\"grid-area: right2; {custom_style_grid_area_right2}\">{{ right2 }}</div>
    </div>"

  expected_area_names <- c("header", "menu", "main", "right1", "right2")

  expect_equal(remove_whitespace(myGrid$template), remove_whitespace(expected_template))
  expect_equal(myGrid$area_names, expected_area_names)
})



test_that("test apply_custom_styles_to_html_template", {
  template <- "<div style=\"display: grid;
                            grid-template-areas: &#39;area1 area2&#39;;
                            {custom_style_grid_container}\">
      <div style=\"grid-area: header; {custom_style_grid_area_area1}\">{{ area1 }}</div>
      <div style=\"grid-area: menu; {custom_style_grid_area_area2}\">{{ area2 }}</div>
    </div>"

  styled_template <- apply_custom_styles_to_html_template(template,
    area_names = c("area1", "area2"),
    container_style = "border: 1px solid #f00",
    area_styles = list(area1 = "font-size: 10px", area2 = "background: #000"))

  expected_template <- "<div style=\"display: grid;
                                     grid-template-areas: &#39;area1 area2&#39;;
                                     border: 1px solid #f00\">
      <div style=\"grid-area: header; font-size: 10px\">{ area1 }</div>
      <div style=\"grid-area: menu; background: #000\">{ area2 }</div>
    </div>"

  expect_equal(remove_whitespace(styled_template), remove_whitespace(expected_template))
})


test_that("test prepare_mustache_for_html_template", {
  template <- "<div>{ area1 }</div><div>{ area2 }</div>"

  expect_equal(prepare_mustache_for_html_template(template, area_names = c("area1", "area2")),
               "<div>{{ area1 }}</div><div>{{ area2 }}</div>")

  expect_equal(prepare_mustache_for_html_template(template, area_names = c("area1", "area2"), display_mode = TRUE),
               "<div>< area1 ></div><div>< area2 ></div>")
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
      <div style=\"grid-area: a; \">
        <div>hello</div>
      </div>
      <div style=\"grid-area: b; \">
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
      <div style=\"grid-area: a; \">
        < a >
      </div>
      <div style=\"grid-area: b; \">
        < b >
      </div>
    </div>"

  expect_equal(remove_whitespace(gridHTML), remove_whitespace(expected_html))
})
