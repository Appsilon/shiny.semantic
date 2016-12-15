
<link href="http://fonts.googleapis.com/css?family=Lato:300,700,300italic|Inconsolata" rel="stylesheet" type="text/css">

<link href='docs/style.css' rel='stylesheet' type='text/css'>

shiny.semantic
==============

Semantic UI wrapper for Shiny

With this library it's easy to wrap Shiny with Semantic UI components. Add few simple CSS classes to your components and achieve amazing boost look of your user interface.

<h2>
Before
</h2>
<!--html_preserve-->
<a>Client's info</a>
<p>
</p>
<!-- html table generated in R 3.3.1 by xtable 1.8-2 package -->
<!-- Thu Dec 15 13:03:15 2016 -->
<table class="table shiny-table table- spacing-s" style="width:auto;">
<thead>
<tr>
<th style="text-align: left;">
Name
</th>
<th style="text-align: left;">
City
</th>
<th style="text-align: left;">
Revenue
</th>
</tr>
</thead>
<tbody>
<tr>
<td>
John Smith
</td>
<td>
Warsaw, Poland
</td>
<td>
$210.50
</td>
</tr>
<tr>
<td>
Lindsay More
</td>
<td>
SF, United States
</td>
<td>
$172.78
</td>
</tr>
</tbody>
</table>

<!--/html_preserve-->

<h2>
After
</h2>
<!--html_preserve-->
<body style="min-height: 611px;">
<a class="ui green ribbon label">Client's info</a>
<p>
</p>
<!-- html table generated in R 3.3.1 by xtable 1.8-2 package -->
<!-- Thu Dec 15 13:03:15 2016 -->
<table class="ui very basic collapsing celled table">
<tr>
<th>
Name
</th>
<th>
City
</th>
<th>
Revenue
</th>
</tr>
<tr>
<td>
John Smith
</td>
<td>
Warsaw, Poland
</td>
<td>
$210.50
</td>
</tr>
<tr>
<td>
Lindsay More
</td>
<td>
SF, United States
</td>
<td>
$172.78
</td>
</tr>
</table>

</body>
<!--/html_preserve-->

<!-- #Basic tutorial article is available on [Appsilon Data Science blog](your_future_art_link). -->
<!-- Live demo link below -->
<!-- TODO Analogy to http://shiny.rstudio.com/gallery/widget-gallery.html -->
<p style="text-align: center; font-size: x-large;">
<a href="http://demo.appsilondatascience.com/shiny.semantic/components">Components live demo</a>
</p>
For better understanding it's good to check [Semantic UI documentation.](http://semantic-ui.com/introduction/getting-started.html)

Source code
-----------

This library source code can be found on [Appsilon Data Science's](http://appsilondatascience.com) Github: <br> <https://github.com/Appsilon/shiny.semantic>

<script>
document.write('<div class="logo"><a href="http://appsilondatascience.com"><img alt="Appsilon Data Science" src="https://cdn.rawgit.com/Appsilon/website-cdn/gh-pages/logo-white.png"/></a></div>')
</script>
How to install?
---------------

**Note! This library is still in its infancy. Api might change in the future.**

At the moment it's possible to install this library through [devtools](https://github.com/hadley/devtools).

    devtools::install_github("Appsilon/shiny.semantic")

To install [previous version]() you can run:

    devtools::install_github("Appsilon/shiny.semantic", ref = "0.1.0")

How to use it?
--------------

Firstly, you will have to invoke *shinyUI()* with *semanticPage()* instead of standard Shiny UI definitions like e.g. *fluidPage()*. From now on forward all components can ba annotated with Semantic UI specific CSS classes and also you will be able to use [shiny.semantic components](http://demo.appsilondatascience.com/shiny.semantic/components).<br> Please note that at the moment you have to pass page title in *semanticPage()*

    semanticPage(title = "Your page title", ...)

What's more some of Semantic UI components are required to run a certain JS code when DOM document is ready. There are at least 2 options to do this:

1.  Use [shinyjs](https://github.com/daattali/shinyjs)

<!-- -->

    library(shinyjs)
    ...
    jsCode <- "
    #Semantic UI componts JS
    "
    ...
    ui <- function() {
      shinyUI(
        semanticPage(
          title = "Your page title",
          shinyjs::useShinyjs(),
          #Your UI code
        )
      )
    }

    server <- shinyServer(function(input, output) {
      runjs(jsCode)
      # Your Shiny logic
    })

    shinyApp(ui = ui(), server = server)

1.  Use *shiny::tags$script()*

<!-- -->

    ...
    jsCode <- "
    $(document).ready(function() {
      $('.rating').rating('setting', 'clearable', true);
      $('.disabled .rating').rating('disable');
    })
    ...
    ui <- function() {
      shinyUI(semanticPage(
        title = "My page",
        tags$script(jsCode),
        #Your UI code
        )
      )
    }
    ...
    server <- shinyServer(function(input, output) {
      # Your Shiny logic
    })

    shinyApp(ui = ui(), server = server)
        

    library(shiny)
    library(shinyjs)
    #devtools::install_github("Appsilon/shiny.semantic")
    library(shiny.semantic)

    jsCode <- "
    $('.rating').rating('setting', 'clearable', true);
    $('.disabled .rating').rating('disable');
    "

    ui <- function() {
      shinyUI(
        semanticPage(
          title = "My page",
          shinyjs::useShinyjs(),
          div(class="ui raised segment",
              div(
                  "Your rating",
                  div(class="ui star rating", 'data-rating'="4", 'data-max-rating'="5")
              ),
              div(
                  span(class="right floated", uiicon("heart outline like"), "17 likes"),
                  uiicon("comment"),
                  "3 comments"
              )
            )
        )
      )
    }

    server <- shinyServer(function(input, output) {
      runjs(jsCode)
    })

    shinyApp(ui = ui(), server = server)

TODO Chris - write about invoking specific components JS, found in Semantic UI documentation.

<!--html_preserve-->
14h

<img class="ui avatar image" src="http://semantic-ui.com/images/avatar/large/elliot.jpg"/> Elliot

<img src="http://semantic-ui.com/images/wireframe/image.png"/>

<span class="right floated"> <i class="heart outline like icon"></i> 17 likes </span> <i class="comment icon"></i> 3 comments

<i class="heart ouline icon"></i> <input type="text" placeholder="Add Comment..."/>

<script type="application/json" data-for="htmlwidget-801ea52ffdadc31de1e9">{"x":"div(class = \"ui card\", div(class = \"content\", \n    div(class = \"right floated meta\", \"14h\"), \n    img(class = \"ui avatar image\", src = \"http://semantic-ui.com/images/avatar/large/elliot.jpg\"), \n    \"Elliot\"), div(class = \"image\", img(src = \"http://semantic-ui.com/images/wireframe/image.png\")), \n    div(class = \"content\", span(class = \"right floated\", \n        uiicon(\"heart outline like\"), \"17 likes\"), \n        uiicon(\"comment\"), \"3 comments\"), \n    div(class = \"extra content\", div(class = \"ui large transparent left icon input\", \n        uiicon(\"heart ouline\"), tags$input(type = \"text\", \n            placeholder = \"Add Comment...\"))))","evals":[],"jsHooks":[]}</script>

<!--/html_preserve-->
**More examples**

The source code for the live demo you were able to go to in the bigging is located in **/examples** folder. To run it locally you will have to install:

-   [**highlighter**](https://github.com/Appsilon/highlighter)

        devtools::install_github("Appsilon/highlighter")

Check out our dashboard examples:

1.  [Churn analytics](http://demo.appsilondatascience.com/shiny.semantic/churn)
2.  [Fraud detection](demo.appsilondatascience.com/shiny.semantic/frauds)

All dashboards source code can be found in **/demo** folder. You will have to follow the according README files to install all necessary dependencies for those projects.

How to contribute?
------------------

If you want to contribute to this project please submit a regular PR, once you're done with new feature or bug fix.<br>

**Changes in documentation**

Both repository **README.md** file and an official documentation page are generated with Rmarkdown, so if there is a need to update them, please modify accordingly a **README.Rmd** file and run a **build\_readme.R** script to compile it.

Troubleshooting
---------------

We used the latest versions of dependencies for this library, so please update your R environment before installation.

However, if you encounter any problems, try the following:

1.  Up-to-date R language environment
2.  Installing specific dependent libraries versions
    -   shiny

            install.packages("shiny", version='0.14.2.9001')

3.  Some bugs may be realted directly to Semantic UI. In that case please try to check issues on its [repository.](https://github.com/Semantic-Org/Semantic-UI)

Future enhacements
------------------

-   create all update functions for input components to mimic shiny as close as possible
-   add some glue code in dsl.R to make using this package smoother
-   CRAN release

Appsilon Data Science
=====================

<script>
document.write('<div class="subheader"> We Provide End-to-End Data Science Solutions </div>  <div class="logo"><a href="http://appsilondatascience.com"><img alt="Appsilon Data Science" src="https://cdn.rawgit.com/Appsilon/website-cdn/gh-pages/logo-white.png" /></a></div>');
</script>
Get in touch [dev@appsilondatascience.com](dev@appsilondatascience.com)

<script>
document.write('<a href="https://github.com/Appsilon/shiny.semantic"><img style="position: absolute; margin: 0; top: 0; right: 0; border: 0;" src="https://camo.githubusercontent.com/38ef81f8aca64bb9a64448d0d70f1308ef5341ab/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f6461726b626c75655f3132313632312e706e67" alt="Fork me on GitHub" data-canonical-src="https://s3.amazonaws.com/github/ribbons/forkme_right_darkblue_121621.png"></a>')
</script>
