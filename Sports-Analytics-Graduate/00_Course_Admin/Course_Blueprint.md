# Sports Analytics Course Blueprint -- Graduate (Advanced Basketball Data Science Track)

This file is the current, authoritative module map for the graduate Sports Analytics course. It replaces the earlier draft that pointed to a separate project document; that draft predated the decision to build this course around a specific textbook and no longer reflects the actual plan.

Primary source: Zuccolotto, P., Manisera, M., & Sandri, M. (2026). *Advanced Basketball Data Science: With Applications in R*. CRC Press / Chapman & Hall (Data Science Series). ISBN 978-1-032-50217-5 (hbk), 978-1-032-50221-2 (pbk), 978-1-003-39744-1 (ebk). DOI 10.1201/9781003397441.

This course is graduate credit level and is not restricted to the textbook. Where a real, current, verifiable journal article adds something the textbook does not, it is worked into the relevant module, called out by name on the slide, and cited in that module's speaker notes and References file. This matters more here than in the undergraduate course, since graduate students may take on larger independent projects.

## PhD track: injury detection

Running through the course, wherever a chapter's technique genuinely supports it, each module notes how that technique could apply to injury-risk indicators. The goal by the end of the course is for a PhD-level student to be able to identify a real indicator of injury risk in data and connect it to a model discussed in the textbook or in the course's own signature research. Module 10 is dedicated to this thread and is where students who want to do a large independent project go further, using the instructor's own published work:

- Muritala, Brown & Haller (2026). *Research in Sports Medicine* -- MLB pitcher reinjury.
- West et al. (2026). *Journal of Strength and Conditioning Research (JSCR)* -- statistical process control for sport-science data quality.
- Kanwal et al. (2025) -- critique of the Acute:Chronic Workload Ratio (ACWR).

Full citations live in `Curriculum_Resources/Research_Papers/Literature_Review.md` (mirrors the undergraduate course's file; extend it here rather than duplicating a separate list, unless the graduate module needs graduate-specific framing).

## Module map

1. `01_Getting_Started_with_Advanced_Basketball_Analytics` -- Ch. 1, Getting started. Course orientation at graduate level: what "advanced" adds over the undergraduate course, the R packages and tooling used throughout, and a first look at where injury-detection questions will come back later in the course.
2. `02_Beyond_Individual_Skills_Lineups_and_Combinations` -- Ch. 2, Beyond individual skills: lineups and player combinations (e.g. the Splash Brothers case study in the text).
3. `03_Clutch_Performance_and_Situational_Splits` -- Ch. 3, Clutch splits (Celtics, Warriors case studies in the text).
4. `04_Season_Segments_and_Final_Rankings` -- Ch. 4, Season segments and final rankings.
5. `05_Spatial_Dynamics_and_Tracking_Data` -- Ch. 5, Spatial dynamics: animated plots, Voronoi diagrams, convex hulls, gravity/distraction metrics.
6. `06_Athletic_Motion_and_Pose_Estimation` -- Ch. 6, Athletic motion kinematics: computer vision, deep learning, CNNs, pose estimation (e.g. MoveNet), crossover and shot mechanics. First natural tie-in point for movement-based injury-risk indicators.
7. `07_Ball_Trajectories_and_Object_Detection` -- Ch. 7, Ball trajectories: YOLO object detection, ball-tracking data, and using it to improve shooting.
8. `08_Performance_Maps_and_Court_Segmentation` -- Ch. 8, Performance maps via court segmentation: sector maps, shot charts, CART.
9. `09_Machine_Learning_Models_for_Scoring_Probability` -- Ch. 9, Scoring probability via machine learning: Random Forests, Oblique Random Forests, Extremely Randomized Trees.
10. `10_Injury_Risk_Signature_Module_PhD_Track` -- instructor's own signature research (see PhD track above), the module where students identify real injury-risk indicators in data and connect them to a specific model.

## Standing rules

This course follows every standing rule in `Sports-Analytics-Undergraduate/00_Course_Admin/Module_Build_Playbook.md` (voice, video/visual engagement, no on-slide timing, the recurring Upcoming/announcements slide, live-coding cues, notes-based discussion points, no slide-count ceiling, real-data/real-citation grounding, no em dashes, no AI-process captions). Section 8 of that playbook covers what is specific to the graduate track. Read the playbook before building any graduate module; do not treat this blueprint as a substitute for it.

## Repo split

Same pattern as the undergraduate course: the public repo (`Teaching-Curriculum`) carries everything students see. The private repo (`Teaching-Curriculum-Private`) carries `Instructor_Notes/` and `Solutions/` for each module, plus the shared `pptx_template/` and this course's own admin files. The ten module folders in the public repo currently also contain empty `Instructor_Notes/`/`Solutions/` placeholders left over from the original skeleton; those belong only in the private repo and can be deleted from the public repo whenever convenient -- they hold no content, so there is nothing to lose by removing them.

## Textbook access

The full textbook PDF is kept in the private repo only (`00_Course_Admin/Textbook/`), since its redistribution rights in the public repo have not been confirmed. The public repo's `00_Course_Admin/` carries the citation above and a note that enrolled students should access the text directly (library reserve, purchase, or however the department normally provides it).
