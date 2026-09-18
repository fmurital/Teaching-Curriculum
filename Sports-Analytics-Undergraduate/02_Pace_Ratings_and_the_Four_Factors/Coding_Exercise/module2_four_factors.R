# Module 2: Pace, Ratings, and the Four Factors
# Sports Analytics (Undergraduate)
#
# This script computes team pace, offensive/defensive ratings, and Dean
# Oliver's Four Factors for every team in the 2017-18 NBA season, using the
# real data bundled with the BasketballAnalyzeR package (the companion
# package to the course textbook, Zuccolotto & Manisera, 2020).

library(BasketballAnalyzeR)

data(Tbox)
data(Obox)

# fourfactors() takes a team's own box score (Tbox) and its opponents' box
# score (Obox) and returns, for every team: pace, offensive/defensive
# rating, and the four offensive and four defensive factors.
FF <- fourfactors(Tbox, Obox)
FF$Team <- Tbox$Team
FF$W <- Tbox$W
FF$L <- Tbox$L

# --- Pace: how many possessions a team plays per 48 minutes ---
FF$Pace48 <- round(FF$PACE.Off * 48, 1)
pace_top5 <- FF[order(-FF$Pace48), c("Team", "Pace48", "W")][1:5, ]
print(pace_top5)
round(mean(FF$Pace48), 1)          # league-average pace
round(range(FF$Pace48), 1)         # slowest team to fastest team

# --- Offensive and defensive rating: points scored/allowed per 100 possessions ---
ortg_top5 <- FF[order(-FF$ORtg), c("Team", "ORtg", "DRtg", "W")][1:5, ]
print(ortg_top5)
drtg_top5 <- FF[order(FF$DRtg), c("Team", "DRtg", "W")][1:5, ]
print(drtg_top5)

# Net rating (ORtg - DRtg) versus wins is a far stronger predictor than
# either rating alone -- this is the core idea of the module.
FF$NetRtg <- FF$ORtg - FF$DRtg
round(cor(FF$F1.Off, FF$W), 3)     # eFG% alone
round(cor(FF$NetRtg, FF$W), 3)     # net rating

# --- The Four Factors, offense and defense ---
# F1 = effective field goal %, F2 = turnover rate, F3 = rebound rate,
# F4 = free throw rate (Oliver, Basketball on Paper, 2004).
cors_off <- c(
  eFG      = cor(FF$F1.Off, FF$W),
  TOVrate  = cor(FF$F2.Off, FF$W),
  ORBrate  = cor(FF$F3.Off, FF$W),
  FTrate   = cor(FF$F4.Off, FF$W)
)
round(cors_off, 3)

cors_def <- c(
  eFG_allowed     = cor(FF$F1.Def, FF$W),
  TOVrate_forced  = cor(FF$F2.Def, FF$W),
  DRBrate_opp     = cor(FF$F3.Def, FF$W),
  FTrate_allowed  = cor(FF$F4.Def, FF$W)
)
round(cors_def, 3)

# One team, all the way through: the 2017-18 Houston Rockets, who led the
# league in wins (see Module 1).
FF[FF$Team == "Houston Rockets",
   c("Team", "Pace48", "ORtg", "DRtg", "F1.Off", "F2.Off", "F3.Off", "F4.Off", "W")]

# --- The package's own Four Factors chart, for every team at once ---
plot(FF, title = "2017-18 NBA Season -- Four Factors")

# Save the chart and the full table for reference.
png("module2_four_factors_plot.png", width = 1400, height = 1000, res = 120)
plot(FF, title = "2017-18 NBA Season -- Four Factors")
dev.off()

write.csv(
  FF[, c("Team", "W", "L", "Pace48", "ORtg", "DRtg",
         "F1.Off", "F2.Off", "F3.Off", "F4.Off",
         "F1.Def", "F2.Def", "F3.Def", "F4.Def")],
  "module2_four_factors_table.csv", row.names = FALSE
)
