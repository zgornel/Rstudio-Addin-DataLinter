# Rstudio plugin for DataLinter
This is a R package that allows one to run [DataLinter](https://github.com/zgornel/DataLinter) from R studio.

[![License](http://img.shields.io/badge/license-GPL-brightgreen.svg?style=flat)](LICENSE)

## Installation

Make sure you have up-to-date stable versions of [devtools](https://github.com/hadley/devtools) and [rstudioapi](https://github.com/rstudio/rstudioapi/) installed before installing the package. Installing [shiny](https://github.com/rstudio/shiny) and [miniUI](https://github.com/rstudio/miniUI) is optional but recommended as the plugin is under development and may support UIs in the future.

### DataLinter
Install [DataLinter](https://github.com/zgornel/DataLinter) by pulling the Docker image:
```
docker pull ghcr.io/zgornel/datalinter-compiled:latest
```

### Rstudio plugin
Install the package:
```r
devtools::install_github("zgornel/Rstudio-Addin-DataLinter")
```
Once the package is installed, add-ins will be available under the 'Addins' menu in RStudio.

An other way to launch via executing command in the console is as follows:
```r
DataLinter::lint()
```

## Usage
The Rstudio plugin requires a server (which performs the actual linting) to function correctly. The linting server with can be started with:
```
docker run -it --rm -p10000:10000 \
    ghcr.io/zgornel/datalinter-compiled:latest \
        /datalinterserver/bin/datalinterserver \
            -i 0.0.0.0 \
            --config-path /datalinter/config/r_modelling_config.toml \
            --log-level debug
```
If the server starts correctly, it should display something like:
```
Warning: KB file not correctly specified, defaults will be used.
└ @ datalinterserver /DataLinter/apps/datalinterserver/src/datalinterserver.jl:83
[ Info: • Data linting server online @0.0.0.0:10000...
[ Info: Listening on: 0.0.0.0:10000, thread id: 1
```
Afterwards, one can use the plugin from Rstudio: the only requirement for it to work is that the varibles `LINTER_DATA` (a dataframe) and `LINTER_CODE` (some valid R code string) be visible An example of interactive use of the linter can be found in [R/example.R](https://github.com/zgornel/Rstudio-Addin-DataLinter/blob/master/R/example.R)
