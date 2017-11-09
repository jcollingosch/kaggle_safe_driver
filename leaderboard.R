library(ggplot2)
library(dplyr)

dat <- read.csv("data/porto-seguro-safe-driver-prediction-publicleaderboard.csv")

our_score <- dat %>%
              filter(TeamName == "Cagayan") %>%
              arrange(desc(Score)) %>%
              top_n(n = 1) %>%
              select(Score)

dat %>%
  group_by(TeamId) %>%
  summarise(Score = max(Score)) %>%
  filter(Score > 0.25) %>%
  ggplot() +
   geom_histogram(aes(x = Score), binwidth = 0.001) +
   geom_vline(xintercept = our_score$Score, color = "red")
   
dat %>% 
  group_by(Score) %>%
  count() %>%
  arrange(desc(Score))
