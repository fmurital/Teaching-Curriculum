# Module 4 (graduate): Season Segments and Final Rankings
# Methodology: Zuccolotto, Manisera & Sandri (2026), Advanced Basketball Data Science, Ch. 4
#   ("The race to the finish: exploring the relationship between season segments and final
#   rankings"). The book's own worked example uses a private Italian LBA play-by-play file and
#   a supplementary AdjRtg() function that are not publicly redistributed, so this script
#   reproduces the chapter's real methodology on real, freely available data instead:
#   BasketballAnalyzeR::PbP.BDB, which (confirmed live in this session via its data_set field
#   and per-team game counts) is the real, complete 2017-18 NBA regular season play-by-play
#   record for the Golden State Warriors -- all 82 of GSW's real games, Oct 17 2017 to
#   Apr 11 2018 -- with every opponent appearing only in its own games against GSW (2-4 games
#   each). AdjRtg() itself is implemented here directly from the textbook's own formulas
#   (4.1)-(4.2), applied to real per-game box scores built with BasketballAnalyzeR's own
#   TOPboxes()/fourfactors() pipeline (textbook section 1.4.1).

options(width = 120)
library(BasketballAnalyzeR)
library(dplyr)
library(ggplot2)
library(ggalluvial)
library(zoo)
library(rpart)

out_dir <- "Sports-Analytics-Graduate/04_Season_Segments_and_Final_Rankings/Coding_Exercise"

`%~%` <- function(x, pattern) grepl(pattern, x, fixed = TRUE)

data(PbP.BDB)
PbP <- PbPmanipulation(PbP.BDB)
cat("Real data_set label(s) in PbP.BDB:", paste(unique(as.character(PbP$data_set)), collapse=", "), "\n")

TOPPbP <- PbP %>%
  mutate(across(c(game_id, ShotType, result, team, assist, block,
                  steal, player, h1, h2, h3, h4, h5, a1, a2, a3, a4, a5,
                  hometeam, type, event_type), as.character)) %>%
  mutate(
    oreb = type %~% "rebound offensive",
    dreb = type %~% "rebound defensive",
    turnover = event_type == "turnover",
    PF = (event_type == "foul") & !(type %~% "technical")
  )

# ---- Build real per-game box scores (one real game at a time, textbook section 1.4.1 style) ----
game_ids <- unique(TOPPbP$game_id)
cat("Real games in this dataset:", length(game_ids), "\n")

build_game_row <- function(gid) {
  gdat <- TOPPbP %>% filter(game_id == gid)
  teams_in_game <- unique(gdat$team[!is.na(gdat$team) & gdat$team != ""])
  home <- unique(gdat$hometeam[!is.na(gdat$hometeam) & gdat$hometeam != ""])
  if (length(home) == 0 || length(teams_in_game) != 2) return(NULL)
  home <- home[1]
  away <- setdiff(teams_in_game, home)
  if (length(away) != 1) return(NULL)
  TOP <- tryCatch(TOPboxes(gdat, team = home), error = function(e) NULL)
  if (is.null(TOP)) return(NULL)
  Tbox <- TOP$Tbox; Obox <- TOP$Obox
  Tbox$Team <- home; Obox$Team <- away
  FF <- tryCatch(fourfactors(Tbox, Obox), error = function(e) NULL)
  if (is.null(FF)) return(NULL)
  data.frame(
    game_id = gid, game_date = gdat$date[1],
    home_team = home, away_team = away,
    home_score = Tbox$PTS, away_score = Obox$PTS,
    home_poss = FF$POSS.Off, away_poss = FF$POSS.Def
  )
}

games_list <- lapply(game_ids, build_game_row)
games_info <- bind_rows(games_list)
games_info$game_date <- as.Date(games_info$game_date, format = "%m/%d/%Y")
games_info <- games_info %>% arrange(game_date)
cat("Real games successfully processed into games_info:", nrow(games_info), "\n")
write.csv(games_info, file.path(out_dir, "module4_games_info.csv"), row.names = FALSE)

# ---- AdjRtg(), implemented directly from the textbook's formulas (4.1)-(4.2) ----
AdjRtg <- function(gi) {
  teams <- sort(unique(c(gi$home_team, gi$away_team)))
  N <- length(teams)
  P <- matrix(0, N, N, dimnames = list(teams, teams))
  Poss <- matrix(0, N, N, dimnames = list(teams, teams))
  for (k in seq_len(nrow(gi))) {
    h <- gi$home_team[k]; a <- gi$away_team[k]
    P[h, a] <- P[h, a] + gi$home_score[k]; Poss[h, a] <- Poss[h, a] + gi$home_poss[k]
    P[a, h] <- P[a, h] + gi$away_score[k]; Poss[a, h] <- Poss[a, h] + gi$away_poss[k]
  }
  R <- P / Poss
  R[Poss == 0] <- NA
  wavg <- function(v, w) { ok <- !is.na(v) & !is.na(w) & w > 0; if (!any(ok)) return(NA); sum(v[ok]*w[ok])/sum(w[ok]) }
  ORtg <- sapply(seq_len(N), function(i) wavg(R[i, ], Poss[i, ]))
  DRtg <- sapply(seq_len(N), function(j) wavg(R[, j], Poss[, j]))
  names(ORtg) <- teams; names(DRtg) <- teams
  offij <- sweep(R, 2, DRtg, "-")
  defji <- sweep(R, 1, ORtg, "-")
  AORtg <- sapply(seq_len(N), function(i) wavg(offij[i, ], Poss[i, ]))
  ADRtg <- sapply(seq_len(N), function(j) wavg(defji[, j], Poss[, j]))
  data.frame(team = teams, GP = sapply(teams, function(t) sum(gi$home_team==t | gi$away_team==t)),
             ORtg = round(ORtg*100,2), DRtg = round(DRtg*100,2),
             AORtg = round(AORtg*100,2), ADRtg = round(-ADRtg*100,2))
}

full_season <- AdjRtg(games_info) %>% arrange(desc(AORtg))
print(full_season)
write.csv(full_season, file.path(out_dir, "module4_adjrtg_full_season.csv"), row.names=FALSE)

# ---- Two real season segments: first half vs second half, chronological ("two acts") ----
half <- ceiling(nrow(games_info)/2)
seg1 <- games_info[1:half, ]
seg2 <- games_info[(half+1):nrow(games_info), ]
cat("Segment 1 (real games):", nrow(seg1), " from", as.character(min(seg1$game_date)), "to", as.character(max(seg1$game_date)), "\n")
cat("Segment 2 (real games):", nrow(seg2), " from", as.character(min(seg2$game_date)), "to", as.character(max(seg2$game_date)), "\n")

ar1 <- AdjRtg(seg1) %>% rename(AORtg1=AORtg, ADRtg1=ADRtg, ORtg1=ORtg, DRtg1=DRtg, GP1=GP)
ar2 <- AdjRtg(seg2) %>% rename(AORtg2=AORtg, ADRtg2=ADRtg, ORtg2=ORtg, DRtg2=DRtg, GP2=GP)

wins <- games_info %>% mutate(winner = ifelse(home_score > away_score, home_team, away_team)) %>%
  count(winner, name="wins_in_sample")

ARtg <- full_join(ar1, ar2, by="team") %>% left_join(wins, by=c("team"="winner")) %>%
  mutate(wins_in_sample = ifelse(is.na(wins_in_sample), 0, wins_in_sample)) %>%
  arrange(desc(wins_in_sample))
print(ARtg)
write.csv(ARtg, file.path(out_dir, "module4_adjrtg_two_segments.csv"), row.names=FALSE)

gsw_wins <- sum(games_info$home_team=="GSW" & games_info$home_score>games_info$away_score) +
  sum(games_info$away_team=="GSW" & games_info$away_score>games_info$home_score)
gsw_gp <- sum(games_info$home_team=="GSW"|games_info$away_team=="GSW")
cat("\nGSW real record in this sample:", gsw_wins, "-", gsw_gp-gsw_wins, "out of", gsw_gp, "real games\n")

# ---- CART: does segment-1 AORtg/ADRtg predict real wins_in_sample? ----
cart_df <- ARtg %>% filter(!is.na(AORtg1) & !is.na(ADRtg1))
tree <- rpart(wins_in_sample ~ AORtg1 + ADRtg1, data=cart_df, control=rpart.control(minsplit=4, cp=0.05))
print(tree)
png(file.path(out_dir, "module4_cart_tree.png"), width=1100, height=750, res=130)
plot(tree, margin=0.15); text(tree, use.n=TRUE, cex=0.85)
dev.off()

# ---- Alluvial-style figure: Segment-1 AORtg category -> ADRtg category -> team, sized by real wins ----
alluv_df <- cart_df %>%
  mutate(AORtg1cat = factor(ifelse(AORtg1 < median(AORtg1), "Below median AORtg1", "Above median AORtg1")),
         ADRtg1cat = factor(ifelse(ADRtg1 < median(ADRtg1), "Below median ADRtg1", "Above median ADRtg1")),
         team = factor(team, levels = team[order(-wins_in_sample)]))
p_alluv <- ggplot(alluv_df, aes(axis1=AORtg1cat, axis2=ADRtg1cat, axis3=team, y=wins_in_sample)) +
  geom_alluvium(aes(fill=AORtg1cat)) + geom_stratum(width=0.35) +
  geom_text(stat="stratum", aes(label=after_stat(stratum)), size=3) +
  scale_x_discrete(limits=c("Segment 1 Adj. Off. Rating","Segment 1 Adj. Def. Rating","Team"), expand=c(.08,.08)) +
  labs(y="Real wins in this sample", title="From Real Segment-1 Ratings to Real Season Wins (GSW's 2017-18 schedule)") +
  theme_minimal() + theme(legend.position="none")
ggsave(file.path(out_dir, "module4_alluvial.png"), p_alluv, width=11, height=7, dpi=150)

# ---- Season evolution: GSW's real rolling net rating across all 82 real games ----
gsw <- games_info %>% mutate(
  gsw_pts = ifelse(home_team=="GSW", home_score, away_score),
  opp_pts = ifelse(home_team=="GSW", away_score, home_score),
  gsw_poss = ifelse(home_team=="GSW", home_poss, away_poss),
  opp_poss = ifelse(home_team=="GSW", away_poss, home_poss),
  ortg = 100*gsw_pts/gsw_poss, drtg = 100*opp_pts/opp_poss, net = ortg-drtg,
  win = (gsw_pts > opp_pts)
) %>% filter(home_team=="GSW" | away_team=="GSW") %>% arrange(game_date) %>%
  mutate(game_num = row_number(), roll_net = zoo::rollapply(net, width=10, FUN=mean, align="right", partial=TRUE))

write.csv(gsw %>% select(game_num, game_date, home_team, away_team, gsw_pts, opp_pts, ortg, drtg, net, win),
          file.path(out_dir, "module4_gsw_season_log.csv"), row.names=FALSE)

p_evo <- ggplot(gsw, aes(x=game_num, y=roll_net)) + geom_line(color="#E4572E", linewidth=1) +
  geom_hline(yintercept=0, linetype="dashed", color="grey50") +
  labs(x="Real game number (2017-18 season, chronological)", y="10-game rolling net rating",
       title="Golden State Warriors: Real Net Rating Across the Full 2017-18 Season") +
  theme_minimal()
ggsave(file.path(out_dir, "module4_gsw_season_evolution.png"), p_evo, width=10, height=6, dpi=150)

cat("\nGSW first-half real record:", sum(gsw$win[1:half]), "-", half-sum(gsw$win[1:half]), "\n")
cat("GSW second-half real record:", sum(gsw$win[(half+1):nrow(gsw)]), "-", (nrow(gsw)-half)-sum(gsw$win[(half+1):nrow(gsw)]), "\n")
cat("GSW real AORtg segment 1:", ar1$AORtg1[ar1$team=="GSW"], " segment 2:", ar2$AORtg2[ar2$team=="GSW"], "\n")
cat("GSW real ADRtg segment 1:", ar1$ADRtg1[ar1$team=="GSW"], " segment 2:", ar2$ADRtg2[ar2$team=="GSW"], "\n")

cat("\nDONE MODULE 4 GRAD COMPUTATION\n")
