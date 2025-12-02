# Register search api url

Calls Shiny session's registerDataObj to create REST API. Publishes any
R object as a URL endpoint that is unique to Shiny session. search_query
must be a function that takes two arguments: data (the value that was
passed into registerDataObj) and req (an environment that implements the
Rook specification for HTTP requests). search_query will be called with
these values whenever an HTTP request is made to the URL endpoint. The
return value of search_query should be a list of list or a dataframe.
Note that different semantic components expect specific JSON fields to
be present in order to work correctly. Check components documentation
for details.

## Usage

``` r
register_search(session, data, search_query)
```

## Arguments

- session:

  Shiny server session

- data:

  Data (the value that is passed into registerDataObj)

- search_query:

  Function providing a response as a list of lists or dataframe of
  search results.

## Examples

``` r
if (interactive()) {
  library(shiny)
  library(tibble)
  library(shiny.semantic)
  shinyApp(
    ui = semanticPage(
      textInput("txt", "Enter the car name (or subset of name)"),
      textOutput("api_url"),
      uiOutput("open_url")
    ),
    server = function(input, output, session) {
      api_response <- function(data, q) {
        has_matching <- function(field) {
          grepl(toupper(q), toupper(field), fixed = TRUE)
        }
        dplyr::filter(data, has_matching(car))
      }

      search_api_url <- register_search(session,
                           tibble::rownames_to_column(mtcars, "car"), api_response)

      output$api_url <- renderText({
       glue::glue(
        "Registered API url: ",
        "{session$clientData$url_protocol}//{session$clientData$url_hostname}",
        ":{session$clientData$url_port}/",
        "{search_api_url}&q={input$txt}"
        )
      })

      output$open_url <- renderUI({
        tags$a(
          "Open", class = "ui button",
          href = glue::glue("./{search_api_url}&q={input$txt}"), target = "_blank"
        )
      })
    }
  )
}
```
