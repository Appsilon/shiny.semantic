#' Form Validation for Semantic UI
#'
#' A form validation behaviour checks data against a set of criteria before passing it along to the server.
#'
#' @param id ID of the parent form
#' @param ... A series of \code{\link{field_validation}} whose \code{id} are inputs contained within the form
#' @param submit_label Label to give the submission button at the end of the form (included in returned UI with input
#' value \code{\{id\}_submit})
#' @param submit_class Additional classes to give the submission button
#' @param inline Logical, do you want the field validation errors as inline labels \code{TRUE},
#' or in a message box at the bottom of the form \code{FALSE}?
#'
#' @details
#' In order for the validation to work, the \code{form_validation} must be a direct child of the \code{form}.
#'
#' There are twp ways to control using form inputs on the server side:
#'
#' \itemize{
#' \item{The form id is enabled as an input, and will either be \code{TRUE} or \code{FALSE} depending on the status of
#' the form upon the last submission. When the shiny application loads, by default it will be set to \code{FALSE}}
#' \item{Alternatively the "Submit" button has an input value of \code{{form_id}_submit} and will only trigger
#' server-side events if all the fields pass validation.}
#' }
#'
#' \strong{NB} If you do not include either form validation input as part of the server-side code
#' then the inputs will pass through to the server as if there were no validation.
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
#' @seealso \code{\link{field_validation}}, \url{https://fomantic-ui.com/behaviors/form.html}
#'
#' @export
form_validation <- function(id, ..., submit_label = "Submit", submit_class = "", inline = FALSE) {
  rules <- list(...)

  if (length(rules) == 0) {
    stop("No rules present for ", id)
  }

  if (!is.logical(inline) || is.na(inline)) {
    stop("inline must be TRUE or FALSE")
  }

  if (!all(sapply(rules, inherits, what = "field_validation"))) {
    stop("Not all items are of class `field_validation`, use `field_validation` to specify rules.")
  }

  submit_button <- action_button(
    input_id = paste0(id, "_submit"), label = submit_label,
    class = paste("submit", submit_class)
  )

  rules_js <- create_form_validation_js(id, rules, inline)

  if (isTRUE(inline)) {
    tagList(
      submit_button,
      tags$script(rules_js)
    )
  } else {
    tagList(
      submit_button,
      div(class = "ui error message"),
      tags$script(rules_js)
    )
  }
}

create_form_validation_js <- function(id, rules, inline = FALSE) {
  names(rules) <- vapply(rules, function(x) x$identifier, character(1))
  rules_json <- jsonlite::toJSON(rules, auto_unbox = TRUE)

  glue::glue(
    "$('#{|id|}').form({fields: {|rules_json|}, inline: {|tolower(inline)|}});",
    .open = "{|", .close = "|}"
  )
}

#' Field Validation for Semantic UI
#'
#' A field validation assigns a series of rules that have been assigned to a particular input and checks, upon
#' the form submission, whether or not the input meets all specified criteria.
#'
#' If it fails, then the field will be highlighted and the failures will either be specified as a message below the
#' field or a label. Once the failure(s) has been rectified, the highlighting will disappear.
#'
#' @param id HTML id of the field to be validated
#' @param ... A series of \code{field_rule}s that will be applied to the field
#'
#' @details
#' The following \code{rules} are allowed:
#' \describe{
#' \item{\code{empty}}{A field is not empty}
#' \item{\code{checked}}{A checkbox field is checked}
#' \item{\code{url}}{A field is a url}
#' \item{\code{integer}}{A field is an integer value or matches an integer range\code{*}}
#' \item{\code{decimal}}{A field must be a decimal number or matches a decimal range\code{*}}
#' \item{\code{number}}{A field is any number or matches a number range\code{*}}
#' \item{\code{regExp}}{Matches against a regular expression}
#' \item{\code{creditCard}}{A field is a valid credit card\code{**}}
#' \item{\code{contains}, \code{doesntContain}}{A field (doesn't) contain text (case insensitive)}
#' \item{\code{containsExactly}, \code{doesntContainExactly}}{A field (doesn't) contain text (case sensitive)}
#' \item{\code{is}, \code{not}}{A field is (not) a value (case insensitive)}
#' \item{\code{isExactly}, \code{notExactly}}{A field is (not) a value (case sensitive)}
#' \item{\code{minLength}, \code{exactLength}, \code{maxLength}}{A field is at least/exactly/at most a set length}
#' \item{\code{match}, \code{different}}{
#' A field should (not) match the value of another validation field. Use the field ID as the value
#' }
#' \item{\code{minCount}, \code{exactCount}, \code{maxCount}}{
#' A multiple select field contains at least/exactly/at most a set number of selections
#' }
#'
#' }
#'
#' \code{*} For ranges, include the parameter \code{value = "x..y"}
#' where \code{x} is the minimum value and \code{y} is the maximum value.
#' Leave either side blank to not have a lower/upper limit
#'
#' \code{**} Include comma separated string of card providers if required e.g. \code{value = "visa,mastercard"}
#'
#' @examples
#' # E-mail validations
#' field_validation("email", field_rule("email"))
#'
#' # Password validation
#' field_validation(
#'   "password",
#'   field_rule("empty"),
#'   field_rule("minLength", value = 8),
#'   field_rule("regExp", "Must contain at least one special character", "\\W")
#' )
#'
#' @seealso \code{\link{form_validation}}, \url{https://fomantic-ui.com/behaviors/form.html}
#'
#' @rdname field_validation
#' @export
field_validation <- function(id, ...) {
  rules <- list(...)

  if (length(rules) == 0) {
    stop("No rules present for ", id)
  }

  if (!all(sapply(rules, inherits, what = "field_rule"))) {
    stop("Not all items are of class `field_rule`, use `field_rule` to specify rules.")
  }

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
    if (is.null(value)) {
      stop(rule, " rule must have a value for validation")
    } else if (rule == "regExp") {
      value <- escape_field_validation_regex(value)
    }

    rule_info <- list(type = paste0(rule, "[", value, "]"))
  }

  if (!is.null(prompt)) rule_info$prompt <- prompt

  structure(rule_info, class = c("list", "field_rule"))
}

escape_field_validation_regex <- function(x) paste0("/", x, "/")

FIELD_RULES_NO_VALUES <- c("empty", "checked", "email", "url", "integer", "decimal", "number", "creditCard")
FIELD_RULES_WITH_VALUES <- c(
  "integer", "decimal", "number", "regExp", "creditCard",
  "contains", "containsExactly", "doesntContain", "doesntContainExactly", "is", "isExactly",
  "not", "notExactly", "minLength", "exactLength", "maxLength", "match", "different",
  "minCount", "exactCount", "maxCount"
)
FIELD_RULES <- unique(c(FIELD_RULES_NO_VALUES, FIELD_RULES_WITH_VALUES))
