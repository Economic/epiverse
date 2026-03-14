
# epiverse

epiverse makes it easy to install and load the collection of R packages
maintained by the [Economic Policy Institute](https://www.epi.org/). A
single call to `library(epiverse)` attaches all included packages and
reports any function conflicts.

## Installation

``` r
install.packages(
  "epiverse",
  repos = c("https://economic.r-universe.dev", getOption("repos"))
)
```

Or from GitHub:

``` r
remotes::install_github("economic/epiverse")
```

## Usage

``` r
library(epiverse)
#> ── Attaching epiverse packages ─────────────────────────────── epiverse 0.1.0 ──
#> ✔ epidatatools 1.0.1          ✔ prefab       0.0.0.9000
#> ✔ epiextractr  0.11.0         ✔ realtalk     2026.3.11 
#> ✔ epitargets   0.2.0          ✔ swadlr       0.2.0
```

## Packages

| Package | Description |
|----|----|
| [epidatatools](https://economic.github.io/epidatatools/) | Tools for working with EPI data |
| [epiextractr](https://economic.github.io/epiextractr/) | Extract and process CPS microdata |
| [epitargets](https://economic.github.io/epitargets/) | targets pipeline helpers for EPI projects |
| [prefab](https://economic.github.io/prefab/) | Opinionated theme system for R project scaffolding |
| [realtalk](https://economic.github.io/realtalk/) | Inflation adjustment for price data |
| [swadlr](https://economic.github.io/swadlr/) | State of Working America Data Library in R |

## Acknowledgments

This package draws heavily on the architecture of the
[tidyverse](https://tidyverse.tidyverse.org/) package by Hadley Wickham.

## License

MIT
