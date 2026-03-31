# RStudio plugin for DataLinter
This is a R package that allows one to run [DataLinter](https://github.com/zgornel/DataLinter) from RStudio.

[![License](http://img.shields.io/badge/license-GPL-brightgreen.svg?style=flat)](LICENSE)

![til](./gifs/rstudio_linting.gif)


## Installation

Make sure you have up-to-date stable versions of [devtools](https://github.com/hadley/devtools) or [pak](https://pak.r-lib.org/) and [rstudioapi](https://github.com/rstudio/rstudioapi/) installed before installing the package.

### DataLinter
Install [DataLinter](https://github.com/zgornel/DataLinter) by pulling the Docker image:
```
docker pull ghcr.io/zgornel/datalinter-compiled:latest
```

### RStudio plugin
Install the package:
```r
pak::pak("zgornel/Rstudio-Addin-DataLinter")
```
or, using `devtools`:
```r
devtools::install_github("zgornel/Rstudio-Addin-DataLinter")
```
Once the package is installed, add-ins will be available under the 'Addins' menu in RStudio.

## Usage
The RStudio plugin requires a server (which performs the actual linting) to function correctly. The linting server with can be started with:
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

Afterwards, one can use the plugin from RStudio:
 - selected code will be sent to the linter
 - if the code contains a `data = my_variable` field, `my_variable` will be sent as well to the linter
 - if `data=...` field is not present, a variable named `LINTER_DATA` has to be defined and its contents will be sent to the linter;

## License

This code has an GPLv3 license.


## Reporting Bugs

Please [file an issue](https://github.com/zgornel/Rstudio-Addin-DataLinter/issues/new) to report a bug or request a feature.


## References

[1] https://en.wikipedia.org/wiki/Lint_(software)
