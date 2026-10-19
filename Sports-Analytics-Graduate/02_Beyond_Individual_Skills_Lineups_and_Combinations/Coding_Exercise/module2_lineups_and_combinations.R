# Module 2: Beyond Individual Skills -- Lineups and Combinations (graduate)
# Real data: BasketballAnalyzeR::Pbox, BasketballAnalyzeR::PbP.BDB (2017-18 NBA regular
#            season, built around the Golden State Warriors' full 82-game schedule; see
#            Module 1's header for the hub-and-spoke structure).
#
# NOTE ON DATA SOURCE: Module 2's Student Notes and Lab describe the textbook's own
# worked example (Zuccolotto, Manisera & Sandri 2026, Ch.2, Table 2.1), which uses the
# book's external 2021-22 Golden State Warriors dataset (PbP.BDB.GSW.rs) and a custom
# lineups() helper from the book's own additional_functions.r script. Neither of those
# is part of the installed BasketballAnalyzeR package (lineups() is not in its NAMESPACE)
# or fetchable from the package's own GitHub mirror, so this exercise does not try to
# reproduce that external table. Instead it runs the same real methodology -- which
# five-player combinations actually shared the floor, and how do their real box scores,
# assist networks, and Four Factors compare -- on BasketballAnalyzeR's own bundled,
# independently verifiable 2017-18 PbP.BDB data, using only the package's real exported
# functions (PbPmanipulation, assistnet, TOPboxes, fourfactors) plus one small lineup-
# minutes helper below, built directly from PbP.BDB's own on-court columns (h1:h5 for the
# home team, a1:a5 for the away team) the same way the package's own internal
# player_assist() helper (inside assistnet.R) computes playing time for a pair of
# players, just generalized from 2 players to 5.

options(width = 120)
library(dplyr)
library(BasketballAnalyzeR)
library(network)
library(sna)
library(GGally)
library(ggnetwork)

out_dir <- "Sports-Analytics-Graduate/02_Beyond_Individual_Skills_Lineups_and_Combinations/Coding_Exercise"

data(Pbox)
data(PbP.BDB)
PbP <- PbPmanipulation(PbP.BDB)
PbP <- PbP %>%
  mutate(across(c(player, assist, h1:h5, a1:a5, hometeam, team), as.character))

# ---- Part 1: Find real 2017-18 Golden State lineups worth analyzing ----
# A 10-player pool, by real total minutes played (BasketballAnalyzeR::Pbox, 2017-18 season)
gsw_pool <- Pbox %>%
  filter(Team == "Golden State Warriors") %>%
  arrange(desc(MIN)) %>%
  slice(1:10) %>%
  pull(Player)

cat("10-player real 2017-18 GSW pool (by minutes played):\n")
print(gsw_pool)
cat("No. of 5-player combinations =", choose(length(gsw_pool), 5), "\n")

# lineup_minutes(): for each play-by-play row, the real 5-man unit on the floor for GSW is
# h1:h5 when GSW is the home team that game, a1:a5 when GSW is away; sum real playlength
# (seconds) per unique 5-player combination, restricted to the 10-player pool above.
lineup_minutes <- function(data, pool) {
  data <- data %>% filter(game_id %in% unique(data$game_id[data$team == "GSW"]))
  oncourt <- apply(data, 1, function(r) {
    cols <- if (r["hometeam"] == "GSW") c("h1","h2","h3","h4","h5") else c("a1","a2","a3","a4","a5")
    paste(sort(r[cols]), collapse = " | ")
  })
  keep <- sapply(strsplit(oncourt, " \\| "), function(x) all(x %in% pool) && !any(x == ""))
  agg <- aggregate(data$playlength[keep], by = list(lineup = oncourt[keep]), FUN = sum)
  agg$MIN <- round(agg$x / 60, 1)
  agg[order(-agg$MIN), c("lineup","MIN")]
}

min_time_l <- 30
all_lineups <- lineup_minutes(PbP, gsw_pool)
lineup_set <- all_lineups[all_lineups$MIN >= min_time_l, ]
cat("\nReal 2017-18 GSW lineups from this pool with >=", min_time_l, "minutes together:\n")
print(lineup_set)
write.csv(lineup_set, file.path(out_dir, "module2_gsw_lineup_minutes.csv"), row.names = FALSE)

# ---- Part 2: Assist network for the real starting lineup ----
starting5 <- c("Draymond Green","Kevin Durant","Klay Thompson","Stephen Curry","Zaza Pachulia")
PbP.starting5 <- PbP %>%
  filter(team == "GSW") %>%
  rowwise() %>%
  filter({
    cols <- if (hometeam == "GSW") c(h1,h2,h3,h4,h5) else c(a1,a2,a3,a4,a5)
    setequal(cols, starting5)
  }) %>%
  ungroup() %>%
  as.data.frame()

out <- assistnet(PbP.starting5)
nodeStats <- out$nodeStats[order(-out$nodeStats$AST), ]
print(nodeStats)
write.csv(nodeStats, file.path(out_dir, "module2_starting5_assist_nodestats.csv"), row.names = FALSE)

p_net <- plot(out)
ggplot2::ggsave(file.path(out_dir, "module2_starting5_assist_network.png"), p_net, width = 10, height = 8, dpi = 150)

# ---- Part 3: Lineup-level Pace, Ratings, and Four Factors ----
`%~%` <- function(x, pattern) grepl(pattern, x, fixed = TRUE)
TOPPbP <- PbP %>%
  mutate(
    oreb = type %~% "rebound offensive",
    dreb = type %~% "rebound defensive",
    turnover = event_type == "turnover",
    PF = (event_type == "foul") & !(type %~% "technical")
  )

bench5 <- c("Andre Iguodala","David West","Draymond Green","Klay Thompson","Shaun Livingston")
lineup_box <- function(pbp, lineup) {
  pbp %>%
    rowwise() %>%
    filter({
      cols <- if (hometeam == "GSW") c(h1,h2,h3,h4,h5) else c(a1,a2,a3,a4,a5)
      setequal(cols, lineup)
    }) %>%
    ungroup() %>%
    as.data.frame()
}

TOPPbP.starting5 <- lineup_box(TOPPbP, starting5)
TOPPbP.bench5 <- lineup_box(TOPPbP, bench5)

TOP.starting5 <- TOPboxes(TOPPbP.starting5, team = "GSW")
TOP.bench5 <- TOPboxes(TOPPbP.bench5, team = "GSW")

Tboxes <- data.frame(Team = c("Starting 5", "Bench unit"), rbind(TOP.starting5$Tbox, TOP.bench5$Tbox))
Oboxes <- data.frame(Team = c("Starting 5", "Bench unit"), rbind(TOP.starting5$Obox, TOP.bench5$Obox))

FF <- fourfactors(Tboxes, Oboxes)
print(FF)
write.csv(FF, file.path(out_dir, "module2_lineup_fourfactors.csv"), row.names = FALSE)

cat("\nStarting 5 real minutes together:", TOP.starting5$Tbox$MIN,
    " | Pace:", round(FF$PACE.Off[1], 3), " | ORtg:", FF$ORtg[1], " | DRtg:", FF$DRtg[1], "\n")
cat("Bench unit real minutes together:", TOP.bench5$Tbox$MIN,
    " | Pace:", round(FF$PACE.Off[2], 3), " | ORtg:", FF$ORtg[2], " | DRtg:", FF$DRtg[2], "\n")

cat("\nDONE MODULE 2 COMPUTATION\n")
