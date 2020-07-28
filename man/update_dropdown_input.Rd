% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dropdown.R
\name{update_dropdown_input}
\alias{update_dropdown_input}
\title{Update dropdown Semantic UI component}
\usage{
update_dropdown_input(
  session,
  input_id,
  choices = NULL,
  choices_value = choices,
  value = NULL
)
}
\arguments{
\item{session}{The \code{session} object passed to function given to \code{shinyServer}.}

\item{input_id}{The id of the input object}

\item{choices}{All available options one can select from. If no need to update then leave as \code{NULL}}

\item{choices_value}{What reactive value should be used for corresponding choice.}

\item{value}{The initially selected value.}
}
\description{
Change the value of a \code{\link{dropdown_input}} input on the client.
}