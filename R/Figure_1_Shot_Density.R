library(dplyr)
library(ggplot2)
library(sportyR)

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

rink <- geom_hockey("nhl")

rink.right.o.zone <- geom_hockey("nhl", "offensive_zone", )

rink.right.o.zone +
  geom_density_2d_filled(data = shots.clean,
                         aes(x = xCordAdjusted, y = yCordAdjusted), 
                         alpha = 0.3, 
                         bins = 9, 
                         show.legend = FALSE) +
  labs(title= "2021 NHL Season Shot Density") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_fill_manual(values = c("#FFFFFF00",
                               "#D53E4F",
                               "#F46D43",
                               "#FDAE61",
                               "#FEE08B",
                               "#ABDDA4",
                               "#66C2A5",
                               "#3288BD",
                               "#5E4FA2"))




