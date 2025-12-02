# Reporting progress (object-oriented API)

Reporting progress (object-oriented API)

Reporting progress (object-oriented API)

## Details

Reports progress to the user during long-running operations.

This package exposes two distinct programming APIs for working with
progress. \[withProgress()\] and \[setProgress()\] together provide a
simple function-based interface, while the \`Progress\` reference class
provides an object-oriented API.

Instantiating a \`Progress\` object causes a progress panel to be
created, and it will be displayed the first time the \`set\` method is
called. Calling \`close\` will cause the progress panel to be removed.

As of version 0.14, the progress indicators use Shiny's new notification
API. If you want to use the old styling (for example, you may have used
customized CSS), you can use \`style="old"\` each time you call
\`Progress\$new()\`. If you don't want to set the style each time
\`Progress\$new\` is called, you can instead call
\[\`shinyOptions(progress.style="old")\`\]\[shinyOptions\] just once,
inside the server function.

## See also

\[with_progress()\]

## Methods

### Public methods

- [`Progress$new()`](#method-Progress-new)

- [`Progress$set()`](#method-Progress-set)

- [`Progress$inc()`](#method-Progress-inc)

- [`Progress$getMin()`](#method-Progress-getMin)

- [`Progress$getMax()`](#method-Progress-getMax)

- [`Progress$getValue()`](#method-Progress-getValue)

- [`Progress$close()`](#method-Progress-close)

- [`Progress$clone()`](#method-Progress-clone)

------------------------------------------------------------------------

### Method [`new()`](https://rdrr.io/r/methods/new.html)

Creates a new progress panel (but does not display it).

#### Usage

    Progress$new(session = getDefaultReactiveDomain(), min = 0, max = 1, ...)

#### Arguments

- `session`:

  The Shiny session object, as provided by \`shinyServer\` to the server
  function.

- `min`:

  The value that represents the starting point of the progress bar. Must
  be less than \`max\`.

- `max`:

  The value that represents the end of the progress bar. Must be greater
  than \`min\`.

- `...`:

  Arguments that may have been used for \`shiny::Progress\`

------------------------------------------------------------------------

### Method `set()`

Updates the progress panel. When called the first time, the progress
panel is displayed.

#### Usage

    Progress$set(value = NULL, message = NULL, ...)

#### Arguments

- `value`:

  Single-element numeric vector; the value at which to set the progress
  bar, relative to \`min\` and \`max\`. \`NULL\` hides the progress bar,
  if it is currently visible.

- `message`:

  A single-element character vector; the message to be displayed to the
  user, or \`NULL\` to hide the current message (if any).

- `...`:

  Arguments that may have been used for \`shiny::Progress\`

------------------------------------------------------------------------

### Method `inc()`

Like \`set\`, this updates the progress panel. The difference is that
\`inc\` increases the progress bar by \`amount\`, instead of setting it
to a specific value.

#### Usage

    Progress$inc(amount = 0.1, message = NULL, ...)

#### Arguments

- `amount`:

  For the \`inc()\` method, a numeric value to increment the progress
  bar.

- `message`:

  A single-element character vector; the message to be displayed to the
  user, or \`NULL\` to hide the current message (if any).

- `...`:

  Arguments that may have been used for \`shiny::Progress\`

------------------------------------------------------------------------

### Method `getMin()`

Returns the minimum value.

#### Usage

    Progress$getMin()

------------------------------------------------------------------------

### Method `getMax()`

Returns the maximum value.

#### Usage

    Progress$getMax()

------------------------------------------------------------------------

### Method `getValue()`

Returns the current value.

#### Usage

    Progress$getValue()

------------------------------------------------------------------------

### Method [`close()`](https://rdrr.io/r/base/connections.html)

Removes the progress panel. Future calls to \`set\` and \`close\` will
be ignored.

#### Usage

    Progress$close()

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    Progress$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
## Only run examples in interactive R sessions
if (interactive()) {

ui <- semanticPage(
  plotOutput("plot")
)

server <- function(input, output, session) {
  output$plot <- renderPlot({
    progress <- Progress$new(session, min=1, max=15)
    on.exit(progress$close())

    progress$set(message = 'Calculation in progress')

    for (i in 1:15) {
      progress$set(value = i)
      Sys.sleep(0.5)
    }
    plot(cars)
  })
}

shinyApp(ui, server)
}
```
