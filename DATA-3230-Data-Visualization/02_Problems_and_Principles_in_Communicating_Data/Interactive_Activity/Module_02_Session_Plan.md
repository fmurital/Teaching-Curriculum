# Module 2 Class Session Plan (3 Hours)

This session plan follows the course's standard three-segment structure, with a 10-minute break after each of the first two segments. The slide deck itself is organized into four labeled segments (A through D); segments A and B run together before the first break below, since together they run shorter than a full hour.

## Segment 1: Why This Matters, and the Research Process (about 70 minutes)

- Concept Introduction (10 min): Open with the pie chart versus bar chart comparison, both built from the real neighborhood sale counts. Let the pie chart sit on screen for a moment before asking any questions.
- Discussion (10 min): Ask the class, from the pie chart alone, which neighborhood had the most sales. Let them struggle, then reveal the bar chart and ask how long it took to answer the same question that way.
- Video (3 min): Play the pie-chart video from Videos/Module_02_Videos.md.
- Concept Introduction (15 min): The five-step research process (question, collection, organization, analysis, communication), using our own housing data as the running example at each step.
- Demonstration (10 min): Live-run the tidy-data example (`head()` of four real housing columns) together as a class.
- Video (3 min): Play the data-visualization-best-practices video from Videos/Module_02_Videos.md.
- Application Exercise (10 min): In pairs, students write one real research question each about the housing data, following the research-process framework, without yet answering it.
- Reflection (5 min): One-minute written response: which of the five research-process steps do you personally find hardest, and why?

## Break (10 minutes)

## Segment 2: A Model of Communication (about 40 minutes)

- Concept Introduction (10 min): The communication model (source, message, transmitter, noise, receiver), using the restaurant-planning example before showing the diagram slide.
- Discussion (10 min): Ask students to each name a time they experienced noise disrupting a message, verbal or visual, and connect it back to the model.
- Concept Introduction (15 min): The three types of communication problems (technical, semantic, effectiveness), using the real neighborhood-code example for the semantic problem and the real "so what" discussion for the effectiveness problem.
- Reflection (5 min): Write one sentence: which of the three communication problems do you think is most common in charts you see day to day, and why?

## Break (10 minutes)

## Segment 3: Six Principles, Applied (about 70 minutes)

- Concept Introduction (10 min): Walk through all six principles at a high level before going deep on any one of them.
- Demonstration (10 min): Live-run the year-by-year housing check (Principle 2), showing that the five sale years do not meaningfully change average price before combining them into one chart.
- Concept Introduction (10 min): Principle 3, variable types, using the real `class()` output for `sale_price`, `overall_qual`, and `neighborhood`.
- Demonstration (15 min): Live-render the average-sale-price-by-neighborhood chart twice, first badly, then well (Principle 4), asking students to call out problems with the bad version before revealing the good one.
- Concept Introduction (10 min): Principles 5 and 6 (medium and channel, checking results), at a conceptual level.
- Interactive Activity (10 min): In-Class VizLab. In pairs, students pick one of the two "bad" charts shown today and identify which principle it violates and what they would change, using the real housing data, then share out as a class.
- Wrap-Up (5 min): Preview Module 3 (ggplot2's own grammar), and confirm Lab 2, the practice questions, and the Module 2 quiz are due before then.

## Materials Needed

Projector or screen for the live R demonstrations, and students' own laptops with R, RStudio, and `ames_housing.csv` already set up from Module 1.
