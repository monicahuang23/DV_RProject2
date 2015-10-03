require(tidyr)
require(dplyr)
require(ggplot2)
require (jsonlite)
require (RCurl)

x <- df %>% group_by (STATE) %>% mutate (TOTAL = n(), LESS_THAN_5 = between (TOTAL, 0, 5), LESS_THAN_10 = between (TOTAL, 0, 10)) %>% filter(EMERGENCY_SERVICES == "true", LESS_THAN_10 == "TRUE") %>%  tbl_df
head(x)

#df %>% group_by (STATE) %>% mutate (TOTAL = n(), LESS_THAN_10 = between (TOTAL, 0, 10), LESS_THAN_20 = between (TOTAL, 0, 20)) %>% filter(EMERGENCY_SERVICES == "true", LESS_THAN_20 == "TRUE") %>% ggplot(aes(x=STATE, y=HOSPITAL_OWNERSHIP, color=as.character(LESS_THAN_10))) + geom_point(position = position_jitter()) + facet_wrap(~LESS_THAN_10)

ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_discrete() +
  #facet_wrap(~LESS_THAN_5) +
  labs(title='State Hospitals and Number of Emergencies') +
  labs(x="States with less than 10 emergencies", y=paste("Hospital Ownership Type")) +
  layer(data=x, 
        mapping=aes(x=as.character(STATE), y=as.character(HOSPITAL_OWNERSHIP), color=as.character(LESS_THAN_5)), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list(), 
        position=position_jitter(width=0.3, height=0.3)
  )