
#########################################################################################
# á blaðsíðu 4 eru línurit sem sýna fjölda þjófnaða og breytingu frá síðustu mánuðum
# þessar tölur gefa aðeins meira niðurbrot en gert er í samantektartöflunni
# þó svo að hér séu margir mánuðir í einni töflu þarf ekki að sækja nema síðasta mánuðinn
# með því að sækja alla töfluna er hins vegar hægt að ná aðeins lengra aftur í tímann
report.graph.scrape <- function(
  raw.text, 
  page.number = 4,
  tag.in.first.row = 'Þjófnaður - innbrot',
  tag.in.last.row = 'Þjófnaður - annað',
  atvikaskraning = 1){
  
  
  ar.man <- fGet.month.and.year(raw.text)
  
  pg <- raw.text %>% str_split('\n', simplify = FALSE)
  
  
  table.pg <- pg[[page.number]]
  
  #nafn á síðu
  page.name <- str_extract(tag.in.first.row, ".+?(?=\\s)")
  
  
  # #################################
  # Titlar á töflu
  #  Hér vantar mig mánuð-ár einkenni þar sem taflan getur
  #  farið yfir áramót
  # ##########################
  # sæki fyrst listann
  month.row <- table.pg %>% str_which('jan\\s{2,}feb')
  mon <- table.pg[month.row]  # or -2
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
  
  # Sækja töfluna
  t.start <- table.pg %>% str_which(tag.in.first.row)
  t.end <- table.pg %>% str_which(tag.in.last.row)
  
  # taflan sjálf
  raw.table <- table.pg[seq(t.start, t.end)]
  table.data <- raw.table %>% str_replace_all("\\s{2,}", "|")
  text_con <- textConnection(table.data)
  data.table <- read.csv(text_con, sep = "|", header = FALSE)
  
  # reyni unpivot
  if(atvikaskraning == 1){
    data.table.trim <- data.table %>% 
      filter(str_detect(V2, page.name)) %>%
      select(paste('V', 2:15, sep = '')) %>%
      filter(!is.na(V3), !str_detect(V2, 'alls')) %>%
      mutate(V2 = V2 %>% str_replace('\\s-\\s|,\\s', '-'))
  } else if (atvikaskraning == 2){
    data.table.trim <- data.table %>% 
      select(paste('V', 2:15, sep = ''))  %>%
      mutate(V2 = str_c('Eignarspjöll', V2, sep = '-'))
  }

  
  # set nöfnin inn
  names(data.table.trim) <- c('V2', mon.tibble$dalkur)
  
  d.out <- data.table.trim %>% 
    gather(-V2, key = 'MY', value = 'incident_count') %>%
    separate(MY, c('month', 'year'), sep = '-') %>%
    separate(V2, c('page_name', 'incident'), sep = '-')
  
  d.out <- d.out %>% select(page_name, year, month, incident , incident_count)
  
  
  return(d.out)
}
