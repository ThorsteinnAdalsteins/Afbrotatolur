# #################################
# Titlar á töflu
#  Hér vantar mig mánuð-ár einkenni þar sem taflan getur
#  farið yfir áramót
# ##########################
# sæki fyrst listann
fGet.mon.tibble <- function(raw.text, 
                            page.number = 4,
                            tag.in.first.row = 'Þjófnaður - innbrot',
                            tag.in.last.row = 'Þjófnaður - annað'){
  
  
  ar.man <- fGet.month.and.year(raw.text)
  
  pg <- raw.text %>% str_split('\n', simplify = TRUE)
  
  month.rows <- pg %>% str_which('jan\\s{2,}feb')
  month.rows <- month.rows[1]
  
  mon <- pg[month.rows[1]]  # or -2
  mon <- mon %>%
    stringr::str_squish() %>% 
    str_extract_all("[:alpha:]{2,}")%>% unlist()
  # tengi þennan lista við map.MAN sem er með vörpun á fyrir alla mánuði
  mon.tibble <- tibble(man=mon) %>% inner_join(map.MAN, by = 'man')
  # set árið í fyrra inn
  mon.tibble$ar <- as.integer(ar.man[2])-1
  # þarf að lagfæra árið 
  aramot <- FALSE
  for(i in seq(2, nrow(mon.tibble))){
    if(mon.tibble$mo[i]==1){aramot <- TRUE}
    if(aramot){
      mon.tibble$ar[i] <- mon.tibble$ar[i]+1
    }
  }
  mon.tibble$dalkur <- str_c(mon.tibble$manudur, mon.tibble$ar, sep = '-')
  # hér ættu titlar á alla dálka að vera tilbúnir.
  return(mon.tibble)
}
