
## If you use filter parameter you need to add styles:
SEMANTIC_DT_STYLE <- shiny::tags$style("
.form-group input {
    font-family: Lato,'Helvetica Neue',Arial,Helvetica,sans-serif;
    margin: 0;
    outline: 0;
    -webkit-appearance: none;
    -webkit-tap-highlight-color: rgba(255,255,255,0);
    line-height: 1.21428571em;
    padding: .67857143em 1em;
    font-size: 1em;
    background: #fff;
    border: 1px solid rgba(34,36,38,.15);
    color: rgba(0,0,0,.87);
    border-radius: .28571429rem;
    -webkit-box-shadow: 0 0 0 0 transparent inset;
    box-shadow: 0 0 0 0 transparent inset;
    -webkit-transition: color .1s ease,border-color .1s ease;
    transition: color .1s ease,border-color .1s ease;
}"
)

#' Create Semantic DT Table
#'
#' This creates DT table styled with Semantic UI.
#'
#' @param ... datatable parameters, check \code{?DT::datatable} to learn more.
#'
#' @examples
#' if (interactive()){
#'  ui <- semanticPage(
#'    semantic_DTOutput("table")
#'  )
#'  server <- function(input, output, session) {
#'    output$table <- DT::renderDataTable(
#'      semantic_DT(iris)
#'    )
#'  }
#'  shinyApp(ui, server)
#' }
#' @rdname semantic_DT
#'
#' @export
semantic_DT <- function(...) {
  DT::datatable(..., options = list(),
                class = 'ui small compact table',
                style = "semanticui",
                rownames = FALSE)
}

#' Semantic DT Output
#'
#' @param ... datatable parameters, check \code{?DT::datatable} to learn more.
#'
#' @return
#' @rdname semantic_DT
semantic_DTOutput <- function(...) {
  shiny::tagList(
    shiny::tags$head(SEMANTIC_DT_STYLE),
    DT::DTOutput(...)
  )
}
