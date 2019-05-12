
#################################################
## önnur aðferð þar sem ein lína er sótt í einu
## #############################################

report.tag.table.scrape <- function(raw.text, tag){
  # tag = 'zogs'
  mon.tibble <- fGet.mon.tibble(raw.text)
  ar.man <- fGet.month.and.year(raw.text)
  pg <- raw.text %>% str_split('\n', simplify = TRUE)
  
  selected.text <- pg %>% str_which(tag)
  
  if(length(selected.text)==0){return(NA)}
  
  selected.text.split <- pg[selected.text] %>% str_replace('\\r', '') %>% str_split('\\s{2,}')
  split.length <- lapply(selected.text.split, length) %>% unlist()
  split.length <- which(split.length >=15)
  
  if(length(split.length)==0){return(NA)}
  
  raw.tables <- lapply(split.length, function(i)selected.text.split[[i]][2:15]) 
  
  data.table <- do.call(rbind,raw.tables) %>% 
    as_tibble(.name_repair = 'unique')
  
  names(data.table) <- c('atvik', mon.tibble$dalkur)

  
  out.d <- data.table %>% 
    gather(-atvik, key='ManAr', value='count') %>% 
    mutate(count = as.integer(count))
  
  return(out.d)
}
