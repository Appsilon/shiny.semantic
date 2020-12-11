#' Create search field Semantic UI component
#'
#' This creates a default search field using Semantic UI styles with Shiny
#' input. Search field is already initialized and available under input[[input_id]].
#' Search will automatically route to the named API endpoint provided
#' as parameter. API response is expected to be a JSON with property fields
#' `title` and `description`.
#' See https://semantic-ui.com/modules/search.html#behaviors for more details.
#'
#' @param input_id Input name. Reactive value is available under input[[input_id]].
#' @param search_api_url Register custom API url with server JSON Response
#' containing fields `title` and `description`.
#' @param default_text Text to be visible on serach field when nothing
#' is selected.
#' @param value Pass value if you want to initialize selection for search field.
#'
#' @example inst/examples/search_field.R
#'
#' @export
#' @importFrom magrittr "%>%"
#' @import shiny
#'
search_field <- function(input_id,
                         search_api_url,
                         default_text = "Search",
                         value = "") {
  shiny::tagList(
    div(class = paste(input_id, "ui search"),
        div(class = "ui icon fluid input",
            shiny_input(input_id,
              # Hack: Setting "oninput" to "null" is a fix for reset of
              # selection, when using arrows as suggested here:
              # https://github.com/Semantic-Org/Semantic-UI/issues/3416
              tags$input(class = "prompt search field",
                         type = "text",
                         placeholder = default_text,
                         oninput = "null"),
              value = value
            ),
            icon("search")
        ),
        div(class = "results")
    ),
    HTML(paste0(
      "<script>
      $('.", input_id, "').search({
        apiSettings: {
          url: '", search_api_url, "&q={query}'
        },
        onSelect: function(result) {
          $('#", input_id, "').val(result.title).change();
        },
        selectFirstResult: true
      });</script>
      "
    ))
  )
}
