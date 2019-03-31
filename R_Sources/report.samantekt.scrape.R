
rm(list = ls())

# https://www.logreglan.is/utgafa/tolfraedi/
pdf_names <- list.files(
  path = './_GognInn/', 
  pattern = 'Lykiltolur',
  full.names = TRUE)

raw_text <- lapply(pdf_names, pdf_text)

raw.text <- raw_text[[1]]
t1 <- raw.text %>% 
  str_split('\n', simplify = FALSE) 

samantekt <- t1[[2]]

#nafn á síðu
page.name <- samantekt[1]

# Sækja töfluna
samantekt.tafla.start <- samantekt %>% str_which('Hegningarlagabrot')
samantekt.tafla.end <- samantekt %>% str_which('Innbrot á heimili')

# nafn á töflu
month <- samantekt[samantekt.tafla.start -2]
month <- month %>%
  stringr::str_squish() %>% 
  str_extract(".+?(?=\\s)")

# ár
year <- samantekt[samantekt.tafla.start -1]
year <- year %>%
  stringr::str_squish() %>% 
  str_extract(".+?(?=\\s)")

# taflan sjálf
samantekt.tafla <- samantekt[seq(samantekt.tafla.start, samantekt.tafla.end)]
table.data <- samantekt.tafla %>% str_replace_all("\\s{2,}", "|")
text_con <- textConnection(table.data)
data.table <- read.csv(text_con, sep = "|", header = FALSE)




