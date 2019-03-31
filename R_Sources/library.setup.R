
require.or.install <- function(name.of.package)
{
  if (!require(name.of.package, character.only = TRUE))
  {
    install.packages(name.of.package, dep = TRUE)
    if(!require(name.of.package, character.only = TRUE)) stop("Package not found")
  }
}

require.or.install('tidyverse')
require.or.install('data.world')
require.or.install('lubridate')
require.or.install("pdftools")
require.or.install("glue")

rm(require.or.install)
