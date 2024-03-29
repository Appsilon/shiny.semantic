% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/step.R
\name{single_step}
\alias{single_step}
\title{Creates a single step to be used inside of a list of steps by the steps
function}
\usage{
single_step(
  id,
  title,
  description = NULL,
  icon_class = NULL,
  step_class = NULL
)
}
\arguments{
\item{id}{The \code{input} slot that will be used to access the value.}

\item{title}{A character that will be the title of the ste}

\item{description}{A character that will fill the description of the step}

\item{icon_class}{A character which will be correpond to a fomantic icon
class to be used in the step}

\item{step_class}{A character representing a class to be passed to the step}
}
\description{
Creates a single step to be used inside of a list of steps by the steps
function
}
\seealso{
steps
}
