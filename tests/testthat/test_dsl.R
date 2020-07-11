context("dsl")

test_that("test icon type and input values", {
  # type
  expect_is(icon("deaf"), "shiny.tag")
  # empty input
  si_str <- as.character(icon("deaf"))
  expect_true(any(grepl("<i class=\"deaf icon\"></i>",
                        si_str, fixed = TRUE)))
  # multiple input
  si_str <- as.character(icon("deaf", "a", "b", "c"))
  expect_true(any(grepl("<i class=\"deaf icon\">\n  a\n  b\n  c\n</i>",
                        si_str, fixed = TRUE)))
})

test_that("test message type and input values", {
  # type
  expect_is(message(shiny::p("a"), c("b", "c")),
            "shiny.tag")
  # empty input
  expect_error(message())
  # text input
  si_str <- as.character(message(shiny::p("a"), "abcb"))
  expect_true(any(grepl("<div class=\"header\">",
                        si_str, fixed = TRUE)))
  expect_true(any(grepl("abcb", si_str, fixed = TRUE)))
})

test_that("test label_tag type and input values", {
  # type
  expect_is(label_tag(p("a")), "shiny.tag")
  # test input
  si_str <- as.character(label_tag(p("a")))
  expect_true(any(grepl("class=\"ui label \"",
                        si_str, fixed = TRUE)))
  expect_match(as.character(label_tag()), "<a class=\"ui label \"></a>")

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


test_that("test header", {
  # test missing input
  expect_error(header())
  expect_error(header("title"))
  si_str <- as.character(header(p("title"), "description"))
  expect_true(any(grepl(paste0("<div class=\"sub header\">",
                               "description</div>"), si_str, fixed = TRUE)))
  # check icons
  si_str_with_icon <- as.character(header("title", "description", "car"))
  expect_true(any(grepl(paste0("<div class=\"sub header\">",
                               "description</div>"), si_str, fixed = TRUE)))
  expect_true(any(grepl(paste0("<i class=\"car icon\"></i>"),
                        si_str_with_icon, fixed = TRUE)))
})

test_that("test cards", {
  # test missing input
  expect_match(as.character(cards()), "<div class=\"ui cards \"></div>")
  # test class
  expect_match(as.character(cards(class = "three")),
               "<div class=\"ui cards three\"></div>")
})

test_that("test card", {
  # test missing input
  expect_match(as.character(card()), "<div class=\"ui card \"></div>")
  # test class
  expect_match(as.character(card(class = "one")),
               "<div class=\"ui card one\"></div>")
})

test_that("test segment", {
  # test missing input
  expect_match(as.character(segment()), "<div class=\"ui segment \"></div>")
  # test class
  expect_match(as.character(segment(class = "one")),
               "<div class=\"ui segment one\"></div>")
})

test_that("test form", {
  # test missing input
  expect_match(as.character(form()), "<form class=\"ui form \"></form>")
  # test class
  expect_match(as.character(form(class = "form")),
               "<form class=\"ui form form\"></form>")
})

test_that("test fields", {
  # test missing input
  expect_match(as.character(fields()), "<div class=\"fields \"></div>")
  # test class
  expect_match(as.character(fields(class = "fl")),
               "<div class=\"fields fl\"></div>")
})

test_that("test field", {
  # test missing input
  expect_match(as.character(field()), "<div class=\"field \"></div>")
  # test class
  expect_match(as.character(field(class = "fl")),
               "<div class=\"field fl\"></div>")
})

test_that("test label", {
  # type
  expect_is(label(), "shiny.tag")

  expect_match(as.character(label()), "<label></label>")
})

test_that("test message", {
  # test missing input
  expect_error(message())
  si_str <- as.character(
    message(shiny::h2("a"), c("b", "c"))
  )
  # test output
  expect_true(any(grepl("<div class=\"ui message \">", si_str, fixed = TRUE)))
  expect_true(any(grepl("<ul class=\"list\">", si_str, fixed = TRUE)))
  expect_true(any(grepl("<li>b</li>", si_str, fixed = TRUE)))
  expect_error(message(shiny::h2("a"), c("b", "c"), class = "icon"),
               "If you give a class 'icon', then an icon argument is required")
})

test_that("test menu_item", {
  # test missing input
  expect_match(as.character(menu_item()),
               "<div class=\"item \"></div>")
  #test with icon
  si_str <- as.character(
    menu_item(icon("add icon"), "New tab")
  )
  expect_true(any(grepl("<i class=\"add icon icon\"></i>",
                        si_str, fixed = TRUE)))
  expect_true(any(grepl("New tab",
                        si_str, fixed = TRUE)))
})

test_that("test menu", {
  # test missing input
  expect_match(as.character(menu()), "<div class=\"ui menu \"></div>")
  #test with icon
  si_str <- as.character(
    menu(menu_item(icon("add icon"), "New tab"), type = "right")
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

test_that("test list_element", {
  si_str <- as.character(list_element())
  expect_true(any(grepl("<div class=\"item\">", si_str)))
  si_str <- as.character(list_element(header = "A"))
  expect_true(any(grepl("<div class=\"header\">A</div>", si_str)))
  si_str <- as.character(list_element(description = "B"))
  expect_true(any(grepl("<div class=\"description\">B</div>", si_str)))
})

test_that("test list_container", {
  # test missing input
  expect_error(list_container())
  # test default input
  list_content <- list(
    list(header = "Head", icon = "tree"),
    list(description = "Lorem ipsum")
  )
  si_str <- as.character(list_container(list_content))
  expect_true(any(grepl("<div class=\"ui  list\">", si_str)))
  expect_true(any(grepl("Lorem ipsum", si_str)))
  #' wrong input
  list_content <- list(
    list(icon = "cat"),
    list(header = "Head", icon = "tree")
  )
  expect_error(list_container(list_content),
               "content_list needs to have either header or description")
  #' input with icon
  list_content <- list(
    list(header = "Head", icon = "tree"),
    list(description = "Lorem ipsum")
  )
  si_str <- as.character(list_container(list_content))
  expect_true(any(grepl("tree icon", si_str)))
  #' divided
  si_str <- as.character(list_container(list_content, is_divided = TRUE))
  expect_true(any(grepl("divided list", si_str)))

})

test_that("test dropdown_menu", {
  # test missing input
  expect_error(dropdown_menu(), "Specify \"name\" argument.")
  expect_is(dropdown_menu("a",name="a"), "shiny.tag.list")
  si_str <- as.character(
    dropdown_menu(
      "Dropdown menu",
      icon(class = "dropdown"),
      menu(
        menu_header("Header"),
        menu_divider(),
        menu_item("Option 1")
      ),
      name = "dropdown_menu"
    )
  )
  expect_true(any(grepl("<div class=\"ui dropdown  dropdown_name_dropdown_menu\">",
                        si_str, fixed = TRUE)))
  expect_true(any(grepl("<div class=\"item header\">", si_str, fixed = TRUE)))
  expect_true(any(grepl("<div class=\"divider\"></div>", si_str, fixed = TRUE)))
  expect_true(any(grepl("<div class=\"item \">Option 1", si_str, fixed = TRUE)))
})
>>>>>>> [chane] uidropdown is dropdown_menu now
