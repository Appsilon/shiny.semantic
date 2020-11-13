idExists <- function(id, sprite) {
    sprite_sym <- xml2::xml_text(xml2::xml_find_all(
        sprite, "/*[name()='svg']/*[name()='symbol']/@id"))
    if(id %in% sprite_sym) return(TRUE) else return(FALSE)
}

#' Add svg to a sprite map
#'
#' @param newsvg \code{xml_document} object with svg that will be added
#' @param sprite \code{xml_document} object with the sprite map
#' @param id sets the id of the new svg inside the sprite map, if is
#' NULL it looks for the id inside the \code{newsvg} object.
#'
#' @return invisible copy of new sprite map
#'
#' @details the sprite map object is modified in place
#'
#' @examples
#' library(xml2)
#' sprite <- xml_new_root("svg", "version" = "1.1", "xmlns" = "http://www.w3.org/2000/svg")
#' newsvg <- read_xml("<svg version='1.1' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 68'>
#' <path d='M55.096 10.462c1.338-1.374.14-3.699-1.322-3.136-1.482.572-1'/>
#'    </svg>")
#' addsvg_sprite(newsvg, sprite, "new-icon")
#' @export
addsvg_sprite <- function(newsvg, sprite, id = NULL) {
    if(!requireNamespace("xml2", quietly = TRUE)) {
        stop("Package \"xml2\" needed for this function to work.
             Please install it", call. = FALSE)
    }
    if(is.null(id)) {
        id <- xml2::xml_attr(newsvg, "id")
        if(is.na(id)) stop("id is NULL and newsvg does not have id")
    }
    stopifnot(!idExists(id, sprite))
    viewBox <- xml2::xml_attr(newsvg, "viewBox")
    root_newsvg <- xml2::xml_new_root("symbol", "id" = id,
        "viewBox" = viewBox)
    xml2::xml_add_child(root_newsvg, xml2::xml_child(newsvg))
    xml2::xml_add_child(sprite,
         xml2::xml_find_first(root_newsvg, "/*[name()='symbol']"))
    invisible(sprite)
}


#' Remove svg from an sprite map
#'
#' @param id symbol id of the svg to be removed
#' @param sprite \code{xml_document} object with the sprite map
#'
#' @return invisible copy of new sprite map
#'
#' @details sprite map is modifyed on place
#'
#' @examples
#' library(xml2)
#' sprite <- xml_new_root("svg", "version" = "1.1", "xmlns" = "http://www.w3.org/2000/svg")
#' newsvg <- read_xml("<svg version='1.1' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 68'>
#' <path d='M55.096 10.462c1.338-1.374.14-3.699-1.322-3.136-1.482.572-1'/>
#' </svg>")
#' addsvg_sprite(newsvg, sprite, "new-icon")
#' rmsvg_sprite("new-icon", sprite)
#' @export
    rmsvg_sprite <- function(id, sprite) {
    if(!requireNamespace("xml2", quietly = TRUE)) {
        stop("Package \"xml2\" needed for this function to work.
             Please install it", call. = FALSE)
    }
    stopifnot(idExists(id, sprite))
    sym2remove <- xml2::xml_find_first(sprite,
        paste0("/*[name()='svg']/*[name()='symbol'][@id='",id,"']"))
    xml2::xml_remove(sym2remove)
    invisible(sprite)
}


