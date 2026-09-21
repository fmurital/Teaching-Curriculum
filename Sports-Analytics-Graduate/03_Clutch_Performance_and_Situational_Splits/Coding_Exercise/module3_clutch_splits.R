# Module 3: Clutch Performance and Situational Splits (graduate)
# Methodology: Zuccolotto, Manisera & Sandri (2026), Advanced Basketball Data Science, Ch.3
#   ("Drilling down on clutch splits"), reproduced on real data:
#   BasketballAnalyzeR::PbP.BDB -- NBA 2017-18 playoffs, real play-by-play, 82 games, all 16
#   playoff teams. Case study teams: Boston Celtics (mirrors the book's 3.1) and Golden State
#   Warriors (mirrors the book's 3.2) -- the two teams that met in the 2018 Western/Eastern
#   playoffs; GSW won the 2018 title.

options(width = 120)
library(BasketballAnalyzeR)
library(dplyr)
library(gridExtra)

out_dir <- "Sports-Analytics-Graduate/03_Clutch_Performance_and_Situational_Splits/Coding_Exercise"

data(PbP.BDB)
PbP <- PbPmanipulation(PbP.BDB)

# ---- Build the variables TOPboxes() requires (textbook section 1.4.1 pipeline) ----
`%~%` <- function(x, pattern) grepl(pattern, x, fixed = TRUE)

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

# ---- Clutch situation definition (identical to the textbook): < 5 min left, |score diff| <= 5 ----
totalTime_c <- 2580
scorediff_c <- 5
AS_min <- 4  # lowered from the textbook's AS_min = 20 (full 82-game regular season) to fit a playoffs-only real sample

run_team <- function(Team) {
  TOPPbPc <- TOPPbP %>%
    mutate(scorediff = abs(home_score - away_score)) %>%
    filter(scorediff <= scorediff_c & totalTime > totalTime_c)

  TOP  <- TOPboxes(TOPPbP,  team = Team)
  TOPc <- TOPboxes(TOPPbPc, team = Team)

  Tbox  <- TOP$Tbox;  Obox  <- TOP$Obox;  Pbox  <- TOP$Pbox
  Tboxc <- TOPc$Tbox; Oboxc <- TOPc$Obox; Pboxc <- TOPc$Pbox

  Tboxes <- data.frame(Team = c("Clutch","General"), rbind(Tboxc, Tbox))
  Oboxes <- data.frame(Team = c("Clutch","General"), rbind(Oboxc, Obox))

  list(Tbox=Tbox, Obox=Obox, Pbox=Pbox, Tboxc=Tboxc, Oboxc=Oboxc, Pboxc=Pboxc,
       Tboxes=Tboxes, Oboxes=Oboxes)
}

for (Team in c("BOS","GSW")) {
  cat("\n=========", Team, "=========\n")
  res <- run_team(Team)

  cat("General MIN (team total):", res$Tbox$MIN, " Clutch MIN:", res$Tboxc$MIN, "\n")

  FF <- fourfactors(res$Tboxes, res$Oboxes)
  listPlots <- plot(FF)
  listPlots$FFOplot <- listPlots$FFOplot + ggplot2::labs(fill = "Split")
  listPlots$FFDplot <- listPlots$FFDplot + ggplot2::labs(fill = "Split")
  png(file.path(out_dir, paste0("module3_", tolower(Team), "_fourfactors.png")), width = 1100, height = 950, res = 130)
  gridExtra::grid.arrange(grobs = listPlots, nrow = 2)
  dev.off()

  # Inequality / Gini / Lorenz, clutch vs general
  ineqc <- inequality(res$Pboxc$PTS, nplayers = min(10, nrow(res$Pboxc)))
  ineq  <- inequality(res$Pbox$PTS,  nplayers = min(10, nrow(res$Pbox)))
  p1 <- plot(ineqc, title = "Clutch")
  p2 <- plot(ineq,  title = "General")
  png(file.path(out_dir, paste0("module3_", tolower(Team), "_inequality.png")), width = 1100, height = 550, res = 130)
  gridExtra::grid.arrange(p1, p2, nrow = 1)
  dev.off()
  cat("Gini clutch:", round(ineqc$Gini*100,2), " Gini general:", round(ineq$Gini*100,2), "\n")

  # Player clutch shooting indices (textbook section 3.1/3.2 formulas)
  vars <- c("P2p","P3p","FTp")
  Pboxc <- res$Pboxc; Pboxall <- res$Pbox
  Pboxc[vars]  <- lapply(Pboxc[vars],  function(x) replace(x, is.na(x), 0))
  Pboxall[vars] <- lapply(Pboxall[vars], function(x) replace(x, is.na(x), 0))

  P2p.T <- with(res$Tbox, 100*P2M/P2A); P3p.T <- with(res$Tbox, 100*P3M/P3A); FTp.T <- with(res$Tbox, 100*FTM/FTA)

  Pboxc <- Pboxc %>% mutate(AS = P2A+P3A+FTA) %>%
    mutate(SP = ((P2p-P2p.T)*P2A + (P3p-P3p.T)*P3A + (FTp-FTp.T)*FTA)/AS) %>%
    filter(AS >= AS_min)
  Pboxall2 <- Pboxall %>% mutate(AS = P2A+P3A+FTA) %>%
    mutate(SP = ((P2p-P2p.T)*P2A + (P3p-P3p.T)*P3A + (FTp-FTp.T)*FTA)/AS)

  plyrs <- Pboxc$player
  cindex <- Pboxc %>% filter(player %in% plyrs) %>% select(player, MIN, AS, SP) %>% rename_with(~paste0(.,"c"), c(MIN,AS,SP))
  gen <- Pboxall2 %>% filter(player %in% plyrs) %>% select(player, MIN, AS, SP)
  cindex <- left_join(cindex, gen, by="player")
  cindex <- cindex %>% mutate(Diff = SPc - SP,
                               Prc = 100*((ASc/AS)/(MINc/MIN)-1),
                               MINcp = 100*MINc/res$Tboxc$MIN)
  cindex <- cindex %>% mutate(across(c(SPc,SP,Diff,Prc,MINcp), ~round(.,1)))
  print(cindex)
  write.csv(cindex, file.path(out_dir, paste0("module3_", tolower(Team), "_clutch_index.csv")), row.names = FALSE)

  if (nrow(cindex) >= 2) {
    Xp <- cindex %>% select(player, MINcp, SPc, Diff, Prc)
    labs <- c("Clutch shooting performance (SPc)","Difference SPc-SP","Propensity to shoot","Clutch minutes played (%)")
    p <- bubbleplot(Xp, id="player", x="SPc", y="Diff", col="Prc", size="MINcp", mx=0, my=0, mcol=0, text.size=4, labels=labs) + ggplot2::theme_minimal()
    ggplot2::ggsave(file.path(out_dir, paste0("module3_", tolower(Team), "_bubbleplot.png")), p, width=8, height=6, dpi=150)
  }

  # Save team-level clutch vs general four-factors + pace/rating numbers as CSV
  write.csv(FF, file.path(out_dir, paste0("module3_", tolower(Team), "_pace_ratings.csv")), row.names = FALSE)
}

cat("\nDONE MODULE 3 GRAD COMPUTATION\n")
