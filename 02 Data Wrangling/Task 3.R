require(tidyr)
require(dplyr)

# Creates the dataframe where all data is included
df <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from hospital_general_information"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_mh42375', PASS='orcl_mh42375', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))

View(df)

x <- df %>% select (STATE, HOSPITAL_OWNERSHIP, EMERGENCY_SERVICES) %>% filter(EMERGENCY_SERVICES == "true") %>% group_by (STATE) %>% mutate (TOTAL = n(), LESS_THAN_10 = between (TOTAL, 0, 10))  %>% tbl_df

head(x)
View(x)

#x %>% group_by (STATE) %>% filter(LESS_THAN_10 == "TRUE") %>% ggplot(aes(x=STATE, y=TOTAL, color=as.character(HOSPITAL_OWNERSHIP))) + geom_point(position = position_jitter()) + facet_wrap(~STATE)

df %>% group_by (STATE) %>% mutate (TOTAL = n(), LESS_THAN_10 = between (TOTAL, 0, 10), LESS_THAN_20 = between (TOTAL, 0, 20)) %>% filter(EMERGENCY_SERVICES == "true", LESS_THAN_20 == "TRUE") %>% ggplot(aes(x=STATE, y=HOSPITAL_OWNERSHIP, color=as.character(LESS_THAN_10))) + geom_point(position = position_jitter()) + facet_wrap(~LESS_THAN_10)

