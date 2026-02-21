# ggsegNspn500

This package contains dataset for plotting the
[nspn500](https://ggsegverse.github.io/ggsegNspn500/add%20url%20here)
atlas ggseg and ggseg3d.

Whitaker, K. J., Vértes, P. E., Romero-Garcia, R., Váša, F., Moutoussis,
M., Prabhu, G., … & Tait, R. (2016). Adolescence is associated with
genomically patterned consolidation of the hubs of the human brain
connectome. Proceedings of the National Academy of Sciences, 113(32),
9105-9110.

Romero-Garcia, R., Atienza, M., Clemmensen, L. H., & Cantero, J. L.
(2012). Effects of network resolution on topological properties of human
neocortex. Neuroimage, 59(4), 3522-3532.

To learn how to use these atlases, please look at the documentation for
[ggseg](https://ggsegverse.github.io/ggseg/) and
[ggseg3d](https://ggsegverse.github.io/ggseg3d)

## Installation

We recommend installing the ggseg-atlases through the ggseg
[r-universe](https://ggsegverse.r-universe.dev/ui#builds):

``` r
# Enable this universe
options(repos = c(
    ggsegverse = 'https://ggsegverse.r-universe.dev',
    CRAN = 'https://cloud.r-project.org'))

# Install some packages
install.packages('ggsegNspn500')
```

You can install the released version of ggsegNspn500 from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("ggsegverse/ggsegNspn500")
```

``` r
library(ggseg)
#> Warning: package 'ggseg' was built under R version 4.1.1
#> Loading required package: ggplot2
library(ggseg3d)
library(ggsegNspn500)

plot(nspn500) +
  theme(legend.position = "bottom", 
        legend.text = element_text(size = 9)) +
  guides(fill = guide_legend(ncol = 5))
```

![](reference/figures/README-unnamed-chunk-3-1.png)

``` r
library(dplyr)
ggseg3d(atlas = nspn500_3d) %>% 
  add_glassbrain() %>% 
  pan_camera("right lateral")
```

![](reference/figures/README-3d-plot.png)

Please note that the ‘ggsegNspn500’ project is released with a
[Contributor Code of
Conduct](https://ggsegverse.github.io/ggsegNspn500/CODE_OF_CONDUCT.md).
By contributing to this project, you agree to abide by its terms.
