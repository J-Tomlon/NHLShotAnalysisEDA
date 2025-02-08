library(dplyr)
library(ggplot2)
library(RColorBrewer)

setwd("C:/Users/hocke/Dropbox/STA_486C/NOT_Project/NHLShotAnalysis")
shots <- read.csv("data-raw/shots_2021.csv")

shots.clean <- shots %>%
  select(goal, teamCode, shotType, isPlayoffGame, period, team, 
         shotDistance, shotRush, shotRebound, shootingTeamForwardsOnIce, 
         shootingTeamDefencemenOnIce, offWing, arenaAdjustedShotDistance, 
         xCordAdjusted, yCordAdjusted) %>%
  mutate(teamCode = as.factor(shots$teamCode)) %>%
  mutate(shotType = as.factor(shots$shotType)) %>%
  mutate(isPlayoffGame = as.factor(shots$isPlayoffGame)) %>%
  mutate(period = as.factor(shots$period)) %>%
  mutate(team = as.factor(shots$team)) %>% 
  mutate(shotRush = as.factor(shots$shotRush)) %>%
  mutate(shotRebound = as.factor(shots$shotRebound)) %>%
  mutate(shootingTeamForwardsOnIce = as.factor(shots$shootingTeamForwardsOnIce)) %>%
  mutate(shootingTeamDefencemenOnIce = as.factor(shots$shootingTeamDefencemenOnIce)) %>%
  mutate(offWing = as.factor(shots$offWing)) %>%
  filter(shotType != "")

##############################################################################
shots.prob <- shots.clean %>%
  mutate(distance_bin = cut(shotDistance, breaks = seq(0, max(shotDistance, na.rm=TRUE), by = 5), 
                            include.lowest = TRUE, labels = FALSE) * 5)
goal_prob <- shots.prob %>%
  group_by(distance_bin, shotType) %>%
  summarise(goal_rate = mean(goal), shots = n(), .groups = "drop")

ggplot(goal_prob, aes(x = distance_bin, y = goal_rate, color = shotType, group = shotType)) +
  geom_line(size = 1) +
  geom_point() +
  labs(x = "Distance (ft)", y = "Goal Probability", 
       title = "Relative Probability of a Shot Becoming a Goal by Distance and Shot Type", 
       subtitle = "2021 Season",
       color = "Shot Type") +
  theme_minimal()



