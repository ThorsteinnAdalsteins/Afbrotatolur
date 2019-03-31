fGet.report.year <- function(raw.text){
  
  pg <- raw.text %>% 
    str_split('\n', simplify = FALSE)
  
  table.pg <- pg[[2]]
  
  samantekt.tafla.start <- table.pg %>% str_which('Hegningarlagabrot')
  
  year <- table.pg[samantekt.tafla.start -1]
  year <- year %>%
    stringr::str_squish() %>% 
    str_extract_all(".+?(?=\\s)") %>% unlist()

  year <- year[2] %>% trimws()
  
  return(as.integer(year))
}
