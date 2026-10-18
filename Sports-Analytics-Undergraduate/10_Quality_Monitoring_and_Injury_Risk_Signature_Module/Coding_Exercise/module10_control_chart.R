# Module 10: Quality Monitoring and Injury Risk
# Real data: 2023-24 NBA shot log (shufinskiy/nba_data, shotdetail_2023.csv, downloaded from
# https://raw.githubusercontent.com/shufinskiy/nba_data/main/datasets/shotdetail_2023.tar.xz),
# real player Joel Embiid, real reported left-knee meniscus injury.
# Method: Shewhart individuals (I) control chart, the same statistical-process-control
# logic used in Muritala, Brown & Haller (2026) to monitor MLB pitcher workload for
# reinjury risk, applied here to a real basketball in-season workload signal.
#
# To reproduce: download shotdetail_2023.csv from the URL above and place it in this
# folder, then run this script with Rscript.

df <- read.csv("shotdetail_2023.csv", stringsAsFactors = FALSE)
emb <- df[df$PLAYER_NAME == "Joel Embiid", ]

by_game <- aggregate(SHOT_ATTEMPTED_FLAG ~ GAME_ID + GAME_DATE, data = emb, FUN = sum)
names(by_game)[3] <- "FGA"
by_game <- by_game[order(by_game$GAME_DATE), ]
by_game$game_num <- seq_len(nrow(by_game))
write.csv(by_game, "module10_embiid_fga_by_game.csv", row.names = FALSE)

# Pre-injury baseline: Embiid's last game before the layoff was 2024-01-30 (20240130).
# He had a reported left knee meniscus procedure in early February 2024 and returned
# April 2, 2024. Verify this timeline against a current source if reused in a later term.
preinjury <- by_game[by_game$GAME_DATE <= 20240130, ]
n <- nrow(preinjury)
cat("Pre-injury games:", n, "\n")

xbar <- mean(preinjury$FGA)
mr <- abs(diff(preinjury$FGA))
mr_bar <- mean(mr)
sigma_hat <- mr_bar / 1.128   # standard I-MR chart constant (d2 for subgroup size 2)
UCL <- xbar + 3 * sigma_hat
LCL <- max(0, xbar - 3 * sigma_hat)

cat(sprintf("Center line (mean FGA): %.2f\n", xbar))
cat(sprintf("Mean moving range: %.2f\n", mr_bar))
cat(sprintf("Estimated sigma: %.2f\n", sigma_hat))
cat(sprintf("UCL: %.2f   LCL: %.2f\n", UCL, LCL))

oc <- preinjury[preinjury$FGA > UCL | preinjury$FGA < LCL, ]
cat("Out-of-control games (pre-injury):\n")
print(oc)

summary_out <- data.frame(
  metric = c("n_preinjury_games", "mean_FGA", "mean_moving_range", "sigma_hat", "UCL", "LCL", "n_out_of_control"),
  value = c(n, xbar, mr_bar, sigma_hat, UCL, LCL, nrow(oc))
)
write.csv(summary_out, "module10_control_chart_summary.csv", row.names = FALSE)

# Plot
png("module10_embiid_control_chart.png", width = 1500, height = 850, res = 150)
par(mar = c(5, 5, 4, 2))
plot(by_game$game_num, by_game$FGA, type = "n",
     xlab = "Game number, 2023-24 season (chronological)",
     ylab = "Field goal attempts (FGA)",
     main = "Joel Embiid: Per-Game Shot Attempts as a Workload Signal, 2023-24",
     ylim = c(0, max(by_game$FGA) + 12), xlim = c(1, max(by_game$game_num)))
rect(n + 0.5, -5, max(by_game$game_num) + 1, max(by_game$FGA) + 20,
     col = rgb(0.9, 0.9, 0.9, 0.5), border = NA)
text(n + 1, max(by_game$FGA) + 10, "Meniscus surgery\n(reported Feb 4, 2024);\nout until Apr 2, 2024",
     adj = 0, cex = 0.72, col = "gray30")
lines(preinjury$game_num, preinjury$FGA, type = "o", pch = 16, col = "#27496D")
points(by_game$game_num[by_game$GAME_DATE > 20240130], by_game$FGA[by_game$GAME_DATE > 20240130],
       type = "o", pch = 17, col = "#AEBBD1")
abline(h = xbar, col = "black", lty = 1)
abline(h = UCL, col = "#E4572E", lty = 2)
abline(h = LCL, col = "#E4572E", lty = 2)
legend("topleft", legend = c("Pre-injury games", "Post-surgery games", "Center line (mean)", "UCL / LCL (mean +/- 3 sigma)"),
       col = c("#27496D", "#AEBBD1", "black", "#E4572E"), lty = c(1, 1, 1, 2), pch = c(16, 17, NA, NA), bty = "n", cex = 0.78)
dev.off()

cat("Done.\n")
