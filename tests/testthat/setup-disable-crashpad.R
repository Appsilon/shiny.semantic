# ❯ checking for detritus in the temp directory ... NOTE
# Found the following files/directories:
#   ‘Crashpad’
#
# 0 errors ✔ | 0 warnings ✔ | 1 note ✖
# Error: Error: R CMD check found NOTEs
# Flavors: ubuntu-22.04 (devel), ubuntu-22.04 (release), ubuntu-22.04 (oldrel)

# References (shinytest2 github):
# 1. https://github.com/rstudio/shinytest2/blob/main/cran-comments.md
# 2. https://github.com/rstudio/shinytest2/blob/main/tests/testthat/setup-disable-crashpad.R

# Disable crash reporting on CRAN machines. (Can't get the report anyways)
chromote::set_chrome_args(c(
  # https://peter.sh/experiments/chromium-command-line-switches/#disable-crash-reporter
  #> Disable crash reporter for headless. It is enabled by default in official builds
  "--disable-crash-reporter",
  chromote::default_chrome_args()
))

# Make sure the temp folder is removed when testing is complete
withr::defer({

  # Clean up chromote sessions
  gc() # Run R6 finalizer methods
  Sys.sleep(2) # Wait for any supervisors to exit

  # Delete the Crashpad folder if it exists
  unlink(file.path(tempdir(), "Crashpad"), recursive = TRUE)
}, envir = testthat::teardown_env())
