report.samatekt_scrape <- function(
  raw.text, 
  page.number = 2,
  tag.in.first.row = 'Hegningarlagabrot',
  tag.in.last.row = 'Innbrot á heimili'
  ){
  
  #mánuður og ár
  man.ar <- fGet.month.and.year(raw.text)
  month <- man.ar[1]
  # ár
  year <- man.ar[2]
  
  pg <- raw.text %>% str_split('\n', simplify = FALSE)
  table.pg <- pg[[page.number]]
  
  #nafn á síðu: Þetta virðist yfirleitt vera orðið "aðferð" 
  page.name <- table.pg[1]
  if(str_detect(page.name,'Aðferð')){
    page.name <- 'Samantekt'
  } else {
      page.name
    }
  
  # Sækja töfluna
  samantekt.tafla.start <- table.pg %>% str_which(tag.in.first.row)
  samantekt.tafla.end <- table.pg %>% str_which(tag.in.last.row)
  
  # taflan sjálf
  samantekt.tafla <- table.pg[seq(samantekt.tafla.start, samantekt.tafla.end)]
  table.data <- samantekt.tafla %>% str_replace_all("\\s{2,}", "|")
  text_con <- textConnection(table.data)
  data.table <- read.csv(text_con, sep = "|", header = FALSE, stringsAsFactors = FALSE)
  
  # vel gagnlega dálka
  d.out <- data.table %>%  mutate(
    year = year, 
    month = month, 
    page_name = 
      str_replace(page.name, '\\r', ''),
    incident_count = as.integer(V4)
  ) %>%
    select(page_name, year, month, atvik = V2, incident_count)
  
  return(d.out)
}
