context("semanticPage")

describe("get_dependencies_path", {
  it("by default returns path to local shiny.semantic files", {
    semantic_path <- c(
        file = system.file(
          "www",
          "shared",
          "semantic",
          package = "semantic.assets"
        )
      )

    expect_equal(get_dependencies_path()$src, semantic_path)
  })

  it("by default returns type 'local'", {
    semantic_path <- list(
      src = c(
        file = system.file(
          "www",
          "shared",
          "semantic",
          package = "semantic.assets"
        )
      ),
      type = "local"
    )

    expect_equal(get_dependencies_path()$type, "local")
  })

  it("returns custom local path if shiny.custom.semantic set in options", {
    custom_semantic_path <- "custom semantic path"

    withr::with_options(
      list(shiny.custom.semantic = custom_semantic_path),
      {
        expect_equal(get_dependencies_path()$src, c(file = custom_semantic_path))
      }
    )
  })

  it("returns type 'custom' if shiny.custom.semantic set in options", {
    custom_semantic_path <- "custom semantic path"

    withr::with_options(
      list(shiny.custom.semantic = custom_semantic_path),
      {
        expect_equal(get_dependencies_path()$type, "custom")
      }
    )
  })

  it("returns the CDN path if shiny.custom.semantic.cdn option is provided", {
    custom_semantic_cdn <- "custom semantic cdn"

    withr::with_options(
      list(shiny.custom.semantic.cdn = custom_semantic_cdn),
      {
        expect_equal(get_dependencies_path()$src, c(href = custom_semantic_cdn))
      }
    )
  })

  it("returns type 'cdn' if shiny.custom.semantic.cdn option is provided", {
    custom_semantic_cdn <- "custom semantic cdn"

    withr::with_options(
      list(shiny.custom.semantic.cdn = custom_semantic_cdn),
      {
        expect_equal(get_dependencies_path()$type, "cdn")
      }
    )
  })
})

describe("get_css_file", {
  it("returns the default css file if no theme is provided", {
    expect_equal(get_css_file(type = "local"), "semantic.css")
  })

  it("returns the theme value without a change if the type is 'custom'", {
    expect_equal(get_css_file(type = "custom", theme = "test"), "test")
  })

  it("returns the CSS theme file if a theme is provided", {
    expect_equal(get_css_file(type = "cdn", theme = "test"), "semantic.test.css")
  })

  it("returns the minified file if minified is set to 'min'", {
    expect_equal(get_css_file(type = "local", minified = "min"), "semantic.min.css")
  })

  it("returns the default css file with a warning if type is local and theme is not supported", {
    result <- expect_warning(get_css_file(type = "local", theme = "test"))
    expect_equal(result, "semantic.css")
  })
})
