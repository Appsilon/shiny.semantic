context("input")

test_that("test uiinput", {
  # type
  expect_is(uiinput(), "shiny.tag")
  # text input
  si_str <- as.character(uiinput())
  expect_true(any(grepl("<div class=\"ui  input\">", si_str, fixed = TRUE)))
})

test_that("test text_input", {
  # type
  expect_is(text_input("text_input", "Text Input"), "shiny.tag")
  # empty input
  expect_error(text_input())
  # text input
  si_str <- as.character(text_input("text_input", "Text Input"))
  expect_true(any(grepl("<div class=\"ui  input\">\n  <label>Text Input</label>\n ",
                        si_str, fixed = TRUE)))
  # text value
  si_str <- as.character(text_input("text_input", "Text Input", value ="x"))
  expect_true(any(grepl("value=\"x\"",
                        si_str, fixed = TRUE)))
})

test_that("test textInput", {
  # type
  expect_is(textInput("text_input", "Text Input"), "shiny.tag")
  # empty input
  expect_error(textInput())
  # text input
  si_str <- as.character(textInput("text_input", "Text Input"))
  expect_true(any(grepl("<div class=\"ui form\">\n  <div class=\"field\">",
                        si_str, fixed = TRUE)))

})

test_that("test textAreaInput", {
  # type
  expect_is(textAreaInput("ta_input", "Text Area Input"), "shiny.tag")
  # empty input
  expect_error(textAreaInput())
  # text input
  si_str <- as.character(textAreaInput("ta_input", "Text Area Input"))
  expect_true(any(grepl("<textarea id=\"ta_input\"",
                        si_str, fixed = TRUE)))
})

test_that("test numeric_input", {
  # type
  expect_is(numeric_input("number_input", 20), "shiny.tag")
  # empty input
  expect_error(numeric_input())
  # text input
  expect_error(numeric_input("number input", "Text input"))
  # number input
  si_str <- as.character(numeric_input("number_input", 20))
  expect_true(any(grepl("<input id=\"number_input\" value=\"20\" type=\"number\"/>",
                        si_str, fixed = TRUE)))
  # all parameters
  expect_is(numeric_input("number_input", 20, min = 10, max = 40, step = 1),
            "shiny.tag")
})

test_that("test numericInput", {
  # type
  expect_is(numericInput("numberinput", "NLabel", 20), "shiny.tag")
  # empty input
  expect_error(numericInput())
  expect_error(numericInput("a", "label"), "\"value\" is missing")
})
