

report.collect.graphs <- function(
  tags = c('Þjó', 
           'Líkamsárás,',
           'Önnur ofbeldisbrot',
           'Rúðubrot',
           'Veggjakrot',
           'Meiriháttar eignaspjöll',
           'Önnur minniháttar eignaspjöll')
){
  
  # fæ ekki lapply til að virka?
  
  f <- function(x){report.tag.table.scrape(x, tag = 'Þjó')}
  thjofnadir <- map_df(raw_text, f)
  thjofnadir <- distinct(thjofnadir)
  
  f <- function(x){report.tag.table.scrape(x, tag = 'Líkamsárás,')}
  likamsaras <- map_df(raw_text, f)
  likamsaras <- distinct(likamsaras)
  
  f <- function(x){report.tag.table.scrape(x, tag = 'Önnur ofbeldisbrot')}
  onnurOfbeldisbrot <- map_df(raw_text, f)
  onnurOfbeldisbrot <- distinct(onnurOfbeldisbrot)
  
  f <- function(x){report.tag.table.scrape(x, tag = 'Rúðubrot')}
  rudubrot <- map_df(raw_text, f)
  rudubrot <- distinct(rudubrot)
  
  f <- function(x){report.tag.table.scrape(x, tag = 'Veggjakrot')}
  veggjakrot <- map_df(raw_text, f)
  veggjakrot <- distinct(veggjakrot)
  
  f <- function(x){report.tag.table.scrape(x, tag = 'Önnur minniháttar eignaspjöll')}
  eignarspjoll <- map_df(raw_text, f)
  eignarspjoll <- distinct(eignarspjoll)
  
  f <- function(x){report.tag.table.scrape(x, tag = 'Meiriháttar eignaspjöll')}
  eignarspjoll2 <- map_df(raw_text, f)
  eignarspjoll2 <- distinct(eignarspjoll2)
  
  c.frae <- rbind(thjofnadir,
                  likamsaras,
                  onnurOfbeldisbrot,
                  rudubrot,
                  veggjakrot,
                  eignarspjoll,
                  eignarspjoll2)
  
  return(c.frae)
}


## virkar ekki 
# f <- function(x){report.tag.table.scrape(x, tag = 'Fyrirtæki/stofnun')}
# innbrot1 <- map_df(raw_text, f)
# innbrot1 <- distinct(innbrot1)

# f <- function(x){report.tag.table.scrape(x, tag = 'Heimili/einkalóð')}
# innbrot2 <- map_df(raw_text, f)
# innbrot2 <- distinct(innbrot1)

# f <- function(x){report.tag.table.scrape(x, tag = 'Ökutæki')}
# innbrot3 <- map_df(raw_text, f)
# innbrot3 <- distinct(innbrot1)
