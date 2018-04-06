FROM r-base:3.4.1

RUN apt-get update  \
  && apt-get install libcurl4-openssl-dev -y \
  && apt-get install libssl-dev -y \
  && apt-get install libxml2-dev -y \
  && apt-get install libc6-dev -y \
  && apt-get install perl -y \
  && apt-get install git ssh texlive-latex-base -y \
  && rm -rf /var/lib/apt/lists/*

RUN apt-get update  \
  && apt-get install texlive-fonts-recommended -y \
  && rm -rf /var/lib/apt/lists/*

# Steps divided to fix failing CRAN installation of rigraph which is dependency of lintr: https://github.com/igraph/igraph/pull/1020
RUN R -e "install.packages(c('shiny', 'htmlwidgets', 'testthat', 'purrr', 'roxygen2', 'devtools'), repos='http://cran.us.r-project.org')"  \
  && R -e "install.packages(c('dplyr', 'gapminder'), repos='http://cran.us.r-project.org')" \ 
  && R -e "devtools::install_github('igraph/rigraph')" \
  && R -e "install.packages(c('lintr'), repos='http://cran.us.r-project.org')"
