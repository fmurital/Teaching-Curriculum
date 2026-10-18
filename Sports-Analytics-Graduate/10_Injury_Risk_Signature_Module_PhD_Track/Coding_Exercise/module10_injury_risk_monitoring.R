# Grad Module 10: Injury Risk Signature Module (PhD Track)
# Real data: 2025-26 NBA shot log (shufinskiy/nba_data, shotdetail_2025.csv,
# https://raw.githubusercontent.com/shufinskiy/nba_data/main/datasets/shotdetail_2025.tar.xz)
# Real player: Victor Wembanyama, San Antonio Spurs.
# Real case: Wembanyama was shut down for a blood clot in his shoulder in February 2025
# and was not cleared to return to full activity until July 2025 (per his own public
# statement). He opened the healthy 2025-26 season on 2025-10-22, then suffered a real
# calf strain in the 2025-11-14 game against Golden State, reported out several weeks
# on 2025-11-18, and did not play again until 2025-12-13 (a 29-day real gap).
#
# Method: a simplified, classroom-scale illustration of the EWMA-CUSUM hybrid monitoring
# statistic in Tention, Muritala, Frankel & Brown (2026), Basketball Studies, applied here
# to game-by-game field goal attempts (FGA) as a real, simple workload proxy, standardized
# against Wembanyama's own real pre-injury baseline from this same season (games 1-11,
# 2025-10-22 through 2025-11-12), with lambda = 0.45 (the paper's own recommended smoothing
# weight) and a threshold of h = 1.0 standard deviations for this illustration.
#
# This is a simplification for teaching purposes: the real published method uses a
# credibility-weighted individualized baseline blended with the league grand mean (their
# eq. 1-2) and Usage Rate, Net Rating, BPM, or PIE rather than raw FGA. The real published
# Table 1/2 results (not this illustration) are the module's primary evidence; this chart
# is a simple, real, reproducible classroom demonstration of the same logic.

df <- read.csv("shotdetail_2025.csv", stringsAsFactors = FALSE)
wemb <- df[df$PLAYER_NAME == "Victor Wembanyama", ]

by_game <- aggregate(SHOT_ATTEMPTED_FLAG ~ GAME_ID + GAME_DATE, data = wemb, FUN = sum)
names(by_game)[3] <- "FGA"
by_game <- by_game[order(by_game$GAME_DATE), ]
by_game$game_num <- seq_len(nrow(by_game))
write.csv(by_game, "module10_wemby_fga_by_game.csv", row.names = FALSE)

# Real injury game: 2025-11-14 is game_num 12. Baseline = games 1-11 (pre-injury).
injury_game_num <- which(by_game$GAME_DATE == 20251114)
cat("Injury game is game_num:", injury_game_num, "on date", by_game$GAME_DATE[injury_game_num], "\n")

baseline <- by_game[by_game$game_num < injury_game_num, ]
mu0 <- mean(baseline$FGA)
sigma0 <- sd(baseline$FGA)
cat(sprintf("Baseline (games 1-%d): mean FGA = %.2f, sd = %.2f\n", injury_game_num - 1, mu0, sigma0))

by_game$W <- (by_game$FGA - mu0) / sigma0

lambda <- 0.45
r <- numeric(nrow(by_game))
r[1] <- 0  # r_0 = ybar under the standardized scale, i.e. 0
for (t in seq_len(nrow(by_game))) {
  prev <- if (t == 1) 0 else r[t - 1]
  r[t] <- lambda * by_game$W[t] + (1 - lambda) * prev
}
by_game$EWMA <- r

h <- 1.0
by_game$signal <- abs(by_game$EWMA) > h

write.csv(by_game, "module10_wemby_ewma_full.csv", row.names = FALSE)

cat("\nPre-injury EWMA trace (games 1 through injury game):\n")
print(by_game[by_game$game_num <= injury_game_num, c("game_num","GAME_DATE","FGA","W","EWMA","signal")])

first_signal <- which(by_game$signal & by_game$game_num <= injury_game_num)
if (length(first_signal) > 0) {
  cat("\nFirst pre-injury signal at game_num:", first_signal[1], "date:", by_game$GAME_DATE[first_signal[1]], "\n")
  lead_games <- injury_game_num - first_signal[1]
  cat("Lead time (games before injury game):", lead_games, "\n")
} else {
  cat("\nNo pre-injury signal crossed |EWMA| > 1.0 before the real injury game.\n")
}

summary_out <- data.frame(
  metric = c("baseline_games","mu0_FGA","sigma0_FGA","lambda","h","injury_game_num","injury_date"),
  value = c(injury_game_num - 1, mu0, sigma0, lambda, h, injury_game_num, 20251114)
)
write.csv(summary_out, "module10_wemby_summary.csv", row.names = FALSE)
cat("\nDone.\n")
