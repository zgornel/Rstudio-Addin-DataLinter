# Rstudio plugin for DataLinter
This is a R package that allows one to run [DataLinter](https://github.com/zgornel/DataLinter) from R studio.

## Installation and Usage

Make sure you have up-to-date stable versions of [devtools](https://github.com/hadley/devtools), [rstudioapi](https://github.com/rstudio/rstudioapi/), [shiny](https://github.com/rstudio/shiny) and [miniUI](https://github.com/rstudio/miniUI) installed before installing the package.

Install [DataLinter](https://github.com/zgornel/DataLinter) by pulling the Docker image:
```
docker pull ghcr.io/zgornel/datalinter-compiled:latest
```
and start a server as indicated in the documetation. The server will provide all linting functionality.

Install the package:
```r
devtools::install_github("zgornel/Rstudio-Addin-DataLinter")
```
Once the package is installed, addins will be avaiable under the 'Addins' menu in RStudio. 

An other way to launch via executing command in the console is as follows:
```r
RStudioAddins::datalinter()
```
