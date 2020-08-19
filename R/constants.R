#' Semantic colors
#'
#' https://github.com/Semantic-Org/Semantic-UI/blob/master/src/themes/default/globals/site.variables
#'
#' @export
COLOR_PALETTE <- c("#A333C8", "#21BA45", "#2185D0", "#DB2828", "#F2711C", "#FBBD08", "#B5CC18",
                      "#00B5AD", "#6435C9", "#E03997", "#A5673F", "#767676", "#1B1C1D")
names(COLOR_PALETTE) <- c("purple", "green", "blue", "red", "orange", "yellow", "olive", "teal",
                             "violet", "pink", "brown", "grey", "black")

#' Supported semantic themes
#' @export
SUPPORTED_THEMES <- c("cerulean", "darkly", "paper", "simplex",  # nolint
                      "superhero", "flatly", "slate", "cosmo",
                      "readable",  "united", "journal", "solar",
                      "cyborg", "sandstone", "yeti", "lumen", "spacelab")

#' Allowed sizes
#' @export
SIZE_LEVELS <- c("mini", "tiny", "small", "", "large", "huge", "massive")
