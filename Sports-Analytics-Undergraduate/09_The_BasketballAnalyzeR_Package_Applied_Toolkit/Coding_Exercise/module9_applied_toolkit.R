# Module 9: The BasketballAnalyzeR Package Applied Toolkit
# Real data: BasketballAnalyzeR::Pbox, Tbox, Obox, PbP.BDB
#            (2017-18 NBA regular season, same real season used throughout
#            this course)
# Reproduces every number, table, and chart used in Module 9 slides,
# notes, and lab. Run this with BasketballAnalyzeR 0.8.1 installed.

options(width = 120)
set.seed(9)
library(BasketballAnalyzeR)
library(dplyr)

out_dir <- "Sports-Analytics-Undergraduate/09_The_BasketballAnalyzeR_Package_Applied_Toolkit/Coding_Exercise"
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)

data(Pbox)
data(Tbox)
data(Obox)
data(PbP.BDB)

cat("Total real players in Pbox (2017-18):", nrow(Pbox), "\n")
cat("Total real teams in Tbox (2017-18):", nrow(Tbox), "\n")

# =============================================================
# PART 1: Rebuilding a real box score directly from real play-by-play
#          (TOPboxes) -- the Houston Rockets, this course's running
#          case study team since Module 2
# =============================================================
PbP <- PbPmanipulation(PbP.BDB)
PbP <- PbP %>%
  mutate(oreb = type %in% "rebound offensive",
         dreb = type %in% "rebound defensive",
         turnover = event_type == "turnover",
         PF = (event_type == "foul") & !(type %in% "technical")) %>%
  mutate(across(c(player, assist, steal, block, h1:h5, a1:a5), as.character)) %>%
  as.data.frame()

out_hou <- TOPboxes(PbP, team = "HOU")
cat("\nReal Houston Rockets Tbox, rebuilt from real play-by-play:\n")
print(out_hou$Tbox)
cat("\nReal Houston Rockets Pbox, rebuilt from real play-by-play (first 10 rows):\n")
print(head(out_hou$Pbox[order(-out_hou$Pbox$PTS), ], 10))

write.csv(out_hou$Tbox, file.path(out_dir, "module9_hou_tbox_from_pbp.csv"), row.names = FALSE)
write.csv(out_hou$Pbox, file.path(out_dir, "module9_hou_pbox_from_pbp.csv"), row.names = FALSE)

# Real cross-check against the course's own built-in Tbox row for the Rockets
# (the number used back in Module 2 for the Rockets' 65 real wins, used again here
# to show students that two independently-sourced real box scores should agree)
hou_builtin <- subset(Tbox, Team == "Houston Rockets")
cat("\nReal built-in Tbox row for the Rockets (Module 2's source):\n")
print(hou_builtin[, c("Team", "GP", "PTS", "W")])
cat("\nReal rebuilt-from-play-by-play row (this module's new source):\n")
print(out_hou$Tbox[, c("GP", "PTS")])

# =============================================================
# PART 2: How evenly is real scoring distributed across a roster?
#          (inequality / Gini) -- Rockets vs. Warriors, two real
#          different team-building philosophies in the same real season
# =============================================================
Pbox.HOU <- subset(Pbox, Team == "Houston Rockets")
Pbox.GSW <- subset(Pbox, Team == "Golden State Warriors")

ineq_hou <- inequality(Pbox.HOU$PTS, nplayers = 8)
ineq_gsw <- inequality(Pbox.GSW$PTS, nplayers = 8)

cat("\nReal Gini index, real points scored, top 8 Rockets:", ineq_hou$Gini, "\n")
cat("Real Gini index, real points scored, top 8 Warriors:", ineq_gsw$Gini, "\n")

png(file.path(out_dir, "module9_hou_scoring_lorenz.png"), width = 1500, height = 1200, res = 150)
print(plot(ineq_hou))
dev.off()
png(file.path(out_dir, "module9_gsw_scoring_lorenz.png"), width = 1500, height = 1200, res = 150)
print(plot(ineq_gsw))
dev.off()

gini_table <- data.frame(Team = c("Houston Rockets", "Golden State Warriors"),
                          Gini_Top8_Scoring = c(ineq_hou$Gini, ineq_gsw$Gini))
write.csv(gini_table, file.path(out_dir, "module9_gini_scoring_table.csv"), row.names = FALSE)
print(gini_table)

# =============================================================
# PART 3: Whole-league bubble chart, four real statistics at once
#          (bubbleplot)
# =============================================================
X <- with(Tbox, data.frame(T = Team, P2p = P2p, P3p = P3p, FTp = FTp, AS = P2A + P3A + FTA))
labs <- c("2-point shots (% made)", "3-point shots (% made)", "free throws (% made)", "Total shots attempted")

png(file.path(out_dir, "module9_league_bubbleplot.png"), width = 1800, height = 1300, res = 150)
print(bubbleplot(X, id = "T", x = "P2p", y = "P3p", col = "FTp", size = "AS", labels = labs))
dev.off()
write.csv(X, file.path(out_dir, "module9_league_bubbleplot_data.csv"), row.names = FALSE)

cat("\nReal Rockets 2-point / 3-point / FT shooting (from the whole-league chart):\n")
print(subset(X, T == "Houston Rockets"))

# =============================================================
# PART 4: Expected points by real shot distance, two real Rockets
#          shot-creators (expectedpts) -- ties shot location (Module 4)
#          back into one real, actionable per-player number
# =============================================================
PbP.HOU <- subset(PbP, team == "HOU" & !is.na(shot_distance))
plrys <- c("James Harden", "Chris Paul")

png(file.path(out_dir, "module9_hou_expectedpts_by_distance.png"), width = 1800, height = 1300, res = 150)
print(expectedpts(data = PbP.HOU, bw = 10, players = plrys, col.team = "dodgerblue",
                   palette = colorRampPalette(c("gray", "black")), col.hline = "red",
                   title = "Expected Points by Shot Distance, Houston Rockets 2017-18"))
dev.off()

cat("\nReal number of real Rockets shot attempts with a recorded distance:", nrow(PbP.HOU), "\n")
cat("Real Harden attempts:", sum(PbP.HOU$player == "James Harden", na.rm = TRUE),
    "  Real Paul attempts:", sum(PbP.HOU$player == "Chris Paul", na.rm = TRUE), "\n")

cat("\nDone. All real outputs written to:", out_dir, "\n")
