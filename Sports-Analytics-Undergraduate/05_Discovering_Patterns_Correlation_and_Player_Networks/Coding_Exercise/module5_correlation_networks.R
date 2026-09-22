# Module 5: Discovering Patterns - Correlation and Player Networks
# Real data: BasketballAnalyzeR::Pbox (2017-18 NBA season, player box scores)
#            BasketballAnalyzeR::PbP.BDB (2017-18 NBA regular season play-by-play,
#            built around the Golden State Warriors' full 82-game 2017-18 schedule;
#            every other team's rows are that team's own real regular-season game(s)
#            against Golden State specifically, not a playoff series)
# Reproduces every number and chart used in Module 5 slides, notes, and lab.

options(width = 120)
library(BasketballAnalyzeR)
library(dplyr)

out_dir <- "Sports-Analytics-Undergraduate/05_Discovering_Patterns_Correlation_and_Player_Networks/Coding_Exercise"

# ---- Part 1: Correlation analysis on real per-minute box score rates ----
data(Pbox)
cat("Total players in Pbox (2017-18 season):", nrow(Pbox), "\n")

rates <- Pbox %>%
  filter(MIN >= 500) %>%
  mutate(
    PTSpm = PTS/MIN, ASTpm = AST/MIN, TOVpm = TOV/MIN,
    OREBpm = OREB/MIN, DREBpm = DREB/MIN, STLpm = STL/MIN, BLKpm = BLK/MIN
  ) %>%
  select(Player, PTSpm, ASTpm, TOVpm, OREBpm, DREBpm, STLpm, BLKpm)

cat("Players with >=500 minutes played:", nrow(rates), "\n")

cc <- corranalysis(rates %>% select(-Player), threshold = 0.5)
print(round(cc$cor.mtx, 3))
write.csv(round(cc$cor.mtx, 3), file.path(out_dir, "module5_correlation_matrix.csv"))

p_corr <- plot(cc)
ggplot2::ggsave(file.path(out_dir, "module5_correlation_plot.png"), p_corr, width = 9, height = 8, dpi = 150)

# ---- Part 2: Player assist networks, real 2018 playoff data ----
data(PbP.BDB)
PbP <- PbPmanipulation(PbP.BDB)

# Houston Rockets, real 2017-18 regular season games against Golden State (3 games)
anet_hou <- assistnet(subset(PbP, team == "HOU"))
ns_hou <- anet_hou$nodeStats[order(-anet_hou$nodeStats$AST), c("player","AST","ASTPTS","FGM_AST","FGM","FGM_ASTp")]
print(ns_hou)
write.csv(ns_hou, file.path(out_dir, "module5_hou_assist_nodestats.csv"), row.names = FALSE)

p_hou_net <- plot(anet_hou)
ggplot2::ggsave(file.path(out_dir, "module5_hou_assist_network.png"), p_hou_net, width = 10, height = 8, dpi = 150)

# Cleveland Cavaliers, real 2017-18 regular season games against Golden State (2 games, including the Christmas Day nationally televised game), contrast case
anet_cle <- assistnet(subset(PbP, team == "CLE"))
ns_cle <- anet_cle$nodeStats[order(-anet_cle$nodeStats$AST), c("player","AST","ASTPTS","FGM_AST","FGM","FGM_ASTp")]
print(ns_cle)
write.csv(ns_cle, file.path(out_dir, "module5_cle_assist_nodestats.csv"), row.names = FALSE)

p_cle_net <- plot(anet_cle)
ggplot2::ggsave(file.path(out_dir, "module5_cle_assist_network.png"), p_cle_net, width = 10, height = 8, dpi = 150)

# ---- Summary numbers for notes/slides ----
cat("\nHOU total real assists (sum AST, nodeStats):", sum(ns_hou$AST, na.rm=TRUE), "\n")
cat("CLE total real assists (sum AST, nodeStats):", sum(ns_cle$AST, na.rm=TRUE), "\n")
cat("HOU top real assister:", ns_hou$player[1], "with", ns_hou$AST[1], "real assists,", ns_hou$ASTPTS[1], "points created\n")
cat("CLE top real assister:", ns_cle$player[1], "with", ns_cle$AST[1], "real assists,", ns_cle$ASTPTS[1], "points created\n")

cat("\nDONE MODULE 5 COMPUTATION\n")
