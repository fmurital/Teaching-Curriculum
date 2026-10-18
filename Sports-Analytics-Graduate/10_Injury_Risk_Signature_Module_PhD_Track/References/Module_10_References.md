# Module 10 References

## Required reading before class

- Brown, A., Muritala, F., & Haller, A. (2026). A quality monitoring approach to evaluating reinjury likelihood to Major League Baseball pitchers. *Research in Sports Medicine*. https://doi.org/10.1080/15438627.2026.2632610
- Tention, A., Muritala, F., Frankel, M., & Brown, A. R. (2026). Early identification of subsequent injury risk among National Basketball Association players using a quality monitoring technique. *Basketball Studies*, 1, 100011. https://doi.org/10.1016/j.basket.2026.100011

## Primary sources cited today

- Brown, A., Muritala, F., & Haller, A. (2026). A quality monitoring approach to evaluating reinjury likelihood to Major League Baseball pitchers. *Research in Sports Medicine*. https://doi.org/10.1080/15438627.2026.2632610. This module's methodological starting point: the Cp/CUSUM hybrid control chart, real Wainwright (2023) and Alzolay (2021) case studies, and real sensitivity, specificity, and lead-time results across the 2021-2023 MLB seasons.
- Tention, A., Muritala, F., Frankel, M., & Brown, A. R. (2026). Early identification of subsequent injury risk among National Basketball Association players using a quality monitoring technique. *Basketball Studies*, 1, 100011. https://doi.org/10.1016/j.basket.2026.100011. This module's primary basketball-specific source: the individualized, credibility-weighted baseline, the EWMA-CUSUM hybrid statistic, and the real training/testing results across PIE, Usage Rate, BPM, and Net Rating on the 2021-2022 through 2025-2026 NBA seasons.
- Makhni, E. C., Lee, R. W., Morrow, Z. S., Gualtieri, A. P., Gorroochurn, P., & Ahmad, C. S. (2014). Performance, return to competition, and reinjury after Tommy John surgery in Major League Baseball pitchers: A review of 147 cases. *The American Journal of Sports Medicine*, 42(6), 1323-1332. https://doi.org/10.1177/0363546514528864. Cited in Brown, Muritala & Haller (2026) for the real 57% second-IL-stint rate that motivates the whole module.
- Piergiovanni, A. J., & Ryoo, M. S. (2019). Early detection of injuries in MLB pitchers from video. 2019 IEEE/CVF Conference on Computer Vision and Pattern Recognition Workshops (CVPRW), 2431-2438. https://doi.org/10.1109/CVPRW.2019.00298. Cited for the real data-volume limitation of video-based deep learning approaches that motivates a control-charting alternative.
- Montgomery, D. C. (2019). *Introduction to statistical quality control* (8th ed.). Wiley. Standard methodological reference for process capability and control charting, cited in both signature papers.
- Kanwal, S., Ahsan, M. T., Khan, R. N., & Khan, A. (2025). Load management and injury prevention in elite athletes: A narrative review. *Premier Journal of Science*, 11, 100088. Cited for the documented statistical weaknesses of the Acute:Chronic Workload Ratio as the dominant competing framework in this space, covered in Module 10 of the undergraduate course.
- Davis, J., Bransen, L., Devos, L., Jaspers, A., Meert, W., Robberechts, P., Van Haaren, J., & Van Roy, M. (2024). Methodology and evaluation in sports analytics: Challenges, approaches, and lessons learned. *Machine Learning*. https://doi.org/10.1007/s10994-024-06585-0. Cited for this module's emphasis on reporting a method's real, honest limitations rather than only its successes.
- Gilani, S. (2023). hoopR: Access men's basketball play by play data (version 2.1.0) [R package]. https://doi.org/10.32614/CRAN.package.hoopR. Real data package used in Tention et al. (2026) for all NBA performance and injury data.
- shufinskiy (2026). nba_data: NBA play-by-play and shot detail data [Data repository]. GitHub. https://github.com/shufinskiy/nba_data. Real 2025-26 regular season shot log used for this module's own live Wembanyama illustration.

## Real-world grounding for today's live illustration

- Associated Press via multiple outlets (2025, November 17). Victor Wembanyama had an MRI that confirmed a left calf strain, Spurs say. Real wire report confirming the injury date, diagnosis, and expected absence used in this module's own computed example.
- Eurohoops (2025, November 18). Victor Wembanyama to miss several weeks due to calf strain. https://www.eurohoops.net/en/nba-news/1895901/victor-wembanyama-out-with-injury-san-antonio-spurs-nba. Confirms the real November 14, 2025 injury game and multi-week absence.
- CBS Sports / KRDO (2025, July 15). Victor Wembanyama says he is officially cleared to play again after blood clot. Confirms the real timeline of his prior-season blood clot and full clearance before the 2025-26 season began.

## Optional reading

Tention, Muritala, Frankel & Brown (2026), full supplementary material (referenced in the paper as available via its online DOI page), for students who want the full upper-extremity and core-injury breakdown not covered in today's main results.

All real numbers, tables, and the live chart in this module's slides, notes, and lab were either taken directly from the two real cited papers above (with page/table references in the Instructor Notes) or computed independently and reproducibly from the real `shotdetail_2025.csv` dataset using `Coding_Exercise/module10_injury_risk_monitoring.R`.
