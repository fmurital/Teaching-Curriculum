# Module 3 Class Session Plan (3 Hours)

This session plan follows the course's standard three-segment structure, with a 10-minute break after each of the first two segments. The slide deck itself is organized into six labeled segments (A through F); segments A and B run together before the first break, and segments E and F run together before the second, since each pair runs shorter than a full hour on its own.

## Segment 1: The Grammar Itself (about 70 minutes)

- Concept Introduction (10 min): Introduce Wilkinson's grammar of graphics at a high level, then the three required pieces (data, aesthetic mapping, geom) using the grammar-layers diagram slide.
- Demonstration (10 min): Live-run the single mpg example together, the one deliberate exception to our one-dataset rule, and walk through what each of the three lines of code did.
- Concept Introduction (5 min): Explain why we are moving straight back to housing data for everything else in this module.
- Demonstration (15 min): Live-run the first housing scatterplot (`gr_liv_area` versus `sale_price`), first as ggplot2's own rough default, then finished with `labs()`, a dollar-formatted y-axis, and a single intentional color.
- Video (3 min): Play the grammar-of-graphics video from `Videos/Module_03_Videos.md`.
- Discussion (10 min): Ask the class to name, from the finished scatterplot alone, what changed versus the rough version, before revealing the four-item list on the next slide.
- Reflection (5 min): One-minute written response: in your own words, what do the three required pieces of the grammar actually do?

## Break (10 minutes)

## Segment 2: Mapping Aesthetics (about 50 minutes)

- Concept Introduction (10 min): Introduce aesthetics beyond x and y, using the real `bldg_type` count check (`table(housing$bldg_type)`) to confirm there are five real categories to work with.
- Demonstration (15 min): Live-run the color, size, and shape mapping examples in sequence, on the same base scatterplot each time.
- Concept Introduction (10 min): The mapped-versus-set distinction, using the side-by-side mapped-color-versus-set-color slide.
- Discussion (10 min): Ask students which aesthetic (color, size, or shape) they would choose for a new variable you name on the spot, and have them justify it against the variable's real type.
- Reflection (5 min): Write one sentence: describe, in your own words, the difference between mapping an aesthetic to data and setting it to a fixed value.

## Break (10 minutes)

## Segment 3: Bars, Themes, and Scales (about 60 minutes)

- Demonstration (10 min): Live-run the rough default bar chart of counts by `bldg_type`.
- Discussion (10 min): Ask the class to name as many of the four real problems with the rough bar chart as they can before revealing the slide's own list.
- Demonstration (10 min): Live-run the finished bar chart, pointing out the comma-formatted single-family count (2,002) as a direct callback to this course's standing formatting rule.
- Video (3 min): Play the aesthetics-mapping video from `Videos/Module_03_Videos.md`.
- Concept Introduction (10 min): Themes as an independent grammar layer, using the four-theme comparison slide.
- Concept Introduction (7 min): Scales as an independent grammar layer, using the manual-color-scale example.
- Interactive Activity (10 min): In-Class VizLab. In pairs, students build one scatterplot of `gr_liv_area` versus `sale_price`, map a third real column of their choice onto color or size, and write the one `labs()` call that would finish it, then share out as a class.
- Wrap-Up (5 min): Preview Module 4 (communicating amounts with bar and dot charts), and confirm Lab 3, the practice questions, and the Module 3 quiz are due before then.

## Materials Needed

Projector or screen for the live R demonstrations, and students' own laptops with R, RStudio, and `ames_housing.csv` already set up from Modules 1 and 2.
