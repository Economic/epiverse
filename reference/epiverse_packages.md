# List all epiverse packages

Returns the names of all packages included in epiverse, read from the
package DESCRIPTION file at runtime.

## Usage

``` r
epiverse_packages(include_self = TRUE)
```

## Arguments

- include_self:

  If `TRUE`, includes "epiverse" itself in the list. Defaults to `TRUE`.

## Value

A character vector of package names.

## Examples

``` r
epiverse_packages()
#> [1] "epidatatools" "epiextractr"  "epitargets"   "epiverse"     "prefab"      
#> [6] "realtalk"     "swadlr"      
```
