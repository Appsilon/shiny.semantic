#!/bin/bash
echo "==> Switching to cran-release branch."
BASENAME=$(dirname "$0")
if [ $BASENAME = "." ]; then
  cd ..
  git checkout -B temp_cran_release

  echo "==> Preparing package for CRAN release."
  rm -r build/ docs/ examples/ CHANGELOG.md README.Rmd README_files build_readme.R examples/ readme_assets/ readme_rmd_template/ inst/semantic/.versions

  mkdir build

  echo "==> Building package tar.gz archive."
  R CMD build ../shiny.semantic
  zip_file=$(find *tar.gz)

  echo "==> Checking package."
  R CMD check --as-cran $zip_file
  mv $zip_file build/
  rm -r shiny.semantic.Rcheck/

  echo "==> Reset."
  git reset --hard
  git checkout master
  git branch -D temp_cran_release
else
  echo "You must run script from /inst directory"
fi
