# Lab 7: Finding Groups, Clustering Players and Teams

## Before you start

Pull up your own R session with `BasketballAnalyzeR` loaded. I want
you working the real numbers with me, not just reading them off a
slide. Everything in this lab uses the real `Pbox`, `Tbox`, and
`Obox` datasets, the same 2017-18 season behind today's lecture.

```r
library(BasketballAnalyzeR)
library(dplyr)
data(Pbox)
data(Tbox)
data(Obox)
```

## Part 1: Build the real player dataset and pick k yourself

```r
sel <- Pbox$MIN >= 1500
Xp <- with(Pbox, data.frame(PTS, P3M, REB = OREB + DREB, AST, TOV, STL, BLK, PF))
Xp <- subset(Xp, sel)
IDp <- Pbox$Player[sel]

hclu_scan <- hclustering(Xp, labels = IDp, nclumax = 10)
plot(hclu_scan)
```

**Reflection question 1.** Look at the real variance-explained curve
you just plotted. Where does the curve's slope flatten out the most?
Does your own read of "the right number of clusters" match the k=7
this module used, or would you have picked a different k from the
same real chart? There is no single correct answer here; defend
whatever k you pick using the real curve.

## Part 2: Build the real hierarchical clustering and read the dendrogram

```r
hclu <- hclustering(Xp, labels = IDp, k = 7)
plot(hclu, colored.labels = TRUE, colored.branches = TRUE, rect = TRUE, cex.labels = 0.6)
print(hclu$Profiles)
```

**Reflection question 2.** Pick one real cluster from the dendrogram
that contains at least one player you recognize. Using
`hclu$Profiles`, write one sentence describing that cluster's real
statistical identity (high scoring, high rebounding, low turnovers,
and so on), the same way this module described Cluster 6 as
"versatile do-everything forwards."

## Part 3: Compare real hierarchical clustering to real k-means

```r
kclu <- kclustering(Xp, labels = IDp, k = 7, nruns = 25)
agree_tab <- table(Hierarchical = hclu$Subjects$Cluster, Kmeans = kclu$Subjects$Cluster)
print(agree_tab)
```

**Reflection question 3.** This module found that about 67.8% of
real players land in the same modal group under both clustering
methods, with the strongest agreement in the most statistically
distinctive clusters (rim protectors, limited-role bench players) and
the weakest agreement among perimeter shooters. Look at your own real
cross-tabulation. Does that same pattern hold in your output? Name one
real player you would expect to be a "boundary case," likely to move
between clusters depending on the method, and explain why using their
real box score profile.

## Part 4: Build the real 2D similarity map

```r
mds <- MDSmap(Xp)
plot(mds, labels = IDp, z.var = "PTS", level.plot = FALSE)
cat("Real MDS stress:", round(mds$stress, 2), "\n")
```

**Reflection question 4.** A stress index under 10% is generally
considered a strong 2D fit, and this module's real map came out to
13.9%. What does a stress index actually measure, in your own words,
and what real basketball information might get lost or distorted when
an eight-variable player profile gets flattened down to a 2D picture?

## Part 5: Cluster real teams by their Four Factors identity

```r
FF <- fourfactors(Tbox, Obox)
Xt <- with(FF, data.frame(
  ORtg = ORtg, DRtg = DRtg, eFGO = F1.Off, eFGD = F1.Def,
  TOVO = F2.Off, TOVD = F2.Def, ORBrate = F3.Off, DRBrate = F3.Def,
  FTrO = F4.Off, FTrD = F4.Def
))
IDt <- Tbox$Team
hclu_t <- hclustering(Xt, labels = IDt, k = 5)
team_subj <- hclu_t$Subjects
team_subj$W <- Tbox$W[match(team_subj$Label, Tbox$Team)]
team_subj %>% group_by(Cluster) %>%
  summarise(teams = n(), mean_wins = round(mean(W), 1), min_wins = min(W), max_wins = max(W))
```

**Reflection question 5.** This module found two real team clusters
(Cluster 1 and Cluster 4) with almost identical mean win totals in
the mid-20s but very different real Four Factors profiles. Find these
two clusters in your own output. Pick one real team from each and
explain, using their real Four Factors numbers, why they lost a
similar number of games for different statistical reasons.

## Submit

Turn in your R script (or a saved `.R` file) showing all five parts
run with real output, plus written answers to all five reflection
questions.
