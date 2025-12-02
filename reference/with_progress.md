# Reporting progress (functional API)

Reports progress to the user during long-running operations.

## Usage

``` r
with_progress(
  expr,
  min = 0,
  max = 1,
  value = min + (max - min) * 0.1,
  message = NULL,
  session = getDefaultReactiveDomain(),
  env = parent.frame(),
  quoted = FALSE
)

withProgress(
  expr,
  min = 0,
  max = 1,
  value = min + (max - min) * 0.1,
  message = NULL,
  session = getDefaultReactiveDomain(),
  env = parent.frame(),
  quoted = FALSE,
  ...
)

setProgress(
  value = NULL,
  message = NULL,
  session = getDefaultReactiveDomain(),
  ...
)

set_progress(
  value = NULL,
  message = NULL,
  session = getDefaultReactiveDomain()
)

incProgress(
  amount = 0.1,
  message = NULL,
  session = getDefaultReactiveDomain(),
  ...
)

inc_progress(
  amount = 0.1,
  message = NULL,
  session = getDefaultReactiveDomain(),
  ...
)
```

## Arguments

- expr:

  The work to be done. This expression should contain calls to
  \`set_progress\`.

- min:

  The value that represents the starting point of the progress bar. Must
  be less tham \`max\`. Default is 0.

- max:

  The value that represents the end of the progress bar. Must be greater
  than \`min\`. Default is 1.

- value:

  Single-element numeric vector; the value at which to set the progress
  bar, relative to \`min\` and \`max\`.

- message:

  A single-element character vector; the message to be displayed to the
  user, or \`NULL\` to hide the current message (if any).

- session:

  The Shiny session object, as provided by \`shinyServer\` to the server
  function. The default is to automatically find the session by using
  the current reactive domain.

- env:

  The environment in which \`expr\` should be evaluated.

- quoted:

  Whether \`expr\` is a quoted expression (this is not common).

- ...:

  Arguments that may have been used in \`shiny::withProgress\`

- amount:

  For \`inc_progress\`, the amount to increment the status bar. Default
  is 0.1.

## Details

This package exposes two distinct programming APIs for working with
progress. Using \`with_progress\` with \`inc_progress\` or
\`set_progress\` provide a simple function-based interface, while the
\[Progress()\] reference class provides an object-oriented API.

Use \`with_progress\` to wrap the scope of your work; doing so will
cause a new progress panel to be created, and it will be displayed the
first time \`inc_progress\` or \`set_progress\` are called. When
\`with_progress\` exits, the corresponding progress panel will be
removed.

The \`inc_progress\` function increments the status bar by a specified
amount, whereas the \`set_progress\` function sets it to a specific
value, and can also set the text displayed.

Generally, \`with_progress\`/\`inc_progress\`/\`set_progress\` should be
sufficient; the exception is if the work to be done is asynchronous
(this is not common) or otherwise cannot be encapsulated by a single
scope. In that case, you can use the \`Progress\` reference class.

When migrating from shiny applications, the functions \`withProgress\`,
\`incProgress\` and \`setProgress\` are aliases for \`with_progress\`,
\`inc_progress\` and \`set_progress\`.

## See also

\[Progress()\]

## Examples

``` r
## Only run examples in interactive R sessions
if (interactive()) {

ui <- semanticPage(
  plotOutput("plot")
)

server <- function(input, output) {
  output$plot <- renderPlot({
    with_progress(message = 'Calculation in progress',
                 detail = 'This may take a while...', value = 0, {
      for (i in 1:15) {
        inc_progress(1/15)
        Sys.sleep(0.25)
      }
    })
    plot(cars)
  })
}

shinyApp(ui, server)
}
```
