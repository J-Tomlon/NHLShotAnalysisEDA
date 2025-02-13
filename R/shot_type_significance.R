library(dplyr)

setwd("C:/Users/hocke/Dropbox/STA_486C/NOT_Project")

shots <- read.csv("shots_2021.csv")

shot.types.list = c("BACK","DEFL","SLAP","SNAP","TIP","WRAP","WRIST")

shots.stats <- shots %>%
  select(goal, shotType) %>%
  mutate(shotType = as.factor(shots$shotType)) %>%
  filter(shotType != "")

shots.stats$shotType <- factor(shots.stats$shotType, levels = shot.types.list)

shot.goal.table <- table(shots.stats$shotType, shots.stats$goal)

chisq.test(shot.goal.table)

