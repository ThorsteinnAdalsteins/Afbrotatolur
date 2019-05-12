fGet.month <- function(
  raw.text, 
  page.number = 2,
  tag.in.first.row = 'Hegningarlagabrot',
  tag.in.last.row = 'Innbrot á heimili'
  ){
    pg <- raw.text %>% 
      str_split('\n', simplify = FALSE)
    
    table.pg <- pg[[page.number]]
    
    # Sækja töfluna
    samantekt.tafla.start <- table.pg %>% str_which(tag.in.first.row)
    samantekt.tafla.end <- table.pg %>% str_which(tag.in.last.row)
    
    ## hér kemur smá flækja:
    ##  Í sumum línum er hausinn á töflunni tvær línur, en stundum er hann þrjár
    ##  ef hann er tvær línur er mánuður í efri línu og ár í neðri línu
    ##  ef hann er þrjár línur er mánuður og ár í einni línu
    
    # mánuður
    month <- table.pg[samantekt.tafla.start -2]
    month <- month %>% str_squish() %>% str_split('\\s') %>% unlist()
    month <- month[2]
    
    return(month)
  }
