# Module 3 Quiz (Autograded)

This quiz is short and is meant to confirm you did the reading and the lab, not to be a difficult assessment. It is entered manually into D2L as a graded quiz; the format below gives the exact question text, type, and correct answer for each item so it can be entered directly. Every question is multiple choice with exactly one correct option, so the entire quiz auto-grades with no instructor review.

## Question 1 (Multiple Choice, 1 point)

According to the grammar of graphics introduced this module, which three pieces does every ggplot2 chart require?

A. A title, a legend, and a caption
B. Data, an aesthetic mapping, and a geom
C. A theme, a scale, and a facet
D. A dataset, a color palette, and an axis range

## Question 2 (Multiple Choice, 1 point)

In `ggplot(housing, aes(x = gr_liv_area, y = sale_price, color = bldg_type)) + geom_point()`, what job is `color = bldg_type` doing?

A. It sets every point to the same fixed color
B. It maps the real `bldg_type` column onto the color aesthetic, so color varies by row
C. It deletes the `bldg_type` column from the chart
D. It has no effect unless a legend is also added manually

## Question 3 (Multiple Choice, 1 point)

In `geom_point(color = "#27496D")`, with no `color` mapping inside `aes()`, what does `color = "#27496D"` do?

A. Maps color to a real column named "#27496D"
B. Sets every point to the same fixed navy color, regardless of the data
C. Produces an error, since colors must be set inside aes()
D. Only applies to the first point drawn

## Question 4 (Multiple Choice, 1 point)

A size aesthetic is generally the best fit for which kind of variable?

A. A nominal variable with several unordered categories
B. A quantitative or ordinal variable, where "bigger" has a real meaning
C. Any variable, regardless of type
D. Only a variable already mapped to color

## Question 5 (Multiple Choice, 1 point)

This module's rough default bar chart showed the single-family building count as a bare `2002`. According to this course's standing formatting rule, what must the finished version do?

A. Round it to the nearest thousand
B. Leave it exactly as printed
C. Format it with a thousands separator, as in 2,002
D. Convert it to a percentage instead

## Question 6 (Multiple Choice, 1 point)

What does switching a chart's theme from `theme_gray()` to `theme_minimal()` change?

A. The underlying data values
B. The aesthetic mappings (which columns map to which visual properties)
C. Only the chart's background, grid lines, fonts, and borders, not the data itself
D. The geom being used to represent each observation

## Question 7 (Multiple Choice, 1 point)

What did `scale_fill_manual()` do in this module's bar chart example?

A. Automatically chose the best possible colors for the data
B. Replaced ggplot2's default color palette with a set of colors chosen on purpose
C. Removed color from the chart entirely
D. Converted a continuous variable into a categorical one

## Question 8 (Multiple Choice, 1 point)

This module opened with one chart built on `mpg` rather than our own housing data. Why?

A. Because housing data cannot be plotted with ggplot2
B. To show the simplest possible version of the grammar with no new column names to learn, before returning to housing data for the rest of the module
C. Because `mpg` has more variables than the housing data
D. There was no real reason; it was simply reused from an old slide
