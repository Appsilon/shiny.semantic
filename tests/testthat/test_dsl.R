context("dsl")

test_that("test uiicon type and input values", {
  # type
  expect_is(uiicon("deaf"), "shiny.tag")
  # empty input
  si_str <- as.character(uiicon("deaf"))
  expect_true(any(grepl("<i class=\"deaf icon\"></i>",
                        si_str, fixed = TRUE)))
  # multiple input
  si_str <- as.character(uiicon("deaf", "a", "b", "c"))
  expect_true(any(grepl("<i class=\"deaf icon\">\n  a\n  b\n  c\n</i>",
                        si_str, fixed = TRUE)))
})

test_that("test uimessage type and input values", {
  # type
  expect_is(uimessage(shiny::p("a"), c("b", "c")),
            "shiny.tag")
  # empty input
  expect_error(uimessage())
  # text input
  si_str <- as.character(uimessage(shiny::p("a"), "abcb"))
  expect_true(any(grepl("<div class=\"header\">",
                        si_str, fixed = TRUE)))
  expect_true(any(grepl("abcb", si_str, fixed = TRUE)))
})

test_that("test uilabel type and input values", {
  # type
  expect_is(uilabel(p("a")), "shiny.tag")
  # test input
  si_str <- as.character(uilabel(p("a")))
  expect_true(any(grepl("class=\"ui label \"",
                        si_str, fixed = TRUE)))
  expect_match(as.character(uilabel()), "<a class=\"ui label \"></a>")

})

test_that("test tabset type and input values", {
  # test empty input
  expect_error(tabset())
  # check if contains links
  si_str <- as.character(tabset(list(
    list(menu = div("First link"), content = div("First content")),
    list(menu = div("Second link"), content = div("Second content"))))
  )
  expect_true(any(grepl("<div>First link</div>", si_str, fixed = TRUE)))
  # check if contains content
  expect_true(any(grepl("<div>Second content</div>", si_str, fixed = TRUE)))
  # check if interactive
  expect_true(any(grepl("onVisible: function(target) {", si_str, fixed = TRUE)))
})


test_that("test uiheader", {
  # test missing input
  expect_error(uiheader())
  expect_error(uiheader("title"))
  si_str <- as.character(uiheader(p("title"), "description"))
  expect_true(any(grepl(paste0("<div class=\"sub header\">",
                               "description</div>"), si_str, fixed = TRUE)))
  # check icons
  si_str_with_icon <- as.character(uiheader("title", "description", "car"))
  expect_true(any(grepl(paste0("<div class=\"sub header\">",
                               "description</div>"), si_str, fixed = TRUE)))
  expect_true(any(grepl(paste0("<i class=\"car icon\"></i>"),
                        si_str_with_icon, fixed = TRUE)))
})

test_that("test uicards", {
  # test missing input
  expect_match(as.character(uicards()), "<div class=\"ui cards \"></div>")
  # test class
  expect_match(as.character(uicards(class = "three")),
               "<div class=\"ui cards three\"></div>")
})

test_that("test uicard", {
  # test missing input
  expect_match(as.character(uicard()), "<div class=\"ui card \"></div>")
  # test class
  expect_match(as.character(uicard(class = "one")),
               "<div class=\"ui card one\"></div>")
})

test_that("test uisegment", {
  # test missing input
  expect_match(as.character(uisegment()), "<div class=\"ui segment \"></div>")
  # test class
  expect_match(as.character(uisegment(class = "one")),
               "<div class=\"ui segment one\"></div>")
})

test_that("test uiform", {
  # test missing input
  expect_match(as.character(uiform()), "<form class=\"ui form \"></form>")
  # test class
  expect_match(as.character(uiform(class = "form")),
               "<form class=\"ui form form\"></form>")
})

test_that("test uifields", {
  # test missing input
  expect_match(as.character(uifields()), "<div class=\"fields \"></div>")
  # test class
  expect_match(as.character(uifields(class = "fl")),
               "<div class=\"fields fl\"></div>")
})

test_that("test uifield", {
  # test missing input
  expect_match(as.character(uifield()), "<div class=\"field \"></div>")
  # test class
  expect_match(as.character(uifield(class = "fl")),
               "<div class=\"field fl\"></div>")
})

test_that("test label", {
  # type
  expect_is(label(), "shiny.tag")

  expect_match(as.character(label()), "<label></label>")
})

test_that("test uicheckbox", {
  # test missing input
  expect_match(as.character(uicheckbox()), "<div class=\"ui checkbox \"></div>")
  # test class
  expect_match(as.character(uicheckbox(class = "ch")),
               "<div class=\"ui checkbox  ch\"></div>")
})


test_that("test uimessage", {
  # test missing input
  expect_error(uimessage())
  si_str <- as.character(
    uimessage(shiny::h2("a"), c("b", "c"))
  )
  # test output
  expect_true(any(grepl("<div class=\"ui message \">", si_str, fixed = TRUE)))
  expect_true(any(grepl("<ul class=\"list\">", si_str, fixed = TRUE)))
  expect_true(any(grepl("<li>b</li>", si_str, fixed = TRUE)))
  expect_error(uimessage(shiny::h2("a"), c("b", "c"), type = "icon"),
               "Type 'icon' requires an icon!")
})

test_that("test dropdown", {
  # test missing input
  expect_error(dropdown())
  expect_error(dropdown("dd"))
  # test output
  si_str <- as.character(
    dropdown("simple_dropdown", LETTERS, value = "A")
  )
  expect_true(any(grepl("<div class=\"item\" data-value=\"C\">C</div>",
                        si_str, fixed = TRUE)))
  expect_true(any(grepl(
    "<input type=\"hidden\" name=\"simple_dropdown\" value=\"A\"", si_str, fixed = TRUE
  )))
})

test_that("test dropdown header", {
  # test output
  si_str <- as.character(
    dropdown("header_dropdown",
             list("LETTERS" = LETTERS, "month.name" = month.name),
             value = "A")
  )

  expect_true(any(grepl("<div class=\"item\" data-value=\"C\">C</div>",
                        si_str, fixed = TRUE)))
  expect_true(any(grepl(
    "<input type=\"hidden\" name=\"header_dropdown\" value=\"A\"", si_str, fixed = TRUE
  )))
  expect_true(any(grepl("<div class=\"header\">month.name</div>",
                        si_str, fixed = TRUE)))
  expect_true(any(grepl("<div class=\"divider\"></div>",
                        si_str, fixed = TRUE)))
})


test_that("test menu_item", {
  # test missing input
  expect_match(as.character(menu_item()),
               "<div class=\"item \"></div>")
  #test with icon
  si_str <- as.character(
    menu_item(uiicon("add icon"), "New tab")
  )
  expect_true(any(grepl("<i class=\"add icon icon\"></i>",
                        si_str, fixed = TRUE)))
  expect_true(any(grepl("New tab",
                        si_str, fixed = TRUE)))
})

test_that("test uimenu", {
  # test missing input
  expect_match(as.character(uimenu()), "<div class=\"ui menu \"></div>")
  #test with icon
  si_str <- as.character(
    uimenu(menu_item(uiicon("add icon"), "New tab"), type = "right")
  )
  expect_true(any(grepl("<i class=\"add icon icon\"></i>",
                        si_str, fixed = TRUE)))
  expect_true(any(grepl("New tab",
                        si_str, fixed = TRUE)))
})

test_that("test menu_header", {
  # test missing input
  expect_match(as.character(menu_header()),
               "<div class=\"item header\"></div>")
  # test class
  expect_match(as.character(menu_header(class = "ch")),
               "<div class=\"item header ch\"></div>")
})

test_that("test menu_divider", {
  # test missing input
  expect_match(as.character(menu_divider()),
               "<div class=\"divider\"></div>")
})

test_that("test uilist", {
  # test missing input
  expect_error(uilist())
})
