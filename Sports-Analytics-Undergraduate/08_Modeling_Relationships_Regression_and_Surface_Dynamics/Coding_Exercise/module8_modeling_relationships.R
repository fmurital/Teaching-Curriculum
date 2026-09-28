# Module 8 (Undergraduate): Modeling Relationships - Regression and Surface Area Dynamics
# Real data: BasketballAnalyzeR::Pbox, Tbox, Obox (2017-18 NBA regular season,
#            the same real season used throughout this course).
# Uses the package's own documented functions and worked examples:
# simplereg() for linear/nonparametric regression, variability() for
# mean-variability "surface" bubble diagrams, and corranalysis() for a
# correlation network among per-minute box score rates.
# Run in RStudio (Windows) with BasketballAnalyzeR 0.8.1 installed.

options(width = 120)
set.seed(8)
library(BasketballAnalyzeR)
library(dplyr)

out_dir <- "Sports-Analytics-Undergraduate/08_Modeling_Relationships_Regression_and_Surface_Dynamics/Coding_Exercise"
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)

log_file <- file.path(out_dir, "module8_console_log.txt")
sink(log_file, split = TRUE)

data(Pbox)
data(Tbox)
data(Obox)

cat("Total real players in Pbox (2017-18):", nrow(Pbox), "\n")
cat("Total real teams in Tbox (2017-18):", nrow(Tbox), "\n\n")

# =============================================================
# PART 1: Team-level regression - does Net Rating predict real Wins?
# =============================================================
FF <- fourfactors(Tbox, Obox)
NetRtg <- FF$ORtg - FF$DRtg
W <- Tbox$W
Team <- Tbox$Team

mod_lin <- simplereg(x = NetRtg, y = W, type = "lin")
cat("Real linear regression: Wins ~ Net Rating (30 real NBA teams, 2017-18)\n")
cat("R-squared (linear):", round(mod_lin$R2, 4), "\n")
print(summary(mod_lin$Model))

mod_pol <- simplereg(x = NetRtg, y = W, type = "pol")
cat("\nR-squared (local polynomial, degree 2):", round(mod_pol$R2, 4), "\n")

reg_team_tab <- data.frame(Team = Team, NetRtg = round(NetRtg, 2), W = W)
reg_team_tab <- reg_team_tab[order(-reg_team_tab$NetRtg), ]
print(reg_team_tab)
write.csv(reg_team_tab, file.path(out_dir, "module8_team_netrtg_wins.csv"), row.names = FALSE)

reg_summary <- data.frame(
  model = c("linear", "local_polynomial_deg2"),
  R2 = c(round(mod_lin$R2, 4), round(mod_pol$R2, 4))
)
write.csv(reg_summary, file.path(out_dir, "module8_team_regression_r2.csv"), row.names = FALSE)

coef_lin <- coef(mod_lin$Model)
cat("\nReal fitted line: Wins =", round(coef_lin[1], 3), "+", round(coef_lin[2], 4), "* NetRtg\n")
lin_coef_tab <- data.frame(term = names(coef_lin), estimate = round(unname(coef_lin), 5))
write.csv(lin_coef_tab, file.path(out_dir, "module8_team_regression_coefficients.csv"), row.names = FALSE)

png(file.path(out_dir, "module8_team_netrtg_wins_regression.png"), width = 1700, height = 1300, res = 150)
print(plot(mod_lin, xlab = "Net Rating (ORtg - DRtg)", ylab = "Real Wins (2017-18)"))
dev.off()

# =============================================================
# PART 2: Player-level regression - the package's own documented example
# (Assists-per-minute predicting Turnovers-per-minute, real 2017-18 rotation
# players, MIN >= 500, exactly the assumptions used in BasketballAnalyzeR's
# own simplereg() help-file example).
# =============================================================
Pbox.sel <- subset(Pbox, MIN >= 500)
cat("\nReal rotation players with MIN >= 500:", nrow(Pbox.sel), "of", nrow(Pbox), "\n")

X_ast <- Pbox.sel$AST / Pbox.sel$MIN
Y_tov <- Pbox.sel$TOV / Pbox.sel$MIN
Pl <- Pbox.sel$Player

mod_ast_tov <- simplereg(x = X_ast, y = Y_tov, type = "lin")
cat("Real linear regression: TOV-per-minute ~ AST-per-minute (n =", nrow(Pbox.sel), "real players)\n")
cat("R-squared:", round(mod_ast_tov$R2, 4), "\n")
print(summary(mod_ast_tov$Model))

png(file.path(out_dir, "module8_player_ast_tov_regression.png"), width = 1700, height = 1300, res = 150)
print(plot(mod_ast_tov, xlab = "Assists per minute", ylab = "Turnovers per minute"))
dev.off()

ast_tov_tab <- data.frame(Player = Pl, AST_per_min = round(X_ast, 4), TOV_per_min = round(Y_tov, 4))
ast_tov_tab <- ast_tov_tab[order(-ast_tov_tab$AST_per_min), ]
write.csv(ast_tov_tab, file.path(out_dir, "module8_player_ast_tov_rates.csv"), row.names = FALSE)

ast_tov_coef <- coef(mod_ast_tov$Model)
cat("\nReal fitted line: TOV/min =", round(ast_tov_coef[1], 5), "+", round(ast_tov_coef[2], 4), "* AST/min\n")
write.csv(data.frame(term = names(ast_tov_coef), estimate = round(unname(ast_tov_coef), 6)),
          file.path(out_dir, "module8_player_ast_tov_coefficients.csv"), row.names = FALSE)

# Real, recognizable high-usage point guards for a spot-check callout
pg_spotcheck <- c("James Harden","Russell Westbrook","Chris Paul","Damian Lillard",
                   "Stephen Curry","John Wall","Kyrie Irving","Ben Simmons")
pg_tab <- ast_tov_tab[ast_tov_tab$Player %in% pg_spotcheck, ]
print(pg_tab)
write.csv(pg_tab, file.path(out_dir, "module8_player_ast_tov_pg_spotcheck.csv"), row.names = FALSE)

# =============================================================
# PART 3: Surface area dynamics - real mean-variability bubble diagram
# (the package's own documented variability() example: real shooting splits
# for a real team's real rotation players, weighted by real shot volume)
# =============================================================
Pbox.BC <- subset(Pbox, Team == "Houston Rockets" & MIN >= 500,
                   select = c("Player","P2p","P3p","FTp","P2A","P3A","FTA"))
cat("\nReal 2017-18 Houston Rockets rotation players (MIN >= 500):", nrow(Pbox.BC), "\n")
print(Pbox.BC)
write.csv(Pbox.BC, file.path(out_dir, "module8_rockets_shooting_splits.csv"), row.names = FALSE)

list_variability <- variability(data = Pbox.BC, data.var = c("P2p","P3p","FTp"),
                                 size.var = c("P2A","P3A","FTA"), weight = TRUE)
print(list_variability)

var_sd_tab <- data.frame(variable = names(list_variability$SD), SD_weighted = round(unname(list_variability$SD), 4))
write.csv(var_sd_tab, file.path(out_dir, "module8_variability_weighted_sd.csv"), row.names = FALSE)

png(file.path(out_dir, "module8_rockets_variability_surface.png"), width = 1800, height = 1400, res = 150)
print(plot(list_variability, leg.brk = c(10, 25, 50, 100, 500, 1000), max.circle = 30))
dev.off()

# League-wide version of the same real "surface" diagram for contrast
Pbox.League <- subset(Pbox, MIN >= 500, select = c("Player","P2p","P3p","FTp","P2A","P3A","FTA"))
list_variability_league <- variability(data = Pbox.League, data.var = c("P2p","P3p","FTp"),
                                        size.var = c("P2A","P3A","FTA"), weight = TRUE)
print(list_variability_league)
var_sd_league_tab <- data.frame(variable = names(list_variability_league$SD),
                                 SD_weighted = round(unname(list_variability_league$SD), 4))
write.csv(var_sd_league_tab, file.path(out_dir, "module8_variability_league_weighted_sd.csv"), row.names = FALSE)

png(file.path(out_dir, "module8_league_variability_surface.png"), width = 1800, height = 1400, res = 150)
print(plot(list_variability_league, leg.brk = c(10, 50, 100, 300, 600, 1000), max.circle = 26))
dev.off()

# =============================================================
# PART 4: Correlation network among real per-minute box score rates
# (exactly the package's own documented corranalysis() example)
# =============================================================
data_permin <- data.frame(Pbox$PTS, Pbox$P3M, Pbox$P2M,
                           Pbox$OREB + Pbox$DREB, Pbox$AST,
                           Pbox$TOV, Pbox$STL, Pbox$BLK) / Pbox$MIN
names(data_permin) <- c("PTS","P3M","P2M","REB","AST","TOV","STL","BLK")
data_permin <- subset(data_permin, Pbox$MIN >= 500)
cat("\nReal per-minute rate correlation analysis, n =", nrow(data_permin), "real rotation players\n")

out_corr <- corranalysis(data_permin, threshold = 0.5)
print(out_corr$cor.mat)
write.csv(round(out_corr$cor.mat, 3), file.path(out_dir, "module8_permin_correlation_matrix.csv"))

png(file.path(out_dir, "module8_permin_correlation_network.png"), width = 1800, height = 1500, res = 150)
print(plot(out_corr, layout = "circle"))
dev.off()

cat("\nDONE MODULE 8 (UNDERGRADUATE) COMPUTATION\n")
sink()
cat("Log written to", log_file, "\n")
