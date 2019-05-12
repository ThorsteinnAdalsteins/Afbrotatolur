
rm(list = ls())
library(tidyverse)
source('./R_Sources/__init__.R')


# https://www.logreglan.is/utgafa/tolfraedi/
# skýrslur eru hér: https://issuu.com/logreglan/stacks/
pdf_names <- list.files(
  path = './_GognInn/umbrot1/', 
  pattern = 'Lykiltolur',
  full.names = TRUE)

## ###########################################
## 1) 
## sæki innihaldið í pdf skjölunum á textaformi
raw_text <- lapply(pdf_names, pdf_text)
names(raw_text) <- pdf_names

# raw.text <- raw_text[[4]]

## ##########################################
##  verkefni 1:
##    byrja á því að sækja samantektartöfluna á bls 2
##    þessi tafla er í flestum skjölunum
f <- function(x){
  report.samatekt_scrape(x, 
  page.number = 2,
  tag.in.first.row = 'Hegningarlagabrot',
  tag.in.last.row = 'Innbrot á heimili'
)
}

samantektir <- map_df(raw_text, f)
samantektir <- samantektir %>% as_tibble()

samantektir.cl <- samantektir %>% 
  left_join(map.ATV, by = 'atvik') %>%
  rename(manudur = month) %>%
  left_join(map.MAN, by = 'manudur') %>%
  separate(col = atvik.CD, into=c('flokkur', 'tegund'), sep=' - ') %>%
  separate(col = incidents.CD, into=c('type', 'incident'), sep=' - ') %>%
  select(ar=year, manudur, flokkur, tegund, count = incident_count, month, type, incident, page_name)

write.csv(samantektir.cl, './_GognUt/afbrotatolur_samantektir.csv', row.names = FALSE)


## ########################################
##  verkefni 2:
##    sæki tölur sem eru í töflum undir línuritum
##    þessar tölur eru oft viðbótartölur við það sem er í 
##    samantektinni. 
##      Þetta er ekki eins hreinleg skröpun og annað, en er í nokkrum
##    abströktum af föllum. Sennilega er hægt að vinna þetta á auðveldari hátt

details <- report.collect.graphs()

# hreinsa upp tölurnar lítillega
details.cl <- details %>% 
  separate(col = ManAr, into = c('manudur', 'ar'), sep = '-') %>% 
  left_join(map.ATV, by = 'atvik') %>%
  left_join(map.MAN, by = 'manudur') %>%
  separate(col = atvik.CD, into=c('flokkur', 'tegund'), sep=' - ') %>%
  separate(col = incidents.CD, into=c('type', 'incident'), sep=' - ') %>%
  mutate(page_name = 'Frekara niðurbrot') %>%
  select(ar, manudur, flokkur, tegund, count, month, type, incident, page_name)

write.csv(details.cl, './_GognUt/afbrotatolur_frekara_nidurbrot.csv', row.names = FALSE)


# prófa að þýða dálkana. Þýðingarnar eru í 
