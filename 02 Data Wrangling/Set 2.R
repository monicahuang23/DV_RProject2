require(tidyr)
require(dplyr)
require(ggplot2)
require (jsonlite)
require (RCurl)

df <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from hospital_general_information"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_mh42375', PASS='orcl_mh42375', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))

x <- df %>% filter(HOSPITAL_TYPE == "Childrens") %>% group_by(STATE, HOSPITAL_TYPE, HOSPITAL_OWNERSHIP) %>% summarise(n = n())

plot2 <- ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_discrete() +
  labs(title='Childrens Hospitals By State') +
  labs(x="State", y=paste("Number of Hospitals"))  +
  layer(data=x, 
        mapping=aes(x=STATE, y = n , color = as.character(HOSPITAL_OWNERSHIP)), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list(),
        position= position_jitter(width = 0.3, height=0)
  )

plot2