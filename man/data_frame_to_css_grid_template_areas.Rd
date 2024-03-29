% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/grid.R
\name{data_frame_to_css_grid_template_areas}
\alias{data_frame_to_css_grid_template_areas}
\title{Generate CSS string representing grid template areas.}
\usage{
data_frame_to_css_grid_template_areas(areas_dataframe)
}
\arguments{
\item{areas_dataframe}{data.frame of character representing grid areas}
}
\value{
character
}
\description{
Generate CSS string representing grid template areas.
}
\details{
This is a helper function used in grid_template()

\preformatted{
areas_dataframe <- rbind(
   c("header", "header", "header"),
   c("menu",   "main",   "right1"),
   c("menu",   "main",   "right2")
)

result == "'header header header' 'menu main right1' 'menu main right2'"
}
}
\keyword{internal}
