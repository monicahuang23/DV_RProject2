require(tidyr)
require(dplyr)
require(ggplot2)
require (jsonlite)
require (RCurl)

df <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from hospital_general_information"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_mh42375', PASS='orcl_mh42375', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))

x <- df %>% group_by(STATE, HOSPITAL_TYPE) %>% summarise(n = n())

plot1 <- ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_continuous() +
  labs(title='Number of Hospitals per State') +
  labs(x="State", y=paste("Number of Hospitals"))  +
  layer(data=x, 
        mapping=aes(x=STATE, y= n , color = as.character(HOSPITAL_TYPE)), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list(),
        position= position_jitter(width=0.3)
  ) + theme(axis.text.x=element_text(angle= 80, vjust=0.8, lineheight = 1.5),panel.grid.major =element_line(size=0.1))

plot1
