# Module 4 Practice Questions (ungraded)

1. `shotchart()` requires y-coordinates that are zero or negative, with
   the origin at the center of the court. Why does a shot chart need
   this specific coordinate convention instead of just using raw
   full-court coordinates?

A. Raw full-court coordinates cannot be stored as numbers
B. `shotchart()`'s internal court-drawing and filtering logic only plots shots with y <= 0, matching a half-court view with the origin at center court; raw full-court coordinates would place half of all shots at positive y values, which get silently dropped
C. Negative coordinates are required by R for any numeric column
D. Full-court coordinates only work for three-point attempts

2. This module defines four real distance zones from each shot's
   `shot_distance` value. Which zone is defined purely by a lower bound,
   with no upper limit?

A. Rim (0-4 feet)
B. Short/Mid (5-14 feet)
C. Long Two (15-21 feet)
D. Three (22 feet or more, with no upper bound)

3. In the real 2018 playoff data, the long two converted at 41.7% (lower
   than the rim's 64.4%) and, when it goes in, is worth the same two
   points as a rim shot, with none of a three's extra point. What does
   this combination make the long two, in terms of points per shot?

A. The most valuable zone on the floor
B. The worst points-per-shot zone on the floor, since it has both a lower conversion rate than the rim and no value premium like a three
C. Equal in value to the three-point zone
D. Impossible to evaluate without knowing who took the shot

4. What percentage of the Houston Rockets' real 2018 playoff shots (in
   this module's sample) came from the rim or from three, combined, and
   how does that compare to Cleveland's combined rim-plus-three share of
   about 66.0%?

A. About 82.2% for Houston, clearly higher than Cleveland's 66.0%
B. About 47.6% for Houston, close to Cleveland's 66.0%
C. About 66.0% for Houston, identical to Cleveland's share
D. About 34.4% for Houston, clearly lower than Cleveland's 66.0%

5. "Moreyball" is a real shot-selection philosophy associated with the
   Houston Rockets under general manager Daryl Morey. In terms of this
   module's four zones, what does it mean?

A. Taking shots evenly across all four zones to stay unpredictable
B. Concentrating shot attempts at the rim and from three, the two zones with the best real points-per-shot value in this data, while avoiding the long two whenever a better shot is available
C. Prioritizing the long two because it has the highest field goal percentage
D. Taking as many short/mid range shots as possible

6. LeBron James shot 87.5% at the rim in this module's real sample, well
   above the leaguewide rim average of 64.4%. Which of the following is
   a reasonable real basketball factor (not just "he is a good player")
   that could help explain a gap that large?

A. The leaguewide rim average of 64.4% must be a data entry error
B. A size, strength, or athleticism advantage that lets a player finish through contact at the rim more often than an average player, combined with the small sample of 16 rim attempts making the percentage more volatile than a full-season number would be
C. LeBron never missed a shot at the rim in his career
D. Rim shots are worth more points than three-pointers, which explains the higher percentage

7. In this real data, the long two's field goal percentage (41.7%) was
   actually higher than three-point shooting's percentage (37.5%). Why
   does three-point shooting still produce more points per shot overall
   (1.13 versus 0.83 for the long two)?

A. Points per shot ignores field goal percentage entirely
B. A make from three is worth one additional point, so even with a lower conversion rate, three-point shooting produces more expected points per shot once that extra point is factored in
C. The long two is always worth three points in this dataset
D. Points per shot and field goal percentage always move in the same direction, so this cannot be correct

8. Why is it important to check the number of attempts behind a shot
   chart's visual cluster before drawing a conclusion from it?

A. Attempt count is irrelevant; only the shape of the cluster matters
B. A visually striking cluster built from a small number of attempts (for example, ten makes out of twelve total attempts) tells a far less reliable story than the same visual cluster built from hundreds of real attempts across a full season
C. Shot charts always use the exact same number of attempts, so checking is unnecessary
D. Attempt count only matters for three-point shots, not rim shots
