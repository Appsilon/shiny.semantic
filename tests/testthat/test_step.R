context("steps")

test_that("test steps", {
  # type
  expect_is(single_step("step_1", "Step 1"), "shiny.tag")
  expect_is(
      steps(
          "steps",
          list(
              single_step("step_1", "Step 1"),
              single_step("step_1", "Step 1"))
      ),
      "shiny.tag"
  )
  # empty input
  expect_error(single_step())
  expect_error(steps())
  # Single step
  single_step_str <- as.character(single_step("step_1", "Step 1"))
  expect_true(grepl("<div id=\"step_1\" class=\"step\">\n  <div class=\"content\">\n    <div class=\"title\">Step 1</div>\n  </div>\n</div>", # nolint
                    single_step_str))

  # Steps
  steps_str <- steps("steps", list(single_step("step_1", "Step 1"),
                     single_step("step_1", "Step 1")))
  expect_true(grepl("<div id=\"steps\" class=\"ui steps\">\n  <div id=\"step_1\" class=\"step\">\n    <div class=\"content\">\n      <div class=\"title\">Step 1</div>\n    </div>\n  </div>\n  <div id=\"step_1\" class=\"step\">\n    <div class=\"content\">\n      <div class=\"title\">Step 1</div>\n    </div>\n  </div>\n</div>", # nolint
                    steps_str))

})
