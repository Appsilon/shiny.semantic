# Small script for generating github readme and github pages.

TEMP_FILE <- '_README.Rmd'

create_tempfile <- function(output, type) {
  if (file.exists(output)) file.remove(output)
  lines <- readLines("README.Rmd")
  for (line in lines) {
    cat(line, file = output, append = TRUE, sep = "\n")
    if (line == "params:") {
      cat(paste0('   type: ', type), file = output, append = TRUE, sep = "\n")
    }
  }
}

create_tempfile(TEMP_FILE, 'text')
rmarkdown::render(TEMP_FILE, output_format = "github_document", output_file = 'README.md')
create_tempfile(TEMP_FILE, 'web')
rmarkdown::render(TEMP_FILE, output_format = "html_document", output_file = "docs/index.html")
file.remove(TEMP_FILE)
file.remove("README.html")
file.remove("docs/index.md")

browseURL("docs/index.html")
