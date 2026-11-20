# Module 3 Practice Questions

These are for your own practice and are not submitted or graded. Solutions are discussed in class.

1. According to the grammar of graphics introduced this module, which three pieces does every ggplot2 chart require?

A. A title, a legend, and a caption
B. Data, an aesthetic mapping, and a geom
C. A theme, a scale, and a facet
D. A dataset, a color palette, and an axis range

2. This module opened with one chart built on `mpg`, a dataset other than our own housing data. Why?

A. Because housing data cannot be plotted with ggplot2
B. To show the simplest possible version of the grammar with no new column names to learn, before returning to housing data for the rest of the module
C. Because `mpg` has more variables than the housing data
D. There was no real reason; it was simply reused from an old slide

3. In `ggplot(housing, aes(x = gr_liv_area, y = sale_price, color = bldg_type)) + geom_point()`, what job is `color = bldg_type` doing?

A. It sets every point to the same fixed color
B. It maps the real `bldg_type` column onto the color aesthetic, so color varies by row
C. It deletes the `bldg_type` column from the chart
D. It has no effect unless a legend is also added manually

4. A size aesthetic is generally a good fit for which kind of variable?

A. A nominal variable with several unordered categories
B. A quantitative or ordinal variable, where "bigger" has a real meaning
C. Any variable, regardless of type
D. Only a variable already mapped to color

5. The rough default bar chart of `bldg_type` counts showed the single-family count as a bare `2002`. According to this module's standing formatting rule, what does the finished version need to do with that number?

A. Round it to the nearest thousand
B. Leave it exactly as printed, since it is already correct
C. Format it with a thousands separator, as in 2,002
D. Convert it to a percentage instead

6. What does switching a chart's theme from `theme_gray()` to `theme_minimal()` change?

A. The underlying data values
B. The aesthetic mappings (which columns map to which visual properties)
C. Only the chart's background, grid lines, fonts, and borders, not the data itself
D. The geom being used to represent each observation

7. `scale_fill_manual()` was used in this module to do what, specifically?

A. Automatically choose the best possible colors for the data
B. Replace ggplot2's default color palette with a set of colors chosen on purpose
C. Remove color from the chart entirely
D. Convert a continuous variable into a categorical one

8. Which of the following best describes the mapped-versus-set distinction covered this module?

A. Mapped and set mean exactly the same thing in ggplot2
B. A variable name inside `aes()` maps an aesthetic to the data; a fixed value outside `aes()`, inside the geom, sets that aesthetic the same way for every observation
C. Mapped aesthetics only work with `geom_bar()`, while set aesthetics only work with `geom_point()`
D. Setting an aesthetic is only possible for the x and y axes
