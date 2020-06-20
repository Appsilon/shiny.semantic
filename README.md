
# shiny.semantic

<img src="man/figures/hexsticker.png" align="right" alt="" width="130" />

<!-- badges: start -->

![R-CMD-check](https://github.com/Appsilon/shiny.semantic/workflows/R-CMD-check/badge.svg)
[![codecov](https://codecov.io/gh/Appsilon/shiny.semantic/branch/master/graph/badge.svg)](https://codecov.io/gh/Appsilon/shiny.semantic)

[![cranlogs](https://cranlogs.r-pkg.org/badges/shiny.semantic)](https://CRAN.R-project.org/package=shiny.semantic)
[![total](https://cranlogs.r-pkg.org/badges/grand-total/shiny.semantic)](https://CRAN.R-project.org/package=shiny.semantic)
<!-- badges: end -->

**Fomantic (Semantic) UI wrapper for Shiny**

With this library it is easy to wrap Shiny with **[Fomantic
UI](https://fomantic-ui.com/)** (previously *Semantic*). Add a few
simple lines of code to give your UI a **fresh, modern and highly
interactive** look.

  - **shiny**

<img src="man/figures/ss_before.png" alt="shiny" align="right" width="40%" />

``` r
library(shiny)
ui <- fluidPage(
  div(
    div(
      a("Link"),
      p("Lorem ipsum, lorem ipsum, lorem ipsum"),
      actionButton("button", "Click")
    )
  )
)
```

  - **shiny.semantic**

<img src="man/figures/ss_after.png" alt="semantic" align="right" width="40%" />

``` r
library(shiny.semantic)
ui <- semanticPage(
  div(class = "ui raised segment",
    div(
      a(class="ui green ribbon label", "Link"),
      p("Lorem ipsum, lorem ipsum, lorem ipsum"),
      actionButton("button", "Click")
    )
  )
)
```

## Component examples

<img src="man/figures/semantic_components.png" alt="" width="80%" />

<center>

<h3>

<a href="https://demo.appsilon.ai/semantic/">Components live demo</a>

</h4>

</center>

Check out also our dashboard examples made with **shiny.semantic**
library:

| [Churn analytics](https://demo.appsilon.ai/churn) | [Fraud detection](https://demo.appsilon.ai/frauds) |
| ------------------------------------------------- | -------------------------------------------------- |

## How to install?

You can install a stable `shiny.semantic` release from CRAN repository:

``` r
install.packages("shiny.semantic")
```

and the latest version with devtools:

``` r
devtools::install_github("Appsilon/`r params$repo_name`")
```

(`master` branch contains the stable version. Use `develop` branch for
latest features)

To install [previous versions]() you can run:

``` r
devtools::install_github("Appsilon/`r params$repo_name`", ref = "0.1.0")
```

## How to use it?

Firstly, you will have to invoke `shinyUI()` with `semanticPage()`
instead of standard Shiny UI definitions like e.g. `fluidPage()`. From
now on, all components can be annotated with [Fomantic
UI](https://fomantic-ui.com/) specific CSS classes and also you will be
able to use [shiny.semantic
components](https://demo.appsilon.ai/semantic/).

Basic example for rendering a simple button. will look like this:

``` r
library(shiny)
library(shiny.semantic)
ui <- function() {
  shinyUI(
    semanticPage(
      title = "My page",
      div(class = "ui button", uiicon("user"),  "Icon button")
    )
  )
}
server <- shinyServer(function(input, output) {
})
shinyApp(ui = ui(), server = server)
```

For better understanding it’s good to check [Fomantic UI
documentation.](https://fomantic-ui.com/)

**Note \#1**

At the moment you have to pass page title in `semanticPage()`

    semanticPage(title = "Your page title", ...)

**Note \#2**

You can switch off suppressing bootstrap by calling
`semanticPage(suppress_bootstrap = FALSE, ...)`

**\[Advanced\] Using Fomantic UI JavaScript elements**

Some Fomantic UI elements require to run a specific JS code when DOM
document is ready. There are at least 2 options to do this:

1.  Use [shinyjs](https://github.com/daattali/shinyjs)

<!-- end list -->

    library(shinyjs)
    ...
    jsCode <- " # Fomantic UI componts JS "
    ...
    ui <- function() {
      shinyUI(
        semanticPage(
          title = "Your page title",
          shinyjs::useShinyjs(),
          # Your UI code
        )
      )
    }
    server <- shinyServer(function(input, output) {
      runjs(jsCode)
      # Your Shiny logic
    })
    shinyApp(ui = ui(), server = server)

2.  Use `shiny::tags$script()`

<!-- end list -->

    ...
    jsCode <- "
    $(document).ready(function() {
      # Semantic UI components JS code, like:
      #$('.rating').rating('setting', 'clearable', true);
      #$('.disabled .rating').rating('disable');
    })
    ...
    "
    
    ui <- function() {
      shinyUI(
        semanticPage(
          title = "My page",
          tags$script(jsCode),
          # Your UI code
        )
      )
    }
    ...
    server <- shinyServer(function(input, output) {
      # Your Shiny logic
    })
    
    shinyApp(ui = ui(), server = server)

## How to contribute?

If you want to contribute to this project please submit a regular PR,
once you’re done with new feature or bug fix.<br>

**Changes in documentation**

Both repository **README.md** file and an official documentation page
are generated with Rmarkdown, so if there is a need to update them,
please modify accordingly a **README.Rmd** file and use “Knit”.

Documentation is rendered with `pkgdown`. Just run
`pkgdown::build_site()` after rendering new **README.md**.

## Troubleshooting

We used the latest versions of dependencies for this library, so please
update your R environment before installation.

However, if you encounter any problems, try the following:

1.  Up-to-date R language environment
2.  Installing specific dependent libraries versions

<!-- end list -->

  - shiny

<!-- end list -->

    install.packages("shiny", version='0.14.2.9001')

3.  Some bugs may be related directly to Semantic UI. In that case
    please try to check issues on its
    [repository.](https://github.com/fomantic/fomantic-ui)
4.  Some bugs may be related to **Bootstrap**. Please make sure you have
    it suppressed. Instructions are above in **How to use it?** section.

## Future enhacements

  - create all update functions for input components to mimic shiny as
    close as possible
  - add some glue code in `dsl.R` to make using this package smoother
  - adding more semantic components
  - new version release on CRAN

## Appsilon Data Science

<img src="https://avatars0.githubusercontent.com/u/6096772" align="right" alt="" width="6%" />

Appsilon is the **Full Service Certified RStudio Partner**. Learn more
at [appsilon.com](https://appsilon.com).

Get in touch [dev@appsilon.com](dev@appsilon.com)
