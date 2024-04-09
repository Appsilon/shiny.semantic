context("multiple checkbox")

test_that("test multiple_checkbox input values", {
  # type
  expect_is(multiple_checkbox(
    input_id = "checkboxes",
    label = NULL,
    choices = ""
  ),
  "shiny.tag")
  # empty input
  si_str <-
    as.character(multiple_checkbox(
      input_id = "checkboxes",
      label = NULL,
      choices = ""
    ))
  expect_true(any(
    grepl(
      "<div id=\"checkboxes\" class=\"grouped fields ss-checkbox-input\">",
      si_str,
      fixed = TRUE
    )
  ))
  # label
  si_str <-
    as.character(multiple_checkbox(
      input_id = "checkboxes",
      label = "My Label",
      choices = ""
    ))
  expect_true(any(
    grepl("<label for=\"checkboxes\">My Label</label>",
          si_str, fixed = TRUE)
  ))
  # selected choices
  si_str <-
    as.character(
      multiple_checkbox(
        input_id  = "checkboxes",
        label = "My Label",
        choices  = c("A's", "B"),
        selected = c("A's", "B")
      )
    )
  expect_true(any(
    grepl(
      "<input type=\"checkbox\" name=\"checkboxes\" tabindex=\"0\" value=\"A&#39;s\" checked/>",
      si_str,
      fixed = TRUE
    )
  ))
  expect_true(any(
    grepl(
      "<input type=\"checkbox\" name=\"checkboxes\" tabindex=\"0\" value=\"B\" checked/>",
      si_str,
      fixed = TRUE
    )
  ))
})
