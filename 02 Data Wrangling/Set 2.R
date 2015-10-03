x <- df %>% filter(HOSPITAL_TYPE == "Childrens") %>% group_by(STATE, HOSPITAL_TYPE, HOSPITAL_OWNERSHIP) %>% summarize(n = n())

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