# Module 7 Session Plan: Finding Groups, Clustering Players and Teams

**Format:** one 3-hour class session, three segments, two 10-minute breaks.

## Segment 1 (50 minutes): Why clustering, and how many groups

- I'll recap where Module 6 left off (event density and shooting
  under pressure) and introduce today's shift: from a single shot to
  the shape of the whole league at once.
- I'll introduce clustering in plain language, using a simple
  non-basketball example (grouping types of restaurants by price and
  distance) before we touch any code.
- Live coding cue: we'll open RStudio together and build the real
  183-player dataset (MIN >= 1500), then run `hclustering()` with
  `k=NULL` to get the real variance-explained curve.
- We'll look at the real curve together as a class and talk through
  why I chose k=7, then take a class vote on whether anyone would
  have picked differently and why.
- Quick pair discussion: what real basketball reason might explain
  why standardizing every column before clustering matters so much.

**Break (10 minutes).**

## Segment 2 (50 minutes): Building and reading the real player clusters

- Short lecture: I'll introduce the dendrogram and explain what a
  branch merging early versus late actually tells you about two
  players' similarity.
- Live coding cue: we'll build the real k=7 hierarchical clustering
  together and look at the real dendrogram and cluster profiles.
- Small groups (3-4 students): each group gets one real cluster and
  writes a one-sentence identity for it, then reports back to the
  class (which cluster had the widest CHI, which had the narrowest).
- Live coding cue: we'll build the real k-means clustering on the
  same data and look at the real cross-tabulation against the
  hierarchical result together, discussing the real 67.8% agreement
  figure and why the disagreement concentrates in perimeter shooters.

**Break (10 minutes).**

## Segment 3 (50 minutes): The real 2D map and clustering real teams

- Live coding cue: we'll build the real MDS similarity map together
  and find a few recognizable players on it as a class.
- I'll introduce Four Factors team clustering, reusing the
  `fourfactors()` function from Module 2, and explain why I clustered
  teams instead of players this time.
- Live coding cue: we'll build the real five-cluster team result
  together and look at the real mean-wins-by-cluster table.
- Small groups: each group takes the two real "mid-20s win total"
  clusters (Cluster 1 and Cluster 4) and debates, using the real Four
  Factors numbers, why two teams can lose a similar number of games
  for different statistical reasons.
- I'll close by connecting this to real player performance analysis
  and game analysis, assign Lab 7, the practice questions, and the
  Module 7 quiz, and preview Module 8 (modeling relationships:
  regression and surface dynamics).
