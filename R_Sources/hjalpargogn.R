map.MAN <- tibble(
  manudur = c('Janúar', 'Febrúar', 'Mars', 'Apríl', 'Maí', 'Júní', 'Júlí', 'Ágúst', 'September',
               'Október', 'Nóvemer', 'Desember', 'Ágúst'),
  month = c('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 
            'October', 'November', 'December', 'August'),
  man = c('jan', 'feb', 'mar', 'apr', 'maí', 'jún', 'júl', 'ágú', 'sep', 'okt', 'nóv', 'des', 'ág'),
  Man = c('Jan', 'Feb', 'Mar', 'Apr', 'Maí', 'Jún', 'Júl', 'Ágú', 'Sep', 'Okt', 'Nóv', 'Des', 'Ág'),
  mo = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 8)

)


map.ATV <- tibble(
  atvik = c(
    c("Þjófnaður - innbrot", "Þjófnaður - hnupl","Þjófnaður - gsm", "Þjófnaður - reiðhjól", "Þjófnaður - annað", "Þjófnaður alls", "Líkamsárás, minniháttar", "Líkamsárás, meiriháttar/stórfelld","Önnur ofbeldisbrot","Rúðubrot","Veggjakrot","Önnur minniháttar eignaspjöll", "Meiriháttar eignaspjöll"),
    c("Hegningarlagabrot", "Þjófnaður",  "Manndráp og líkamsmeiðingar", "Ofbeldi gagnvart lögreglumanni",   "Kynferðisbrot",  "Eignaspjöll (Meiriháttar skemmdarverk)", "Eignaspjöll (Minniháttar skemmdarverk)",  "Nytjastuldur vélknúinna farartækja",  "Fíkniefni",  "Umferðarlagabrot",  "Akstur undir áhrifum ávana- og fíkniefna", "Ölvun við akstur",  "Innbrot á heimili")),
  incidents = c(
    c("Theft - B&E", "Theft - shoplifting","Theft - gsm", "Theft - bicycle", "Theft - other", "Theft total", "Attack, minor", "Attack, great bodily harm","Other physical violence","Window break","Grafiti","Other minor vandalism", "Major vandalism"),
    c("Violation", "Theft",  "Murder and great bodily harm", "Attack on a piece officer", "Sexual violation",  "Vandalism (major)", "Vandalism (minor)",  "Grand theft auto",  "Drugs",  "Traffic violations",  "DUI (drugs)", "DUI (alcohol)",  "Home invasion")),
  
  atvik.CD =  c(
    c("ÞJÓFNAÐUR - Innbrot", "ÞJÓFNAÐUR - Hnupl","ÞJÓFNAÐUR - GSM", "ÞJÓFNAÐUR - Reiðhjól", "ÞJÓFNAÐUR - Annar þjófnaður", "ÞJÓFNAÐUR - Alls", "LÍKAMSÁRÁS - Minniháttar áverkar", "LÍKAMSÁRÁS -  Meiriháttar áverkar, þ.á.m. morð", "LÍKAMSÁRÁS - Annað ofbeldi","EIGNARSPJÖLL - Rúðubrot", "EIGNARSPJÖLL - Veggjakrot","EIGNARSPJÖLL - Önnur minniháttar eignaspjöll", "EIGNARSPJÖLL - Meiriháttar eignaspjöll"),
    c("HEGNINGARLAGABROT - Alls", "ÞJÓFNAÐUR - Alls",  "LÍKAMSÁRÁS - Alls, þ.á.m. morð", "LÍKAMSÁRÁS - Gagnvart lögreglumanni",   "KYNFERÐISBROT - Alls",  "EIGNARSPJÖLL - Meiriháttar eignaspjöll", "EIGNARSPJÖLL - Minniháttar",  "ÞJÓFNAÐUR - Nytjastuldur vélknúinna farartækja",  "FÍKNIEFNI - Alls",  "UMFERÐ - Umferðarlagabrot",  "UMFERÐ - Akstur undir áhrifum ávana- og fíkniefna", "UMFERÐ - Ölvun við akstur",  "INNBROT - Heimili")),
  
  incidents.CD =  c(
    c("THEFT - Breaking and entering", "THEFT - Shoplifting","THEFT - GSM", "THEFT - Bicycles", "THEFT - Other theft", "THEFT - Total", "BODILY HARM - Minor injuries", "BODILY HARM -  Grivous, including murder", "BODILY HARM - Other violent offences","VANDALISM - Window breakage", "VANDALISM - Grafiti", "VANDALISM - Other minor property damage", "VANDALISM - Major property damage"),
    c("CRIMINAL OFFENCES - Total", "THEFT - Total",  "BODILY HARM - Total, including murder", "BODILY HARM - Toward peace officer",   "SEXUAL OFFENCES - Total",  "VANDALISM - Major property damage", "VANDALISM - Minor",  "THEFT - Vehicle theft",  "DRUG OFFENCES - Tota",  "MOVING VIOLATIONS - Traffic violations",  "MOVING VIOLATIONS - DUI (drugs)", "MOVING VIOLATIONS - DUI (alcohol)",  "BREAKING AND ENTERING - Homes"))
)
