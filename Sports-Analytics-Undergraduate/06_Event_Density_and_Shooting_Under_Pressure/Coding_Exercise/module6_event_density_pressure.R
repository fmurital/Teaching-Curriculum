# Module 6: Event Density and Shooting Under Pressure
# Real data: BasketballAnalyzeR::PbP.BDB (2017-18 NBA regular season play-by-play,
#            built around the Golden State Warriors' full 82-game 2017-18 schedule;
#            every other team's rows are that team's own real regular-season game(s)
#            against Golden State specifically, not a playoff series)
# Reproduces every number and chart used in Module 6 slides, notes, and lab.

options(width = 120)
library(BasketballAnalyzeR)
library(dplyr)

out_dir <- "Sports-Analytics-Undergraduate/06_Event_Density_and_Shooting_Under_Pressure/Coding_Exercise"

data(PbP.BDB)
PbP <- PbPmanipulation(PbP.BDB)
cat("Total real play-by-play events:", nrow(PbP), "\n")

# ---- Part 1: Event density over the shot clock (playlength) ----
# playlength = real seconds elapsed in that possession segment when the event happened.
# Higher playlength = the possession has burned more of the shot clock = more time pressure
# on the shooter. This is the real, built-in BasketballAnalyzeR::densityplot() workflow.
FG <- subset(PbP, ShotType %in% c("2P","3P"))
cat("Total real field goal attempts (2P+3P):", nrow(FG), "\n")
cat("Real playlength range on field goal attempts:", range(FG$playlength), "\n")
cat("Real playlength summary on field goal attempts:\n")
print(summary(FG$playlength))

p_dens <- densityplot(data = FG, var = "playlength", shot.type = "field")
ggplot2::ggsave(file.path(out_dir, "module6_density_playlength.png"), p_dens, width = 10, height = 7, dpi = 150)

# Best-scorer version: who is taking (and often making) the highest-density late-clock shots
p_dens_scorer <- densityplot(data = FG, var = "playlength", shot.type = "field", best.scorer = TRUE)
ggplot2::ggsave(file.path(out_dir, "module6_density_playlength_bestscorer.png"), p_dens_scorer, width = 10, height = 7, dpi = 150)

# ---- Part 2: Real shot-clock pressure buckets ----
# Early clock: playlength < 12 (first half of a 24-second shot clock possession)
# Late clock (high pressure): playlength >= 18 (last 6 seconds of a 24-second clock)
FG <- FG %>% mutate(
  clock_bucket = case_when(
    playlength < 12 ~ "Early clock (<12s elapsed)",
    playlength < 18 ~ "Mid clock (12-17s elapsed)",
    TRUE ~ "Late clock, high pressure (18s+ elapsed)"
  )
)
clock_tab <- FG %>%
  group_by(clock_bucket) %>%
  summarise(
    attempts = n(),
    makes = sum(result == "made", na.rm = TRUE),
    fg_pct = round(100 * mean(result == "made", na.rm = TRUE), 1),
    .groups = "drop"
  ) %>%
  arrange(match(clock_bucket, c("Early clock (<12s elapsed)","Mid clock (12-17s elapsed)","Late clock, high pressure (18s+ elapsed)")))
print(clock_tab)
write.csv(clock_tab, file.path(out_dir, "module6_shotclock_pressure_table.csv"), row.names = FALSE)

# Three-point shooting specifically under late-clock pressure
FG3 <- subset(PbP, ShotType == "3P") %>% mutate(
  clock_bucket = case_when(
    playlength < 12 ~ "Early clock (<12s elapsed)",
    playlength < 18 ~ "Mid clock (12-17s elapsed)",
    TRUE ~ "Late clock, high pressure (18s+ elapsed)"
  )
)
clock_tab_3p <- FG3 %>%
  group_by(clock_bucket) %>%
  summarise(attempts = n(), makes = sum(result=="made", na.rm=TRUE),
            fg_pct = round(100*mean(result=="made", na.rm=TRUE), 1), .groups="drop") %>%
  arrange(match(clock_bucket, c("Early clock (<12s elapsed)","Mid clock (12-17s elapsed)","Late clock, high pressure (18s+ elapsed)")))
print(clock_tab_3p)
write.csv(clock_tab_3p, file.path(out_dir, "module6_shotclock_pressure_3p_table.csv"), row.names = FALSE)

# ---- Part 3: Real clutch-time pressure (last 5 min of Q4/OT, margin <= 5) ----
# Standard clutch definition (NBA.com Advanced Stats): last 5 minutes of the 4th period
# or overtime, score within 5 points. periodTime is real seconds ELAPSED in the period,
# so the last 5 minutes of a 12-minute period is periodTime >= 420.
PbP2 <- PbP %>% mutate(
  margin = abs(home_score - away_score),
  is_clutch = (period >= 4 & periodTime >= 420 & margin <= 5)
)
FGclutch <- subset(PbP2, ShotType %in% c("2P","3P"))
clutch_tab <- FGclutch %>%
  group_by(is_clutch) %>%
  summarise(attempts = n(), makes = sum(result=="made", na.rm=TRUE),
            fg_pct = round(100*mean(result=="made", na.rm=TRUE),1), .groups="drop")
print(clutch_tab)
write.csv(clutch_tab, file.path(out_dir, "module6_clutch_pressure_table.csv"), row.names = FALSE)

cat("Real clutch-time field goal attempts (period>=4, periodTime>=420, margin<=5):", sum(FGclutch$is_clutch), "\n")
cat("Real non-clutch field goal attempts:", sum(!FGclutch$is_clutch), "\n")

# ---- Part 4: Who takes the most real clutch shots? (Warriors' own games, since PbP.BDB is GSW-centered) ----
clutch_by_player <- FGclutch %>%
  filter(is_clutch) %>%
  group_by(player) %>%
  summarise(attempts = n(), makes = sum(result=="made", na.rm=TRUE),
            fg_pct = round(100*mean(result=="made", na.rm=TRUE),1), .groups="drop") %>%
  filter(attempts >= 5) %>%
  arrange(desc(attempts))
print(clutch_by_player)
write.csv(clutch_by_player, file.path(out_dir, "module6_clutch_by_player.csv"), row.names = FALSE)

cat("\nDONE MODULE 6 COMPUTATION\n")
