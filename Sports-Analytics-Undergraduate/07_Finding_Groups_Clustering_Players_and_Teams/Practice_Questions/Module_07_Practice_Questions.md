# Module 7 Practice Questions (ungraded, multiple choice)

**Q1.** Both `hclustering()` and `kclustering()` standardize every
column before grouping players. Why does this matter?

A. It doesn't matter; standardizing is only cosmetic
B. Without it, a variable measured in larger raw numbers (like
   points) would dominate the grouping over a variable measured in
   smaller raw numbers (like blocks), for no basketball reason
C. Standardizing changes which players are real NBA players
D. Standardizing removes the need for real data entirely

**Q2.** This module used the real variance-explained curve to help
choose k=7 for player clustering. What was the key real evidence for
that choice?

A. Seven is always the correct number of clusters in any dataset
B. The gain in variance explained from k=6 to k=7 was the smallest
   gain up to that point, a real sign of diminishing returns
C. The textbook requires exactly seven clusters
D. There was no real evidence; k=7 was picked at random

**Q3.** Real Cluster 6 (Kevin Durant, Draymond Green, Giannis
Antetokounmpo, Anthony Davis) had the highest real CHI (cluster
heterogeneity index) of all seven player clusters, at 0.95. What does
a high CHI mean?

A. The players in that cluster are statistically identical to each other
B. The players in that cluster, while grouped together, still vary
   quite a bit among themselves
C. CHI measures how many games a cluster's players won
D. CHI cannot be computed for real data

**Q4.** Real hierarchical clustering and real k-means clustering
agreed on a modal cluster for about 67.8% of real players overall, but
agreement was much higher for Cluster 3 (rim-protecting bigs, about
90%) and much lower for Cluster 5 (perimeter shooters, about 51%).
What is the most likely real explanation this module offers?

A. K-means and hierarchical clustering never agree on anything
B. Statistically distinctive groups agree more across methods, while
   players in a fuzzier, more average middle ground are harder to
   assign consistently
C. Rim-protecting bigs do not really exist as a group
D. Agreement percentages are meaningless in cluster analysis

**Q5.** The real MDS map in this module had a stress index of 13.9%.
What does that number describe?

A. How many points a player scored on average
B. How much distortion is introduced by compressing the real,
   multi-variable data down into a 2D picture
C. The percentage of players correctly clustered
D. The number of real teams in the dataset

**Q6.** Real Cluster 1 and real Cluster 4 in the team clustering both
had a mean win total in the mid-20s, but this module described them
as losing games for different real reasons. What distinguished them?

A. Nothing; they are statistically identical clusters
B. Cluster 1 was weak on both ends of the floor, while Cluster 4 was
   specifically, severely limited on offense
C. Cluster 4 had a better real record than Cluster 1
D. Win totals alone always explain why a team is losing

**Q7.** Real Cluster 3 in the team clustering (elite, efficient
shooting offense) included the 2017-18 Houston Rockets and Golden
State Warriors, the two teams that met in that year's real Western
Conference Finals. What does this suggest about clustering teams by
their Four Factors profile rather than only by win total?

A. Nothing; win total already tells you everything about a team
B. It can group teams that share a real underlying statistical
   identity even when you started from box score inputs, not final
   records
C. Clustering always predicts who reaches the conference finals
D. The Four Factors cannot be computed for real teams

**Q8.** Stephen Curry, one of the most efficient shooters in the
2017-18 real season, landed in Cluster 5 (perimeter shooting wings)
rather than Cluster 1 (primary ball-handling engines) in this
module's real hierarchical clustering. What does this module say is
the honest way to read that placement?

A. It is a data error; Curry should always be grouped with the
   highest scorers
B. A standardized, team-relative profile can place an elite shooter
   alongside lower-usage players when the clustering variables
   (points, assists, turnovers, and so on) happen to be closer to
   that group's average
C. Curry does not appear in the real dataset
D. Clustering results are always identical to popular opinion about a player
