fGet.month.year.match <- function(m, y){
  
  message(paste(m, collapse = '-'))
  # find the second jan
  jan.index <- str_which(m, 'jan')
  
  message('fann jan.index = ', max(jan.index))
  jan.index <- max(jan.index)
  
  message('lengd á m = ', length(m))
  yearvec <- character(length(m))
  
  yearvec[seq(jan.index, length(m))] <- as.integer(y)
  yearvec[seq(1, jan.index-1 )] <- y-1
  
  ret.string <- str_c(m, yearvec, sep = '/')
  message('-- lokið -- ')
  return(ret.string)
}
