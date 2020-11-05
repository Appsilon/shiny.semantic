myGrid <- grid_template(
  default = list(
    areas = rbind(
      c("header", "header", "header"),
      c("menu",   "main",   "right1"),
      c("menu",   "main",   "right2")
    ),
    rows_height = c("50px", "auto", "100px"),
    cols_width = c("100px", "2fr", "1fr")
  ),
  mobile = list(
    areas = rbind(
      "header",
      "menu",
      "main",
      "right1",
      "right2"
    ),
    rows_height = c("50px", "50px", "auto", "150px", "150px"),
    cols_width = c("100%")
  )
)

if (interactive()) display_grid(myGrid)
subGrid <- grid_template(default = list(
  areas = rbind(
    c("top_left", "top_right"),
    c("bottom_left", "bottom_right")
  ),
  rows_height = c("50%", "50%"),
  cols_width = c("50%", "50%")
))

if (interactive()) display_grid(subGrid)
