# Module 02 Practice Questions (Ungraded)

1. A lineup split isolates play-by-play events to one specific five-player
   combination. How is that different from a team-level or player-level
   split?

a. It is not different; a lineup split and a team-level split produce identical results
b. It lets the same downstream analyses (box scores, networks, shot charts) be run for one specific five-player combination on the court together, rather than for an entire team or a single player across all lineups
c. A lineup split can only be computed for players who never share the floor
d. A lineup split replaces play-by-play data with season totals

2. With a 10-player roster and lineups of 5 players, how many possible
   combinations are there, and which real R function tells you which of
   those combinations actually played enough minutes to analyze?

a. 50 combinations, found with `fourfactors()`
b. 252 combinations, found with `lineups()` (or `parlineups()` for larger rosters)
c. 10 combinations, found with `assistnet()`
d. 1,024 combinations, found with `TOPboxes()`

3. In the real 2021-22 Golden State Warriors example, the
   Wiggins/Green/Poole/Looney/Curry lineup played 346.1 of the roughly
   480 available starting minutes, dwarfing every other combination.
   What does that imbalance tell you about how to interpret the other
   seven lineups on the list?

a. The other seven lineups are equally reliable samples and should be weighted the same as the starting group
b. The other seven lineups are situational variations with much smaller, noisier samples than the primary group, so any comparison across all eight should account for that difference in sample size
c. The imbalance means the other seven lineups never actually took the floor
d. It proves the starting lineup is the best five-player combination by definition

4. Across the eight real assist networks built for different Warriors
   lineups, what stayed constant and what changed from lineup to lineup?

a. Everything changed; no player's role was consistent across lineups
b. Stephen Curry's role as the network's hub stayed constant, while the specific secondary connections (who the ball moves to next) changed depending on which four teammates shared the floor
c. Nothing changed; every lineup produced an identical assist network
d. Draymond Green was the hub in every lineup, with Curry's role changing

5. Kevon Looney's finishing rate at the rim stayed high (71-79% made)
   across multiple different lineups. Which of the following is a
   basketball explanation for that consistency that has nothing to do
   with a specific lineup's shooting talent?

a. Looney's rim percentage is a statistical artifact with no real basketball cause
b. A screen-setting, offensive-rebounding role positioned near the rim that generates easy, high-percentage looks regardless of which four teammates are on the floor
c. Looney only played in lineups with Stephen Curry
d. Rim finishing rate cannot realistically stay consistent across different lineups

6. The Wiggins/Green/Poole/Porter Jr./Curry lineup had both the fastest
   Pace (about 2.24 possessions per minute) and the best Offensive
   Rating (about 124) of the eight real lineups, yet the
   Wiggins/Green/Poole/Looney/Thompson lineup had the worst Defensive
   Rating (opponents scored about 130 per 100 possessions). Why can't
   Offensive Rating alone tell you whether a lineup is good?

a. Offensive Rating only measures scoring efficiency; it says nothing about how many points a lineup allows, so a lineup can score efficiently and still be a net negative if its defense gives up more than it gains offensively
b. Offensive Rating and Defensive Rating always move together, so this result must be a data error
c. Offensive Rating already accounts for defense by design
d. Pace and Offensive Rating measure the exact same thing

7. Which of the following correctly explains how a lineup decision also
   doubles as a workload decision?

a. Lineup decisions have nothing to do with player workload
b. The minutes a lineup plays together are cumulative wear on those specific players, so a 346-minute starting lineup absorbs far more cumulative load than a bench combination that plays only a few minutes
c. Workload only applies to players who are already injured
d. Faster-paced lineups automatically reduce player workload

8. West et al. (2026), one of the real papers introduced in this
   course's track, addresses which part of the workload question raised
   by lineup decisions?

a. Whether referees call fouls differently for high-usage lineups
b. The statistical process control needed to trust the sport-science workload data teams collect, before that data can be used to flag an athlete at elevated risk
c. Ticket pricing for games featuring a team's most-used lineup
d. Fantasy basketball scoring for players in high-minute lineups
