# Module 3: Visualizing Team and Player Profiles
# Sports Analytics (Undergraduate) -- Basketball Data Science with R, Ch. 2B
# Real, bundled 2017-18 NBA season data from the BasketballAnalyzeR package.
# Run this script top to bottom in RStudio. Every chart and number in the
# Module 3 slides, notes, and lab comes directly from this script's output.

library(BasketballAnalyzeR)
data(Pbox)
data(Tbox)
data(Obox)

# ---------------------------------------------------------------
# Part 1: Player profiles, standardized (radial plot)
# ---------------------------------------------------------------
# Five real 2017-18 players, chosen for very different offensive roles.
stars <- c("Russell Westbrook", "James Harden", "LeBron James",
           "Giannis Antetokounmpo", "Stephen Curry")
P5 <- Pbox[Pbox$Player %in% stars, ]

# Five per-minute rate variables, scaled to a 36-minute game.
X <- data.frame(P5$P2M, P5$P3M, P5$OREB + P5$DREB, P5$AST, P5$TOV) / P5$MIN
names(X) <- c("P2M", "P3M", "REB", "AST", "TO")
rownames(X) <- P5$Player

per36 <- round(X * 36, 2)
print(per36)
write.csv(per36, "module3_player_profiles_per36.csv")

# Standardize: z = (x - mean(x)) / sd(x), one z-score per column.
Z <- as.data.frame(scale(X))
print(round(Z, 3))
write.csv(round(Z, 3), "module3_player_profiles_zscores.csv")

# radialprofile() standardizes internally (std = TRUE by default) and
# plots each player's z-score profile as a radar chart.
png("module3_radial_profiles.png", width = 1400, height = 950, res = 130)
radialprofile(data = X, title = rownames(X), ncol.arrange = 3)
dev.off()

# ---------------------------------------------------------------
# Part 2: Bar-line plot -- shooting splits and playing time together
# ---------------------------------------------------------------
dts <- subset(Pbox, Team == "Houston Rockets" & MIN >= 500)
print(dts[, c("Player", "MIN", "P2p", "P3p", "FTp")])

png("module3_barline_rockets.png", width = 1500, height = 850, res = 130)
barline(data = dts, id = "Player", bars = c("P2p", "P3p", "FTp"),
        line = "MIN", order.by = "MIN", labels.bars = c("2P%", "3P%", "FT%"),
        title = "Houston Rockets, 2017-18 (MIN >= 500)")
dev.off()

# ---------------------------------------------------------------
# Part 3: Variability -- how consistent is shooting, weighted by volume
# ---------------------------------------------------------------
Pbox.HR <- subset(Pbox, Team == "Houston Rockets" & MIN >= 500,
                   select = c("Player", "P2p", "P3p", "FTp", "P2A", "P3A", "FTA"))
rownames(Pbox.HR) <- Pbox.HR$Player

# Coefficient of variation: CV = SD / mean, weighted by shot volume
# (P2A, P3A, FTA) so low-volume shooters do not distort the result.
vc <- variability(data = Pbox.HR, data.var = c("P2p", "P3p", "FTp"),
                   size.var = c("P2A", "P3A", "FTA"), weight = TRUE)
print(vc)

png("module3_variability_rockets.png", width = 1300, height = 950, res = 130)
plot(vc, leg.brk = c(50, 100, 250, 500, 750), max.circle = 20)
dev.off()

# ---------------------------------------------------------------
# Part 4: Team scatter -- ball movement vs. ball security
# ---------------------------------------------------------------
TT <- data.frame(Team = Tbox$Team,
                  AST_pg = round(Tbox$AST / Tbox$GP, 1),
                  TOV_pg = round(Tbox$TOV / Tbox$GP, 1),
                  W = Tbox$W)
write.csv(TT, "module3_team_ast_tov.csv", row.names = FALSE)

print(TT[order(-TT$AST_pg), ][1:5, ])
cor(TT$AST_pg, TT$W)   # 0.2535068
cor(TT$TOV_pg, TT$W)   # -0.148543

png("module3_scatter_ast_tov.png", width = 1600, height = 950, res = 130)
scatterplot(TT, data.var = c("AST_pg", "TOV_pg"), labels = TT$Team,
            z.var = "W", zoom = c(18.5, 30.5, 11.5, 17),
            title = "Assists vs Turnovers per Game, 2017-18")
dev.off()
