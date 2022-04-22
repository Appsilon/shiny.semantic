testthat::context("Form Validation")

testthat::test_that("field_rule fails with no rule", {
  testthat::expect_error(field_rule())
})

testthat::test_that("field_rule fails with invalid rule", {
  testthat::expect_error(field_rule("INVALID_RULE"))
})

testthat::test_that("field_rule passes with valid rule", {
  testthat::expect_error(field_rule("checked"), NA)
})

testthat::test_that("Basic field_rule returns an object of class 'field_rule'", {
  rule <- field_rule("checked")

  testthat::expect_is(rule, "list")
  testthat::expect_is(rule, "field_rule")
})

testthat::test_that("Basic field_rule returns a single item list named 'type'", {
  rule_type <- "checked"
  rule <- field_rule(rule_type)

  testthat::expect_is(rule, "list")
  testthat::expect_named(rule, "type")
  testthat::expect_equal(rule$type, rule_type)
})

testthat::test_that("field_rule fails when rule with required value has NULL value argument", {
  testthat::expect_error(field_rule("contains"))
})

testthat::test_that("field_rule passes with required value with valid rule", {
  testthat::expect_error(field_rule("contains", value = "abc"), NA)
})

testthat::test_that("field_rule returns an object of class 'field_rule'", {
  rule <- field_rule("contains", value = "abc")

  testthat::expect_is(rule, "list")
  testthat::expect_is(rule, "field_rule")
})

testthat::test_that("field_rule returns a single item list named 'type'", {
  rule <- field_rule("contains", value = "abc")

  testthat::expect_is(rule, "list")
  testthat::expect_named(rule, "type")
  testthat::expect_is(rule$type, "character")
})

testthat::test_that("regExp field_rule escapes the regular expression", {
  rule_type <- "regExp"
  rule_value <- "abc"
  rule <- field_rule(rule_type, value = rule_value)

  testthat::expect_match(rule$type, paste0("\\/", rule_value, "\\/"))
})

testthat::test_that("field_rule with prompt returns an extra list item named 'prompt'", {
  rule_type <- "checked"
  rule_prompt <- "Must be checked"
  rule <- field_rule(rule_type, rule_prompt)

  testthat::expect_is(rule, "list")
  testthat::expect_named(rule, c("type", "prompt"))
  testthat::expect_equal(rule$prompt, rule_prompt)
})

testthat::test_that("field_validation fails with no id", {
  testthat::expect_error(field_validation())
})

testthat::test_that("field_validation fails with no rules", {
  testthat::expect_error(field_validation("field"))
})

testthat::test_that("field_validation fails with invalid rule", {
  testthat::expect_error(field_validation("field", "Not empty"))
})

testthat::test_that("field_validation passes with 1 rule", {
  testthat::expect_error(field_validation("field", field_rule("empty")), NA)
})

testthat::test_that("field_validation returns an object of class 'field_validation'", {
  validation <- field_validation("field", field_rule("empty"))

  testthat::expect_is(validation, "list")
  testthat::expect_is(validation, "field_validation")
})

testthat::test_that("field_validation returns two items, identifier for field id and a list of rules", {
  field_id <- "field"
  validation <- field_validation(field_id, field_rule("empty"))

  testthat::expect_named(validation, c("identifier", "rules"))
  testthat::expect_equal(validation$identifier, field_id)
  testthat::expect_length(validation$rules, 1)
  testthat::expect_is(validation$rules[[1]], "field_rule")
})

testthat::test_that("field_validation passes with multiple rules", {
  testthat::expect_error(field_validation("field", field_rule("empty"), field_rule("integer", value = "1..10")), NA)
})

testthat::test_that("field_validation rules contains the same number of elements as there are rules", {
  validation <- field_validation("field", field_rule("empty"), field_rule("integer", value = "1..10"))

  testthat::expect_length(validation$rules, 2)
  testthat::expect_is(validation$rules[[1]], "field_rule")
  testthat::expect_is(validation$rules[[2]], "field_rule")
})

testthat::test_that("form_validation fails with no id", {
  testthat::expect_error(form_validation())
})

testthat::test_that("form_validation fails with no rules", {
  testthat::expect_error(form_validation("form"))
})

testthat::test_that("form_validation fails with invalid rule", {
  testthat::expect_error(form_validation("form", "No empty fields"))
})

testthat::test_that("form_validation passes with rules", {
  testthat::expect_error(form_validation("form", field_validation("field", field_rule("checked"))), NA)
})

testthat::test_that("Valid form_validation returns a shiny.tag list", {
  validation <- form_validation("form", field_validation("field", field_rule("checked")))

  testthat::expect_is(validation, "list")
  testthat::expect_is(validation, "shiny.tag.list")
})

testthat::test_that("Valid form_validation contains a Fomantic UI button", {
  form_id <- "form"
  validation <- form_validation(form_id, field_validation("field", field_rule("checked")))

  tag_types <- vapply(validation, function(x) x$name, character(1))
  testthat::expect_equal(sum(tag_types == "button"), 1)

  validation_button <- validation[[which(tag_types == "button")]]
  testthat::expect_match(validation_button$attribs$id, paste0(form_id, "_submit"))
  testthat::expect_match(validation_button$attribs$class, "ui.+form.+button")
})

testthat::test_that("Valid form_validation contains a an error message box", {
  validation <- form_validation("form", field_validation("field", field_rule("checked")), inline = FALSE)

  tag_types <- vapply(validation, function(x) x$name, character(1))
  testthat::expect_true(any(tag_types == "div"))

  validation_divs <- validation[which(tag_types == "div")]
  div_tag_classes <- vapply(validation_divs, function(x) x$attribs$class, character(1))
  testthat::expect_equal(sum(grepl("ui.+error.+message", validation_divs)), 1)
})

testthat::test_that("Inline form_validation doesn't contain a an error message box", {
  validation <- form_validation("form", field_validation("field", field_rule("checked")), inline = TRUE)

  tag_types <- vapply(validation, function(x) x$name, character(1))

  validation_divs <- validation[which(tag_types == "div")]
  div_tag_classes <- vapply(validation_divs, function(x) x$attribs$class, character(1))
  testthat::expect_equal(sum(grepl("ui.+error.+message", validation_divs)), 0)
})

testthat::test_that("Valid form_validation contains a JS script containing the rule validation", {
  form_id <- "form"
  validation <- form_validation(form_id, field_validation("field", field_rule("checked")))

  tag_types <- vapply(validation, function(x) x$name, character(1))
  testthat::expect_equal(sum(tag_types == "script"), 1)

  validation_script <- validation[[which(tag_types == "script")]]
  testthat::expect_match(validation_script$children[[1]], "form.*field.*checked")
})
