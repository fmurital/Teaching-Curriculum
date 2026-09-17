# Module 1: Introduction to Basketball Analytics
# Sports Analytics (Undergraduate)
#
# This script sets up the R environment used all semester and takes a first
# look at the real NBA data bundled with the BasketballAnalyzeR package,
# the companion package to the course textbook (Zuccolotto & Manisera, 2020).

# install.packages("BasketballAnalyzeR")  # run once, then comment out
library(BasketballAnalyzeR)
library(ggplot2)

# The package ships real 2017-18 NBA season data. Load the player box score
# table (Pbox) and the team box score table (Tbox) used across this course.
data(Pbox)
data(Tbox)

dim(Pbox)   # 605 players, 22 variables
dim(Tbox)   # 30 teams, 23 variables
names(Tbox)

# A first, purely descriptive question: which teams scored the most points
# per game across the 2017-18 season?
Tbox$PPG <- round(Tbox$PTS / Tbox$GP, 1)
top5 <- Tbox[order(-Tbox$PPG), c("Team", "GP", "W", "L", "PPG")][1:5, ]
print(top5)

# A simple chart: every team's win total for the season, sorted.
Tbox$Team <- factor(Tbox$Team, levels = Tbox$Team[order(Tbox$W)])
p <- ggplot(Tbox, aes(x = Team, y = W)) +
  geom_col(fill = "#1D428A") +
  coord_flip() +
  labs(
    title = "2017-18 NBA Regular Season Wins",
    x = NULL, y = "Wins (of 82 games)",
    caption = "Data: Tbox, BasketballAnalyzeR (Zuccolotto & Manisera, 2020)"
  ) +
  theme_minimal(base_size = 11)
p

ggsave("module1_wins_chart.png", p, width = 7, height = 6, dpi = 200)
