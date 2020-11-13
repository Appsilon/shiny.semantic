context("sprite")

test_that("Function addsvg_sprite add an svg to current sprite",{
    require(xml2)
    sprite <- xml_new_root("svg", "version" = "1.1", "xmlns" = "http://www.w3.org/2000/svg")
    newsvg <- read_xml("<svg version='1.1' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 68'>
    <path d='M55.096 10.462c1.338-1.374.14-3.699-1.322-3.136-1.482.572-1'/>
  </svg>")

    addsvg_sprite(newsvg, sprite, "shiny-logo")
    expect_equal(xml_attr(xml_child(sprite), "id"), "shiny-logo")
    expect_error(addsvg_sprite(newsvg, sprite, "shiny-logo"))
})

test_that("Function rmsvg_sprite removes the \"id\" svg",{
    require(xml2)
    sprite <- xml_new_root("svg", "version" = "1.1", "xmlns" = "http://www.w3.org/2000/svg")
    newsvg <- read_xml("<svg version='1.1' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 68'>
    <path d='M55.096 10.462c1.338-1'/>
  </svg>")

    addsvg_sprite(newsvg, sprite, "shiny-logo")
    rmsvg_sprite("shiny-logo", sprite)
    expect_equal(length(xml_children(sprite)), 0)
    expect_error(rmsvg_sprite("shiny-logo", sprite))
})
