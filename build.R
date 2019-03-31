
rm(list = ls())
source('./R_Sources/__init__.R')


# https://www.logreglan.is/utgafa/tolfraedi/
pdf_names <- list.files(
  path = './_GognInn/umbrot1/', 
  pattern = 'Lykiltolur',
  full.names = TRUE)

raw_text <- lapply(pdf_names, pdf_text)
names(raw_text) <- pdf_names


# raw.text <- raw_text[[4]]
samantektir <- map_df(raw_text, report.samatekt_scrape)
thjofnadir <- map_df(raw_text, report.graph.scrape)

report.graph.scrape(raw_text[[2]])
raw.text <- raw_text[[2]]
