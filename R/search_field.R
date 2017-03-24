
#' Create search field Semantic UI component
#'
#' This creates a default search field using Semantic UI styles with Shiny input. Search field is already initialized
#' and available under input[[name]]. Search will automatically route to the named API endpoint provided as parameter.
#' Search is performed across JavaScript searchFields `title` and `description`.
#' See https://semantic-ui.com/modules/search.html#behaviors for more details.
#'
#' @param name Input name. Reactive value is available under input[[name]].
#' @param search_api_url Register custom API url with server JSON Response containing fields `title` and `description`.
#' @param default_text Text to be visible on serach field when nothing is selected.
#' @param value Pass value if you want to initialize selection for search field.
#'
#' @export
#' @importFrom magrittr "%>%"
#'
search_field <- function(name, search_api_url, default_text = 'Search',  value = "") {
  tagList(
    div(class = paste(name, "ui search"),
        div(class = "ui icon fluid input",
            shiny_input(name,
                        tags$input(class = "prompt search field", type = "text" , placeholder = "Search...",
                                   # Hack: Setting "oninput" to "null" is a fix for reset of selection, when using arrows
                                   # as suggested here: https://github.com/Semantic-Org/Semantic-UI/issues/3416
                                   oninput = "null"),
                        value = value
            ),
            uiicon('search')
        ),
        div(class = "results")
    ),
    HTML(paste0(
      "<script>
      $('.", name, "').search({
        apiSettings: {
          url: '", search_api_url, "&q={query}'
        },
        onSelect: function(result) {
          $('#", name, "').val(result.title).change();
        },
        selectFirstResult: true
      });</script>
      "
    ))
  )
}
