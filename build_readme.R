# Small script for generating github readme and github pages.
rm(params)

unlink("README_files/", recursive = TRUE)
file.remove("docs/index.html")
file.remove("README.md")
rmarkdown::render("README.Rmd", output_format = "github_document", runtime = "static", params = list(escape_script=TRUE))
rmarkdown::render("README.Rmd", output_format = "html_document", output_file = "docs/index.html")
file.remove("README.html")
file.remove("docs/index.md")

browseURL("docs/index.html")
