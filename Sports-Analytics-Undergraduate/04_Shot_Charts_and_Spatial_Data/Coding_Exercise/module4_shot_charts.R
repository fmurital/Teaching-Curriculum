# Module 4: Shot Charts and Spatial Data
# Real data: BasketballAnalyzeR::PbP.BDB -- Golden State Warriors' real, complete 2017-18 NBA
#   regular-season play-by-play log (82 games), structured hub-and-spoke around Golden State.
#   Every other team's rows are limited to that team's own real regular-season meetings with
#   Golden State that season (Houston: 3 games; Cleveland: 2 games).
# Reproduces every number and chart used in Module 4 slides, notes, and lab.

options(width = 120)
library(BasketballAnalyzeR)
library(dplyr)
library(ggplot2)

out_dir <- "Sports-Analytics-Undergraduate/04_Shot_Charts_and_Spatial_Data/Coding_Exercise"

data(PbP.BDB)
PbP <- PbPmanipulation(PbP.BDB)

# ---- Build a shot-level dataset with half-court centered coordinates ----
# BasketballAnalyzeR::shotchart() requires y <= 0 (origin at center court, feet).
# converted_x/converted_y in PbP.BDB are full-court coordinates (0-50 x 0-94).
# We fold shots taken at the "far" basket onto the same half-court view.
shots <- PbP %>%
  filter(event_type %in% c("shot", "miss")) %>%
  mutate(
    cx = as.numeric(as.character(converted_x)),
    cy = as.numeric(as.character(converted_y)),
    made = ifelse(event_type == "shot", 1L, 0L),
    result2 = factor(ifelse(event_type == "shot", "made", "missed"), levels = c("made", "missed")),
    dist = as.numeric(as.character(shot_distance))
  ) %>%
  filter(!is.na(cx), !is.na(cy)) %>%
  mutate(
    yc = ifelse(cy <= 47, cy - 47, 47 - cy),
    xc = ifelse(cy <= 47, cx - 25, 25 - cx),
    zone = case_when(
      dist <= 4  ~ "Rim (0-4 ft)",
      dist <= 14 ~ "Short/Mid (5-14 ft)",
      dist <= 21 ~ "Long Two (15-21 ft)",
      TRUE       ~ "Three (22+ ft)"
    ),
    zone = factor(zone, levels = c("Rim (0-4 ft)","Short/Mid (5-14 ft)","Long Two (15-21 ft)","Three (22+ ft)"))
  )

cat("Total field goal attempts (made+miss), Golden State's 2017-18 regular season:", nrow(shots), "\n")

# ---- Team case study: Houston Rockets (their 3 real 2017-18 regular-season games against Golden State) ----
hou <- shots %>% filter(team == "HOU")
cat("HOU attempts:", nrow(hou), " FG%:", round(100*mean(hou$made),1), "\n")

p_hou_scatter <- shotchart(data = hou, x = "xc", y = "yc", z = "result2", scatter = TRUE)
ggsave(file.path(out_dir, "module4_hou_scatter.png"), p_hou_scatter, width = 9, height = 8, dpi = 150)

p_hou_density <- shotchart(data = hou, x = "xc", y = "yc", type = "density-hexbin", nbins = 24)
ggsave(file.path(out_dir, "module4_hou_density.png"), p_hou_density, width = 9, height = 8, dpi = 150)

# ---- Contrast team: Cleveland Cavaliers (their 2 real 2017-18 regular-season games against Golden State) ----
cle <- shots %>% filter(team == "CLE")
cat("CLE attempts:", nrow(cle), " FG%:", round(100*mean(cle$made),1), "\n")
p_cle_scatter <- shotchart(data = cle, x = "xc", y = "yc", z = "result2", scatter = TRUE)
ggsave(file.path(out_dir, "module4_cle_scatter.png"), p_cle_scatter, width = 9, height = 8, dpi = 150)

# ---- Zone table: attempt share + FG% + points-per-shot, HOU vs CLE ----
zone_tab <- shots %>%
  filter(team %in% c("HOU","CLE")) %>%
  group_by(team, zone) %>%
  summarise(attempts = n(), fgpct = round(100*mean(made),1),
            pps = round(mean(ifelse(made==1, ifelse(zone=="Three (22+ ft)",3,2), 0)),2), .groups="drop") %>%
  group_by(team) %>% mutate(share = round(100*attempts/sum(attempts),1)) %>% ungroup() %>%
  arrange(team, zone)
print(zone_tab)
write.csv(zone_tab, file.path(out_dir, "module4_zone_table_hou_cle.csv"), row.names = FALSE)

# ---- Zone attempt share across Golden State's full real season (all shots in this dataset) for context ----
league_zone <- shots %>% group_by(zone) %>%
  summarise(attempts = n(), fgpct = round(100*mean(made),1), .groups="drop") %>%
  mutate(share = round(100*attempts/sum(attempts),1))
print(league_zone)
write.csv(league_zone, file.path(out_dir, "module4_zone_table_league.csv"), row.names = FALSE)

# ---- Player comparison: James Harden (HOU) vs LeBron James (CLE) ----
cat("\nplayers HOU top volume:\n")
print(hou %>% count(player, sort=TRUE) %>% head(5))
cat("\nplayers CLE top volume:\n")
print(cle %>% count(player, sort=TRUE) %>% head(5))

harden <- shots %>% filter(team=="HOU", player=="James Harden")
lebron <- shots %>% filter(team=="CLE", player=="LeBron James")
cat("Harden attempts:", nrow(harden), " FG%:", round(100*mean(harden$made),1), "\n")
cat("LeBron attempts:", nrow(lebron), " FG%:", round(100*mean(lebron$made),1), "\n")

p_harden <- shotchart(data = harden, x = "xc", y = "yc", z = "result2", scatter = TRUE)
ggsave(file.path(out_dir, "module4_harden_scatter.png"), p_harden, width = 9, height = 8, dpi = 150)
p_lebron <- shotchart(data = lebron, x = "xc", y = "yc", z = "result2", scatter = TRUE)
ggsave(file.path(out_dir, "module4_lebron_scatter.png"), p_lebron, width = 9, height = 8, dpi = 150)

player_zone <- bind_rows(harden %>% mutate(who="James Harden (HOU)"), lebron %>% mutate(who="LeBron James (CLE)")) %>%
  group_by(who, zone) %>% summarise(attempts=n(), fgpct=round(100*mean(made),1), .groups="drop") %>%
  group_by(who) %>% mutate(share=round(100*attempts/sum(attempts),1)) %>% ungroup()
print(player_zone)
write.csv(player_zone, file.path(out_dir, "module4_zone_table_players.csv"), row.names=FALSE)

cat("\nDONE MODULE 4 COMPUTATION\n")
