# Module 1: Getting Started with Advanced Basketball Analytics (graduate)
# Real data: BasketballAnalyzeR::Pbox (2017-18 NBA season, player box scores)
#            BasketballAnalyzeR::PbP.BDB (2017-18 NBA regular season play-by-play,
#            built around the Golden State Warriors' full 82-game 2017-18 schedule;
#            every other team's rows are that team's own real regular-season game(s)
#            against Golden State specifically, not a playoff series)
# Reproduces every number used in Module 1 slides, notes, and lab: the real top-scorers
# pipeline (Worked Example 1) and the real Golden State Warriors assist network
# (Worked Example 2).

options(width = 120)
library(dplyr)
library(BasketballAnalyzeR)
library(network)
library(sna)
library(GGally)
library(ggnetwork)

out_dir <- "Sports-Analytics-Graduate/01_Getting_Started_with_Advanced_Basketball_Analytics/Coding_Exercise"

# ---- Part 1: A real dplyr pipeline on Pbox (Worked Example 1) ----
data(Pbox)
cat("Total players in Pbox (2017-18 season):", nrow(Pbox), "\n")

top_scorers <- Pbox %>%
  filter(MIN >= 500) %>%
  mutate(PPG = round(PTS / GP, 1)) %>%
  select(Player, Team, GP, MIN, PTS, PPG) %>%
  arrange(desc(PPG)) %>%
  slice(1:8)

print(top_scorers)
write.csv(top_scorers, file.path(out_dir, "module1_top_scorers.csv"), row.names = FALSE)

# ---- Part 2: A real assist network for the Golden State Warriors (Worked Example 2) ----
data(PbP.BDB)
PbP <- PbPmanipulation(PbP.BDB)
PbP.GSW <- subset(PbP, team == "GSW")

out <- assistnet(PbP.GSW)
nodeStats <- out$nodeStats[order(-out$nodeStats$AST), ]
print(head(nodeStats, 10))
write.csv(nodeStats, file.path(out_dir, "module1_gsw_assist_nodestats.csv"), row.names = FALSE)

p_net <- plot(out)
ggplot2::ggsave(file.path(out_dir, "module1_gsw_assist_network.png"), p_net, width = 10, height = 8, dpi = 150)

cat("\nDraymond Green real assists:", nodeStats$AST[nodeStats$player == "Draymond Green"],
    " | Kevin Durant:", nodeStats$AST[nodeStats$player == "Kevin Durant"],
    " | Stephen Curry:", nodeStats$AST[nodeStats$player == "Stephen Curry"], "\n")
cat("Klay Thompson FGM_ASTp:", round(nodeStats$FGM_ASTp[nodeStats$player == "Klay Thompson"], 1),
    "% | Kevin Durant FGM_ASTp:", round(nodeStats$FGM_ASTp[nodeStats$player == "Kevin Durant"], 1), "%\n")

cat("\nDONE MODULE 1 COMPUTATION\n")
