fGet.month.and.year <- function(
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
    ## í enn öðrum tilfellum eru skrifaðir mán-ár í línu 2
    # mánuður
    
    l1 <- table.pg[samantekt.tafla.start -1] %>% str_squish() %>% str_split('\\s') %>% unlist()
    l2 <- table.pg[samantekt.tafla.start -2] %>% str_squish() %>% str_split('\\s') %>% unlist()
    l3 <- table.pg[samantekt.tafla.start -3] %>% str_squish() %>% str_split('\\s') %>% unlist()
    
    if(length(l2)==2){
      month <- l2[1]
      year <- l2[2]
    } else if (length(l2)==4){
      month <- l2[3]
      year <- l2[4]
    } else {
      month <- l2[2]
      year <- l1[2]
    }
    
    return(c(month, year))
  }
