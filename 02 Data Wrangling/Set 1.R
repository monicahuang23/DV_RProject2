require(tidyr)
require(dplyr)
require(ggplot2)
require (jsonlite)
require (RCurl)
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
