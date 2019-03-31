report.graph.scrape <- function(
  raw.text, 
  page.number = 4,
  tag.in.first.row = 'Þjófnaður - innbrot',
  tag.in.last.row = 'Þjófnaður - annað'){
  
  pg <- raw.text %>% 
    str_split('\n', simplify = FALSE)
  
  table.pg <- pg[[page.number]]
  
  #nafn á síðu
  page.name <- str_extract(tag.in.first.row, ".+?(?=\\s)")
  
  # Sækja töfluna
  t.start <- table.pg %>% str_which(tag.in.first.row)
  t.end <- table.pg %>% str_which(tag.in.last.row)
  
  # ár
  year <- fGet.report.year(raw.text)
  table.pg
  # Titlar á töflu
  
  month.row <- table.pg %>% str_which('jan\\s{2,}feb')
  month <- table.pg[month.row]  # or -2
  month <- month %>%
    stringr::str_squish() %>% 
    str_extract_all("[:alpha:]{2,}")%>% unlist()
  
  month <- fGet.month.year.match(month, year)
  
  # taflan sjálf
  raw.table <- table.pg[seq(t.start, t.end)]
  table.data <- raw.table %>% str_replace_all("\\s{2,}", "|")
  text_con <- textConnection(table.data)
  data.table <- read.csv(text_con, sep = "|", header = FALSE)
  
  data.table.trim <- data.table %>% 
    select(paste('V', 2:15, sep = '')) %>%
    filter(!is.na(V3), !str_detect(V2, 'alls')) %>%
    mutate(V2 = str_remove_all(V2, '\\s'))
  
  names(data.table.trim) <- c('V2', month)
  
  d.out <- data.table.trim %>% 
    gather(month, key = 'monthYear', value = 'incident_count') %>%
    separate(monthYear, c('month', 'year'), sep = '/') %>%
    separate(V2, c('page_name', 'atvik'), sep = '-')
  
  d.out <- d.out %>% select(page_name, year, month, atvik , incident_count)
  
  return(d.out)
}
