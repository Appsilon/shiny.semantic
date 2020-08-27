# Layouts

#' Extracts numeric values
#' @param value Value to be converted to numeric
#' @return Numeric value
get_numeric <- function(value) as.numeric(gsub("([0-9]+).*$", "\\1", value))

#' Creates div containing children elements of sidebar panel
#'
#' @param ... Container's children elements
#' @param width Width of sidebar panel container as relative value
#' @rdname sidebar_layout
#' @export
sidebar_panel <- function(..., width = 1) {
  list(children = div(...), width = get_numeric(width))
}

#' Creates div containing children elements of main panel
#'
#' @param ... Container's children elements
#' @param width Width of main panel container as relative value
#' @rdname sidebar_layout
#' @export
main_panel <- function(..., width = 3) {
  list(children = div(...), width = get_numeric(width))
}

#' Creates grid layout composed of sidebar and main panels
#'
#' @param sidebar_panel Sidebar panel component
#' @param main_panel Main panel component
#' @param mirrored If TRUE sidebar is located on the right side,
#' if FALSE - on the left side (default)
#' @param min_height Sidebar layout container keeps the minimum height, if
#' specified. It should be formatted as a string with css units
#' @param container_style CSS declarations for grid container
#' @param area_styles List of CSS declarations for each grid area inside
#' @param sidebarPanel same as \code{sidebar_panel}
#' @param mainPanel same as \code{main_panel}
#' @param position vector with position of sidebar elements in order sidebar, main
#' @param fluid TRUE to use fluid layout; FALSE to use fixed layout.
#'
#' @return Container with sidebar and main panels
#' @examples
#' if (interactive()){
#'   library(shiny)
#'   library(shiny.semantic)
#'   ui <- semanticPage(
#'     titlePanel("Hello Shiny!"),
#'     sidebar_layout(
#'       sidebar_panel(
#'         shiny.semantic::sliderInput("obs",
#'                                     "Number of observations:",
#'                                     min = 0,
#'                                     max = 1000,
#'                                     value = 500),
#'                                     width = 3
#'       ),
#'       main_panel(
#'         plotOutput("distPlot"),
#'         width = 4
#'       ),
#'       mirrored = TRUE
#'     )
#'   )
#'   server <- function(input, output) {
#'     output$distPlot <- renderPlot({
#'       hist(rnorm(input$obs))
#'     })
#'   }
#' }
#' @rdname sidebar_layout
#' @export
sidebar_layout <- function(sidebar_panel,
                           main_panel,
                           mirrored = FALSE,
                           min_height = "auto",
                           container_style = "",
                           area_styles = list(
                             sidebar_panel = "",
                             main_panel = "")) {

  sidebar_children <- sidebar_panel$children
  main_children <- main_panel$children
  sidebar_width <- sidebar_panel$width
  main_width <- main_panel$width

  # set normal or mirrored sidebar layout
  layout_areas <- c("sidebar_panel", "main_panel")
  layout_cols <- c(glue::glue("{sidebar_width}fr"), glue::glue("{main_width}fr"))
  layout <- grid_template(default = list(
    areas = rbind(if(mirrored) rev(layout_areas) else layout_areas),
    cols_width = if(mirrored) rev(layout_cols) else layout_cols
  ))

  # grid container's default styling
  container_style <- glue::glue("
    gap: 15px;
    height: auto;
    min-height: {min_height};
    {container_style}
  ")

  # grid container's children default styling
  area_styles <- list(
    sidebar_panel = glue::glue("
      background-color: #f5f5f5;
      border-radius: 5px;
      box-shadow: 0 1px 3px rgba(0,0,0,0.4);
      display: flex;
      flex-direction: column;
      min-width: 160px;
      padding: 10px;
      {area_styles$sidebar_panel}
    "),
    main_panel = glue::glue("
      background-color: #fff;
      border-radius: 5px;
      box-shadow: 0 1px 3px rgba(0,0,0,0.4);
      display: flex;
      flex-direction: column;
      min-width: 160px;
      padding: 10px;
      {area_styles$main_panel}
    ")
  )

  grid(
    grid_template = layout,
    container_style,
    area_styles,
    sidebar_panel = sidebar_children,
    main_panel = main_children
  )
}

#' @rdname sidebar_layout
sidebarPanel <- function(..., width = 6) {
  sidebar_panel(..., width = width)
}

#' @rdname sidebar_layout
mainPanel <- function(..., width = 10) {
  main_panel(..., width = width)
}

#' @rdname sidebar_layout
sidebarLayout <- function(sidebarPanel,
                          mainPanel,
                          position = c("left", "right"),
                          fluid = TRUE) {
  sidebar_layout (
    sidebar_panel,
    main_panel,
    mirrored = position == "right"
  )
}


#' Split layout
#'
#' Lays out elements horizontally, dividing the available horizontal space into
#' equal parts (by default) or specified by parameters.
#'
#' @param ... Unnamed arguments will become child elements of the layout.
#' @param cell_widths Character or numeric vector indicating the widths of the
#' individual cells. Recycling will be used if needed.
#' @param cell_args character with additional attributes that should be used for
#' each cell of the layout.
#' @param style character with style of outer box surrounding all elements
#' @param cellWidths same as \code{cell_widths}
#' @param cellArgs same as \code{cell_args}
#'
#' @return split layout grid object
#' @export
#'
#' @rdname split_layout
#'
#' @examples
#' if (interactive()) {
#'   #' Server code used for all examples
#'   server <- function(input, output) {
#'     output$plot1 <- renderPlot(plot(cars))
#'     output$plot2 <- renderPlot(plot(pressure))
#'     output$plot3 <- renderPlot(plot(AirPassengers))
#'   }
#'   #' Equal sizing
#'   ui <- semanticPage(
#'     split_layout(
#'       plotOutput("plot1"),
#'       plotOutput("plot2")
#'     )
#'   )
#'   shinyApp(ui, server)
#'   #' Custom widths
#'   ui <- semanticPage(
#'     split_layout(cell_widths = c("25%", "75%"),
#'                 plotOutput("plot1"),
#'                 plotOutput("plot2")
#'     )
#'   )
#'   shinyApp(ui, server)
#'   #' All cells at 300 pixels wide, with cell padding
#'   #' and a border around everything
#'   ui <- semanticPage(
#'     split_layout(
#'     cell_widths = 300,
#'     cell_args = "padding: 6px;",
#'     style = "border: 1px solid silver;",
#'     plotOutput("plot1"),
#'     plotOutput("plot2"),
#'     plotOutput("plot3")
#'   )
#'   )
#'   shinyApp(ui, server)
#' }
split_layout <- function(..., cell_widths = NULL, cell_args = "", style = NULL){
  if (class(cell_args) == "list")
    stop("In this implementation of `split_layout` cell_args must be character with style css")
  ui_elements <- list(...)
  n_elems <- length(ui_elements)
  columns <- paste0("col", seq(1, n_elems))
  names(ui_elements) <- columns
  if (is.null(cell_widths))
    cell_widths <- rep("1fr", n_elems)
  layout <- grid_template(
    default = list(
      areas = rbind(columns),
      cols_width = cell_widths
    )
  )
  container_style <- if (is.null(style)) "background: #d8d8d8; margin: 5px;" else style
  area_styles <- as.list(rep(cell_args, n_elems))
  names(area_styles) <- columns
  args_list <- ui_elements
  args_list$grid_template <- layout
  args_list$container_style <- container_style
  args_list$area_styles <- area_styles
  do.call(grid, args_list)
}

#' @export
#' @rdname split_layout
splitLayout <- function(..., cellWidths = NULL, cellArgs = "", style = NULL) {
  split_layout(..., cell_widths = cellWidths, cell_args = cellArgs, style = style)
}

#' Vertical layout
#'
#' Lays out elements vertically, one by one below one another.
#'
#' @param ... Unnamed arguments will become child elements of the layout.
#' @param rows_heights Character or numeric vector indicating the widths of the
#' individual cells. Recycling will be used if needed.
#' @param cell_args character with additional attributes that should be used for
#' each cell of the layout.
#' @param adjusted_to_page if TRUE it adjust elements position in equal spaces to
#' the size of the page
#' @param fluid not supported yet (here for consistency with \code{shiny})
#'
#' @return vertical layout grid object
#' @export
#' @rdname vertical_layout
#' @examples
#' if (interactive()) {
#'   ui <- semanticPage(
#'     verticalLayout(
#'       a(href="http://example.com/link1", "Link One"),
#'       a(href="http://example.com/link2", "Link Two"),
#'       a(href="http://example.com/link3", "Link Three")
#'     )
#'   )
#'   shinyApp(ui, server = function(input, output) { })
#' }
#' if (interactive()) {
#'   ui <- semanticPage(
#'     vertical_layout(h1("Title"), h4("Subtitle"), p("paragraph"), h3("footer"))
#'   )
#'   shinyApp(ui, server = function(input, output) { })
#' }
vertical_layout <- function(..., rows_heights = NULL, cell_args = "", adjusted_to_page = TRUE) {
  ui_elements <- list(...)
  n_elems <- length(ui_elements)
  rows <- paste0("row", seq(1, n_elems))
  names(ui_elements) <- rows
  if (is.null(rows_heights))
    rows_heights <- rep("auto", n_elems)
  if (length(rows_heights) == 1)
    rows_heights <- rep(rows_heights, n_elems)
  layout <- grid_template(
    default = list(
      areas = t(rbind(rows)),
      rows_height = rows_heights,
      cols_width = c("auto")
    )
  )

  area_styles <- as.list(rep(cell_args, n_elems))
  names(area_styles) <- rows
  args_list <- ui_elements
  args_list$grid_template <- layout
  args_list$area_styles <- area_styles
  args_list$container_style <- if (adjusted_to_page) "" else "align-content: start;"
  do.call(grid, args_list)
}

#' @export
#' @rdname vertical_layout
verticalLayout <- function(..., fluid = NULL) {
  if (!is.null(fluid))
    warn_unsupported_args(c("fluid"))
  vertical_layout(..., adjusted_to_page = FALSE)
}

#' Flow layout
#'
#' Lays out elements in a left-to-right, top-to-bottom arrangement.
#' The elements on a given row will be top-aligned with each other.
#'
#' The width of the elements and spacing between them is configurable.
#' Lengths can be given as numeric values (interpreted as pixels)
#' or character values (interpreted as CSS lengths).
#' With the default settings this layout closely resembles the `flowLayout`
#' from Shiny.
#'
#' @param ... Unnamed arguments will become child elements of the layout.
#' Named arguments will become HTML attributes on the outermost tag.
#' @param cell_args Any additional attributes that should be used for each cell
#' of the layout.
#' @param cell_width The width of the cells.
#' @param column_gap The spacing between columns.
#' @param row_gap The spacing between rows.
#'
#' @md
#' @export
#' @rdname flow_layout
#'
#' @examples
#' if (interactive()) {
#'   ui <- semanticPage(
#'     flow_layout(
#'       numericInput("rows", "How many rows?", 5),
#'       selectInput("letter", "Which letter?", LETTERS),
#'       sliderInput("value", "What value?", 0, 100, 50)
#'     )
#'   )
#'   shinyApp(ui, server = function(input, output) {})
#' }
flow_layout <- function(..., cell_args = list(), cell_width = "208px", column_gap = "12px", row_gap = "0px") {
  container_style <- glue::glue(
    "display: grid;",
    "grid-template-columns: repeat(auto-fill, {shiny::validateCssUnit(cell_width)});",
    "column-gap: {shiny::validateCssUnit(column_gap)};",
    "row-gap: {shiny::validateCssUnit(row_gap)};"
  )
  item_style <- "align-self: start;"
  args <- split_args(...)
  children <- lapply(args$positional, function(child) {
    do.call(shiny::tags$div, c(style = item_style, cell_args, list(child)))
  })
  attributes <- args$named
  do.call(shiny::tags$div, c(style = container_style, attributes, children))
}

#' @param cellArgs Same as `cell_args`.
#'
#' @md
#' @export
#' @rdname flow_layout
flowLayout <- function(..., cellArgs = list()) {
  flow_layout(..., cell_args = cellArgs)
}
