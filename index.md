# epiverse

epiverse simplifies installing and loading the collection of R packages
maintained by the [Economic Policy Institute](https://www.epi.org/). A
single call to
[`library(epiverse)`](https://economic.github.io/epiverse/) attaches all
included packages and reports any function conflicts.

## Usage

``` r
library(epiverse)
#> Warning: package 'epiverse' was built under R version 4.5.3
#> Warning: package 'epiextractr' was built under R version 4.5.3
#> Warning: package 'prefab' was built under R version 4.5.3
#> ── Attaching epiverse packages ─────────────────────────────── epiverse 0.1.0 ──
#> ✔ epidatatools 1.0.1         ✔ prefab       0.1.0    
#> ✔ epiextractr  0.11.1        ✔ realtalk     2026.3.11
#> ✔ epitargets   0.2.0         ✔ swadlr       0.2.0
```

## Packages

| Package                                                  | Description                                        |
|----------------------------------------------------------|----------------------------------------------------|
| [epidatatools](https://economic.github.io/epidatatools/) | Tools for working with EPI data                    |
| [epiextractr](https://economic.github.io/epiextractr/)   | Extract and process CPS microdata                  |
| [epitargets](https://economic.github.io/epitargets/)     | targets pipeline helpers for EPI projects          |
| [prefab](https://economic.github.io/prefab/)             | Opinionated theme system for R project scaffolding |
| [realtalk](https://economic.github.io/realtalk/)         | Inflation adjustment for price data                |
| [swadlr](https://economic.github.io/swadlr/)             | State of Working America Data Library in R         |

## Installation

Install the epiverse from r-universe:

``` r
install.packages(
  "epiverse",
  repos = c("https://economic.r-universe.dev", getOption("repos"))
)
```

If you add the EPI r-universe repo to your `.Rprofile` with

``` r
# Example .Rprofile
options(repos = c(
  epi = "https://economic.r-universe.dev",
  getOption("repos")
))
```

then you can simply

``` r
install.packages("epiverse")
```

## Acknowledgments

This package draws heavily on the architecture of the
[tidyverse](https://tidyverse.tidyverse.org/) package by Hadley Wickham.

## License

MIT
