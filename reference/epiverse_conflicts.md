# Conflicts between epiverse packages and other packages

Lists all function conflicts between epiverse packages and other
packages that you have loaded.

## Usage

``` r
epiverse_conflicts(only = NULL)
```

## Arguments

- only:

  Set this to a character vector to restrict to conflicts only with
  these packages.

## Value

An object of class `epiverse_conflicts`, invisibly. Printed output shows
which epiverse functions mask functions from other packages.

## Examples

``` r
if (FALSE) { # \dontrun{
epiverse_conflicts()
} # }
```
