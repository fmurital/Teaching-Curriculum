# Graduate Module 9: Machine Learning Models for Scoring Probability
# Real data: 2023-24 NBA shot log (shufinskiy/nba_data, shotdetail_2023.csv, 218,701 shots),
# downloaded from https://raw.githubusercontent.com/shufinskiy/nba_data/main/datasets/shotdetail_2023.tar.xz
# Method mirrors Zuccolotto, Sandri & Manisera (2023), "Spatial performance analysis in
# basketball with CART, random forest and extremely randomized trees," Annals of Operations
# Research, 325(1), 495-519: use tree ensembles as "probability machines" for scoring
# probability, compared on real out-of-sample predictive performance (AUC).
#
# To reproduce: download shotdetail_2023.csv from the URL above and place it in this folder,
# install the "ranger" package, then run this script with Rscript.

suppressWarnings(suppressMessages(library(ranger)))

set.seed(2026)
df <- read.csv("shotdetail_2023.csv", stringsAsFactors = FALSE)

df$SHOT_MADE_FLAG <- factor(as.integer(df$SHOT_MADE_FLAG), levels = c(0, 1))
df$PERIOD <- as.integer(df$PERIOD)
df$time_remaining_period <- df$MINUTES_REMAINING * 60 + df$SECONDS_REMAINING
df$SHOT_ZONE_BASIC <- as.factor(df$SHOT_ZONE_BASIC)
df$SHOT_TYPE <- as.factor(df$SHOT_TYPE)

model_df <- df[, c("SHOT_MADE_FLAG", "SHOT_DISTANCE", "LOC_X", "LOC_Y", "PERIOD",
                    "time_remaining_period", "SHOT_ZONE_BASIC", "SHOT_TYPE")]
model_df <- na.omit(model_df)
cat("Rows used:", nrow(model_df), "\n")
cat("Base make rate:", round(mean(as.numeric(as.character(model_df$SHOT_MADE_FLAG))), 4), "\n")

n <- nrow(model_df)
train_idx <- sample(seq_len(n), size = floor(0.8 * n))
train <- model_df[train_idx, ]
test <- model_df[-train_idx, ]

auc_manual <- function(pred, actual) {
  # Mann-Whitney U based AUC, no external package needed.
  r <- rank(pred)
  actual <- as.numeric(as.character(actual))
  n1 <- sum(actual == 1)
  n0 <- sum(actual == 0)
  (sum(r[actual == 1]) - n1 * (n1 + 1) / 2) / (n1 * n0)
}

# --- Model 1: Random Forest (axis-aligned, standard CART-based ensemble) ---
rf <- ranger(SHOT_MADE_FLAG ~ ., data = train, probability = TRUE,
             num.trees = 300, splitrule = "gini", classification = TRUE,
             respect.unordered.factors = "order", seed = 2026)
pred_rf <- predict(rf, data = test)$predictions[, "1"]
auc_rf <- auc_manual(pred_rf, test$SHOT_MADE_FLAG)

# --- Model 2: Extremely Randomized Trees (random split points, not just random features) ---
ert <- ranger(SHOT_MADE_FLAG ~ ., data = train, probability = TRUE,
              num.trees = 300, splitrule = "extratrees", num.random.splits = 5,
              classification = TRUE, respect.unordered.factors = "order", seed = 2026)
pred_ert <- predict(ert, data = test)$predictions[, "1"]
auc_ert <- auc_manual(pred_ert, test$SHOT_MADE_FLAG)

cat(sprintf("Random Forest out-of-sample AUC: %.3f\n", auc_rf))
cat(sprintf("Extremely Randomized Trees out-of-sample AUC: %.3f\n", auc_ert))

# Variable importance: Gini (impurity), with the high-cardinality bias flagged in class,
# and permutation importance as the more trustworthy alternative.
rf_imp <- ranger(SHOT_MADE_FLAG ~ ., data = train, probability = TRUE,
                  num.trees = 300, splitrule = "gini", classification = TRUE,
                  respect.unordered.factors = "order", importance = "impurity", seed = 2026)
imp <- sort(importance(rf_imp), decreasing = TRUE)
print(imp)

summary_out <- data.frame(
  model = c("Random Forest", "Extremely Randomized Trees"),
  n_train = c(nrow(train), nrow(train)),
  n_test = c(nrow(test), nrow(test)),
  auc = c(auc_rf, auc_ert)
)
write.csv(summary_out, "module09_model_comparison.csv", row.names = FALSE)
write.csv(data.frame(variable = names(imp), importance = as.numeric(imp)),
          "module09_variable_importance.csv", row.names = FALSE)

# --- Shot-probability court map, from the Random Forest fit ---
gx <- seq(-250, 250, by = 10)
gy <- seq(-50, 420, by = 10)
grid <- expand.grid(LOC_X = gx, LOC_Y = gy)
grid$SHOT_DISTANCE <- sqrt(grid$LOC_X^2 + grid$LOC_Y^2) / 10
grid$PERIOD <- 2L
grid$time_remaining_period <- 360
grid$SHOT_TYPE <- factor(ifelse(grid$SHOT_DISTANCE >= 23.75, "3PT Field Goal", "2PT Field Goal"),
                          levels = levels(model_df$SHOT_TYPE))
grid$SHOT_ZONE_BASIC <- factor(
  ifelse(grid$SHOT_DISTANCE < 4, "Restricted Area",
  ifelse(grid$SHOT_DISTANCE < 8, "In The Paint (Non-RA)",
  ifelse(grid$SHOT_TYPE == "3PT Field Goal", "Above the Break 3", "Mid-Range"))),
  levels = levels(model_df$SHOT_ZONE_BASIC))
grid <- grid[grid$SHOT_DISTANCE <= 35, ]
grid$prob <- predict(rf, data = grid)$predictions[, "1"]

png("module09_scoring_probability_map.png", width = 1200, height = 1000, res = 150)
cols <- colorRampPalette(c("#E4572E", "#EDF1F7", "#27496D"))(100)
col_idx <- pmin(100, pmax(1, ceiling(grid$prob * 100)))
par(mar = c(4, 4, 4, 2))
plot(grid$LOC_X, grid$LOC_Y, col = cols[col_idx], pch = 15, cex = 1.3,
     xlab = "Court X (hoop-centered, NBA stats coordinates)",
     ylab = "Court Y (distance from baseline)",
     main = "Random Forest Scoring-Probability Map\n2023-24 NBA shots (real data, out-of-sample model)")
symbols(0, 0, circles = 7.5, inches = FALSE, add = TRUE, lwd = 2)
legend("topright", legend = c("Higher P(make)", "Lower P(make)"), fill = c("#27496D", "#E4572E"), bty = "n", cex = 0.8)
dev.off()

# --- Companion chart: real field goal percentage by distance bucket ---
df$dist_bucket <- cut(df$SHOT_DISTANCE, breaks = c(-1, 2, 4, 6, 8, 10, 15, 20, 23, 24, 26, 30, 40),
                       labels = c("0-2", "2-4", "4-6", "6-8", "8-10", "10-15", "15-20", "20-23", "23-24", "24-26", "26-30", "30+"))
agg <- aggregate(as.numeric(as.character(SHOT_MADE_FLAG)) ~ dist_bucket, data = df, FUN = mean)
names(agg) <- c("dist_bucket", "fg_pct")
write.csv(agg, "module09_fgpct_by_distance.csv", row.names = FALSE)

png("module09_fgpct_by_distance.png", width = 1300, height = 800, res = 150)
par(mar = c(6, 5, 4, 2))
bp <- barplot(agg$fg_pct * 100, names.arg = agg$dist_bucket, las = 2,
              col = "#27496D", ylim = c(0, 75),
              xlab = "", ylab = "Field goal percentage",
              main = "Real 2023-24 NBA Field Goal % by Shot Distance (ft)")
text(bp, agg$fg_pct * 100 + 3, labels = sprintf("%.0f%%", agg$fg_pct * 100), cex = 0.7)
mtext("Shot distance bucket (feet)", side = 1, line = 4.5)
dev.off()

# --- Companion chart: variable importance ---
png("module09_variable_importance.png", width = 1300, height = 800, res = 150)
par(mar = c(5, 13, 4, 2))
barplot(rev(imp), horiz = TRUE, names.arg = rev(names(imp)), las = 1,
        col = "#E4572E", xlab = "Gini importance (Random Forest)",
        main = "Which Variables Drive the Model's Predictions?")
dev.off()

cat("Done.\n")
