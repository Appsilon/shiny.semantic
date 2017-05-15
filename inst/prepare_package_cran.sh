echo "==> Switching to cran-release branch."
cd ..
git checkout -B cran-release

echo "==> Preparing package for CRAN release."
rm -r docs/ examples/ CHANGELOG.md README.Rmd README_files build_readme.R examples/ readme_assets/ readme_rmd_template/ inst/semantic/.versions

# Debug comment to identify which files removed.
git status


echo "==> Building package tar.gz archive."
R CMD build ../shiny.semantic
zip_file=$(find *tar.gz)

echo "==> Checking package."
R CMD Rd2pdf $zip_file
R CMD check --as-cran $zip_file

echo "==> Reset."
git reset --hard
# git checkout master
