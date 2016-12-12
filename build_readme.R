# Small script for generating github readme and github pages.

rmarkdown::render("README.Rmd", output_format = "github_document")
rmarkdown::render("README.Rmd", output_format = "html_document", output_file = "docs/index.html")
file.remove("README.html")
file.remove("docs/index.md")

browseURL("docs/index.html")
