# Module 7 Quiz (Microsoft Forms, 8 questions, multiple choice)

Paste each question into forms.office.com as its own Choice question; mark the correct option using Forms' own settings.

**Q1.** `hclustering()` and `kclustering()` both standardize every
column before grouping players. Why?

A. Standardizing is only cosmetic and does not affect the result
B. Without it, a variable measured in larger raw numbers (like
   points) would dominate the grouping over a variable measured in
   smaller raw numbers (like blocks)
C. Standardizing changes which players are real NBA players
D. Standardizing removes the need for real data

**Q2.** This module chose k=7 for the real player clustering. What
was the real evidence behind that choice?

A. Seven is always correct for any clustering problem
B. The real gain in variance explained from k=6 to k=7 was the
   smallest gain up to that point in the curve
C. The R package requires k=7 by default
D. No real evidence was used; it was an arbitrary pick

**Q3.** In this module's real player clustering, what does a high CHI
(cluster heterogeneity index), like Cluster 6's 0.95, mean?

A. The players in that cluster are statistically identical
B. The players in that cluster, while grouped together, still vary
   quite a bit among themselves
C. CHI measures real win totals
D. CHI cannot be computed from real data

**Q4.** Real hierarchical clustering and real k-means clustering
agreed on a modal group for about 67.8% of real players overall. Where
was that real agreement strongest and weakest?

A. Strongest for perimeter shooters, weakest for rim protectors
B. Strongest for the most statistically distinctive groups (like rim
   protectors), weakest for players in a fuzzier statistical middle
   (like perimeter shooters)
C. Agreement was identical across every cluster
D. Agreement cannot be measured between two clustering methods

**Q5.** This module's real 2D similarity map (MDS) had a stress index
of 13.9%. What does that number represent?

A. The percentage of players who scored more than 20 points per game
B. How much distortion is introduced when compressing multi-variable
   real data down into a 2D picture
C. The number of real clusters in the dataset
D. A player's real shooting percentage

**Q6.** Real team Cluster 1 and real team Cluster 4 both had a mean
win total in the mid-20s in this module. What distinguished them?

A. They were statistically identical clusters
B. Cluster 1 was weak on both ends of the floor, while Cluster 4 was
   specifically, severely limited on offense
C. Cluster 4 actually won more real games than Cluster 1
D. Nothing distinguishes two clusters with similar win totals

**Q7.** Real Cluster 3 in the team clustering (elite, efficient
shooting offense) included the 2017-18 Houston Rockets and Golden
State Warriors. What does this suggest about clustering by Four
Factors profile rather than by win total alone?

A. Win total alone already explains everything about a team's identity
B. It can group teams that share a real underlying statistical
   identity, built from box score inputs rather than final records
C. Clustering always predicts a conference finals matchup
D. The Four Factors do not apply to real teams

**Q8.** Stephen Curry landed in Cluster 5 (perimeter shooting wings)
rather than Cluster 1 (primary ball-handling engines) in this
module's real clustering. What is the honest way to read that?

A. It is a data error; elite shooters should always be grouped with
   the highest scorers
B. A standardized, team-relative profile can place an elite shooter
   alongside lower-usage players when the clustering variables happen
   to sit closer to that group's average
C. Curry is not included in the real dataset used
D. Clustering results always match popular opinion about a player
