#' Form Validation for Semantic UI
#'
#' @param id ID of the parent form
#' @param ... A series of \code{\link{field_validation}} that are related to inputs within the parent form
#' @param submit_label Label to give the submission button at the end of the form (included in returned UI with input
#' value \code{\{id\}_submit})
#' @param submit_class Additional classes to give the submission button
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shiny.semantic)
#'
#'   ui <- semanticPage(
#'     form(
#'       id = "form",
#'       field(
#'         tags$label("Name"),
#'         text_input("name")
#'       ),
#'       field(
#'         tags$label("E-Mail"),
#'         text_input("email")
#'       ),
#'       form_validation(
#'         id = "form",
#'         field_validation("name", field_rule("empty")),
#'         field_validation("email", field_rule("empty"), field_rule("email"))
#'       )
#'     )
#'   )
#'
#'   server <- function(input, output) {
#'   }
#'
#'   shinyApp(ui, server)
#' }
#'
#' @seealso field_validation
#'
#' @export
form_validation <- function(id, ..., submit_label = "Submit", submit_class = "") {
  fields <- list(...)
  names(fields) <- vapply(fields, function(x) x$identifier, character(1))
  fields_json <- jsonlite::toJSON(fields, auto_unbox = TRUE)

  tagList(
    action_button(input_id = paste0(id, "_submit"), label = submit_label, class = paste("submit", submit_class)),
    div(class = "ui error message"),
    tags$script(glue::glue("$('#{|id|}').form({fields: {|fields_json|}});", .open = "{|", .close = "|}"))
  )

}

#' Field Validation for Semantic UI
#'
#' @param id HTML id of the field to be validated
#' @param ... A series of \code{field_rule}s that will be applied to the field
#'
#' @details
#' The following \code{rule} are available:
#' \itemize{
#' }
#'
#' @examples
#' # E-mail validations
#' field_validation("email", field_rule("email"))
#'
#' @seealso \code{form_validation}
#'
#' @rdname field_validation
#' @export
field_validation <- function(id, ...) {
  rules <- list(...)
  structure(list(identifier = id, rules = rules), class = c("list", "field_validation"))
}

#' @param rule The type of rule to be applied. Valid rules are available in Details.
#' @param prompt Text to be displayed in the UI if the validation fails. Leave \code{NULL} if want to use default text.
#' @param value Certain fields require a value to check validation. Check Details if the \code{rule} requires a value.
#'
#' @rdname field_validation
#' @export
field_rule <- function(rule, prompt = NULL, value = NULL) {
  if (!rule %in% FIELD_RULES) stop("Field rule must be one of: ", paste(FIELD_RULES, collapse = ", "))

  if (rule %in% FIELD_RULES_NO_VALUES && is.null(value)) {
    rule_info <- list(type = rule)
  } else {
    if (is.null(value)) stop(rule, " rule must have a value for validation")
    rule_info <- list(type = paste0(rule, "[", value, "]"))
  }

  if (!is.null(prompt)) rule_info$prompt <- prompt

  structure(rule_info, class = c("list", "rule_info"))
}

FIELD_RULES_NO_VALUES <- c("empty", "checked", "email", "url", "integer", "decimal", "number", "creditCard")
FIELD_RULES_WITH_VALUES <- c(
  "integer", "decimal", "number", "minValue", "maxValue", "regExp", "creditCard",
  "contains", "containsExactly", "doesntContain", "doesntContainExactly", "is", "isExactly",
  "not", "notExactly", "minLength", "exactLength", "maxLength", "match", "different",
  "minCount", "exactCount", "maxCount"
)
FIELD_RULES <- unique(c(FIELD_RULES_NO_VALUES, FIELD_RULES_WITH_VALUES))
