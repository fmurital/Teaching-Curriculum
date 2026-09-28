# Module 7: Finding Groups (Clustering Players and Teams)
# Real data: BasketballAnalyzeR::Pbox and BasketballAnalyzeR::Tbox/Obox
#            (2017-18 NBA regular season, same real season used in
#            Modules 1, 2, 5, and 6 of this course)
# Reproduces every number, table, and chart used in Module 7 slides,
# notes, and lab. Run this with BasketballAnalyzeR 0.8.1 installed.

options(width = 120)
set.seed(7)
library(BasketballAnalyzeR)
library(dplyr)

out_dir <- "Sports-Analytics-Undergraduate/07_Finding_Groups_Clustering_Players_and_Teams/Coding_Exercise"
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)

data(Pbox)
data(Tbox)
data(Obox)

cat("Total real players in Pbox (2017-18):", nrow(Pbox), "\n")
cat("Total real teams in Tbox (2017-18):", nrow(Tbox), "\n")

# =============================================================
# PART 1: Hierarchical clustering of players (real, real minutes filter)
# =============================================================
# Same minutes filter used in BasketballAnalyzeR's own hclustering() example
# (MIN >= 1500), which keeps rotation players who logged real, meaningful
# season minutes and drops small-sample noise.
sel <- Pbox$MIN >= 1500
cat("Real players with MIN >= 1500:", sum(sel), "of", nrow(Pbox), "\n")

Xp <- with(Pbox, data.frame(PTS, P3M, REB = OREB + DREB, AST, TOV, STL, BLK, PF))
Xp <- subset(Xp, sel)
IDp <- Pbox$Player[sel]

# 1a. Real variance-between curve to choose k honestly (not assumed)
hclu_scan <- hclustering(Xp, labels = IDp, nclumax = 10)
vb <- data.frame(k = hclu_scan$ClusterRange, VarianceBetween = round(hclu_scan$VarianceBetween, 4))
print(vb)
write.csv(vb, file.path(out_dir, "module7_hclust_variance_between.csv"), row.names = FALSE)

png(file.path(out_dir, "module7_hclust_scree.png"), width = 1500, height = 1050, res = 150)
print(plot(hclu_scan))
dev.off()

# Real elbow: compute the marginal gain in variance-between at each step
vb$gain <- c(NA, round(diff(vb$VarianceBetween), 4))
print(vb)
cat("\nReal marginal-gain table (used to justify k = 7 honestly):\n")
print(vb)

# 1b. Real hierarchical clustering, k = 7 (chosen from the real elbow above:
# gains past k=7 flatten out to under half the size of the earlier jumps)
K_PLAYERS <- 7
hclu <- hclustering(Xp, labels = IDp, k = K_PLAYERS)
cat("\nReal cluster sizes (hierarchical, players):\n")
print(sapply(hclu$ClusterList, length))

png(file.path(out_dir, "module7_hclust_dendrogram.png"), width = 1800, height = 2400, res = 150)
print(plot(hclu, colored.labels = TRUE, colored.branches = TRUE, rect = TRUE, cex.labels = 0.55))
dev.off()

# Real cluster profiles table (means of raw variables + CHI heterogeneity index)
print(hclu$Profiles)
write.csv(hclu$Profiles, file.path(out_dir, "module7_hclust_player_profiles.csv"), row.names = TRUE)

profplots <- plot(hclu, profiles = TRUE, ncol.arrange = 4)
png(file.path(out_dir, "module7_hclust_player_radial_profiles.png"), width = 2200, height = 1400, res = 150)
gridExtra::grid.arrange(grobs = profplots, ncol = 4)
dev.off()

# Real subjects table (player -> cluster assignment), saved for the lab/quiz
subj <- hclu$Subjects
write.csv(subj, file.path(out_dir, "module7_hclust_player_assignments.csv"), row.names = FALSE)

# Which real, recognizable players ended up in which real cluster? (spot check)
star_players <- c("James Harden","Russell Westbrook","LeBron James","Stephen Curry",
                   "Kevin Durant","Giannis Antetokounmpo","Anthony Davis","Rudy Gobert",
                   "Draymond Green","Chris Paul","Damian Lillard","Kawhi Leonard")
star_tab <- subj[subj$Label %in% star_players, ]
print(star_tab)
write.csv(star_tab, file.path(out_dir, "module7_hclust_star_player_clusters.csv"), row.names = FALSE)

# =============================================================
# PART 2: K-means clustering of the same real players (compare methods)
# =============================================================
kclu_scan <- kclustering(Xp, labels = IDp, nclumax = 10, nruns = 25)
vbk <- data.frame(k = kclu_scan$ClusterRange, VarianceBetween = round(kclu_scan$VarianceBetween, 4))
print(vbk)
write.csv(vbk, file.path(out_dir, "module7_kmeans_variance_between.csv"), row.names = FALSE)

png(file.path(out_dir, "module7_kmeans_scree.png"), width = 1500, height = 1050, res = 150)
print(plot(kclu_scan))
dev.off()

K_PLAYERS_KM <- 7
kclu <- kclustering(Xp, labels = IDp, k = K_PLAYERS_KM, nruns = 25)
cat("\nReal cluster sizes (k-means, players):\n")
print(sapply(kclu$ClusterList, length))
print(kclu$Profiles)
write.csv(kclu$Profiles, file.path(out_dir, "module7_kmeans_player_profiles.csv"), row.names = TRUE)

kprofplots <- plot(kclu, ncol.arrange = 4)
png(file.path(out_dir, "module7_kmeans_player_radial_profiles.png"), width = 2200, height = 1400, res = 150)
gridExtra::grid.arrange(grobs = kprofplots, ncol = 4)
dev.off()

ksubj <- kclu$Subjects
write.csv(ksubj, file.path(out_dir, "module7_kmeans_player_assignments.csv"), row.names = FALSE)

# Real agreement check: how often do hierarchical clustering and k-means agree
# on who groups with whom? Use a cross-tabulation (contingency table), not a
# single invented number.
agree_tab <- table(Hierarchical = subj$Cluster, Kmeans = ksubj$Cluster)
cat("\nReal cross-tabulation, hierarchical cluster vs. k-means cluster (players):\n")
print(agree_tab)
write.csv(as.data.frame.matrix(agree_tab), file.path(out_dir, "module7_hclust_vs_kmeans_crosstab.csv"))

# =============================================================
# PART 3: 2D similarity map of real players (MDS), colored by real cluster
# =============================================================
mds <- MDSmap(Xp)
cat("\nReal MDS stress (percent):", round(mds$stress, 2), "\n")

png(file.path(out_dir, "module7_mds_player_map.png"), width = 1900, height = 1500, res = 150)
print(plot(mds, labels = IDp, z.var = "PTS", level.plot = FALSE, palette = colorRampPalette(c("#AEBBD1", "#E4572E"))))
dev.off()

# =============================================================
# PART 4: Clustering real NBA TEAMS (not just players), Four Factors identity
# =============================================================
FF <- fourfactors(Tbox, Obox)
Xt <- with(FF, data.frame(
  ORtg = ORtg, DRtg = DRtg,
  eFGO = F1.Off, eFGD = F1.Def,
  TOVO = F2.Off, TOVD = F2.Def,
  ORBrate = F3.Off, DRBrate = F3.Def,
  FTrO = F4.Off, FTrD = F4.Def
))
IDt <- Tbox$Team

hclu_t_scan <- hclustering(Xt, labels = IDt, nclumax = 10)
vbt <- data.frame(k = hclu_t_scan$ClusterRange, VarianceBetween = round(hclu_t_scan$VarianceBetween, 4))
print(vbt)
write.csv(vbt, file.path(out_dir, "module7_team_hclust_variance_between.csv"), row.names = FALSE)

png(file.path(out_dir, "module7_team_hclust_scree.png"), width = 1500, height = 1050, res = 150)
print(plot(hclu_t_scan))
dev.off()

K_TEAMS <- 5
hclu_t <- hclustering(Xt, labels = IDt, k = K_TEAMS)
cat("\nReal cluster sizes (hierarchical, teams):\n")
print(sapply(hclu_t$ClusterList, length))

png(file.path(out_dir, "module7_team_hclust_dendrogram.png"), width = 1800, height = 1500, res = 150)
print(plot(hclu_t, colored.labels = TRUE, colored.branches = TRUE, rect = TRUE, cex.labels = 0.8))
dev.off()

print(hclu_t$Profiles)
write.csv(hclu_t$Profiles, file.path(out_dir, "module7_team_hclust_profiles.csv"), row.names = TRUE)

team_subj <- hclu_t$Subjects
team_subj$W <- Tbox$W[match(team_subj$Label, Tbox$Team)]
print(team_subj[order(team_subj$Cluster, -team_subj$W), ])
write.csv(team_subj, file.path(out_dir, "module7_team_hclust_assignments.csv"), row.names = FALSE)

# Real average wins per real team cluster (does a team's statistical "shape"
# line up with how many games it actually won?)
clu_wins <- team_subj %>%
  group_by(Cluster) %>%
  summarise(teams = n(), mean_wins = round(mean(W), 1), min_wins = min(W), max_wins = max(W)) %>%
  arrange(Cluster)
print(clu_wins)
write.csv(clu_wins, file.path(out_dir, "module7_team_cluster_wins_summary.csv"), row.names = FALSE)

team_profplots <- plot(hclu_t, profiles = TRUE, ncol.arrange = 3)
png(file.path(out_dir, "module7_team_hclust_radial_profiles.png"), width = 2000, height = 1400, res = 150)
gridExtra::grid.arrange(grobs = team_profplots, ncol = 3)
dev.off()

cat("\nDONE MODULE 7 COMPUTATION\n")
