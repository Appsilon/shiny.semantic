#' This creates an icon tag using Semantic UI styles.
#'
#' @param type A name of an icon. Look at http://semantic-ui.com/elements/icon.html for all possibilities.
#' @param style Optional style attribute to add to the tag.
#'
#' @export
uiicon <- function(type = "", style = "") {
  tags$i(class = paste(type, "icon"), style = style)
}
