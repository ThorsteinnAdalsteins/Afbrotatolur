report.samatekt_scrape <- function(
  raw.text, 
  page.number = 2,
  tag.in.first.row = 'Hegningarlagabrot',
  tag.in.last.row = 'Innbrot á heimili'){
  
  pg <- raw.text %>% 
    str_split('\n', simplify = FALSE)
  
  table.pg <- pg[[page.number]]
  
  #nafn á síðu
  page.name <- table.pg[1]
  
  # Sækja töfluna
  samantekt.tafla.start <- table.pg %>% str_which(tag.in.first.row)
  samantekt.tafla.end <- table.pg %>% str_which(tag.in.last.row)
  
  # nafn á töflu
  month <- table.pg[samantekt.tafla.start -2]
  month <- month %>%
    stringr::str_squish() %>% 
    str_extract(".+?(?=\\s)")
  
  # ár
  year <- fGet.report.year(raw.text)
 
  # taflan sjálf
  samantekt.tafla <- pg[seq(samantekt.tafla.start, samantekt.tafla.end)]
  table.data <- samantekt.tafla %>% str_replace_all("\\s{2,}", "|")
  text_con <- textConnection(table.data)
  data.table <- read.csv(text_con, sep = "|", header = FALSE, stringsAsFactors = FALSE)
  
  # vel gagnlega dálka
  d.out <- data.table %>%  mutate(
    year = year, 
    month = month, 
    page_name = 
      str_replace(page.name, '\\r', '')
  ) %>%
    select(page_name, year, month, atvik = V2, incident_count = V4)
  
  return(d.out)
}
