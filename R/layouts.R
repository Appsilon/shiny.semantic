# We want shiny.semantic to provide grid and layouts for users' convenience.

# This is done by a Depends field in DESCRIPTION, because we can not @import
# entire shiny.layouts, as this generates a built warning due to some functions
# shadowing shiny:: functions.
#
# We also import the snake_case versions here, for which there's no conflict,
# because this is suggested by R CMD CHECK when Depends is used.

#' @importFrom shiny.layouts grid grid_template
NULL

#' @importFrom shiny.layouts sidebar_panel main_panel sidebar_layout
NULL

#' @importFrom shiny.layouts split_layout vertical_layout flow_layout
NULL
