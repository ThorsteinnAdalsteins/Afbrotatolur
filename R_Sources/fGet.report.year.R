fGet.year <- function(
  raw.text, 
  page.number = 2,
  tag.in.first.row = 'Hegningarlagabrot',
  tag.in.last.row = 'Innbrot á heimili'
){
  
  pg <- raw.text %>% 
    str_split('\n', simplify = FALSE)
  
  table.pg <- pg[[page.number]]
  samantekt.tafla.start <- table.pg %>% str_which(tag.in.first.row)
  
  year <- table.pg[samantekt.tafla.start -1]
  year <- year %>% stringr::str_squish() %>% str_split('\\s') %>% unlist()
  year <- year[2] %>% trimws()
  
  return(as.integer(year))
}
