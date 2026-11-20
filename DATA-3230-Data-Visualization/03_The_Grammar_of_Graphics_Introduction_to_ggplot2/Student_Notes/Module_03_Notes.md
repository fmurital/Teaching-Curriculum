# Module 3 Notes: The Grammar of Graphics / Introduction to ggplot2

## A grammar, not a list of recipes

Statistician Leland Wilkinson proposed a grammar of graphics: the idea that any statistical chart is built from a small set of independent layers rather than memorized whole, chart type by chart type. `ggplot2`, the R package we use all semester, implements that grammar directly. Every chart we build needs exactly three pieces: data (the dataset being plotted), an aesthetic mapping through `aes()` (which columns map to which visual properties), and a geom (the geometric shape that represents each observation, like `geom_point()` or `geom_bar()`). Once you know the pieces, you can build almost any chart by recombining them, rather than learning "how to make a bar chart" and "how to make a scatterplot" as two unrelated recipes.

## One quick exception, then straight back to our own data

This module opens with one deliberate exception to our one-dataset rule: a single plot built on `mpg`, a small, famous dataset of 234 real cars that ships inside `ggplot2` itself. I wanted the simplest possible version of the grammar in front of you, with nothing else to think about, before rebuilding the exact same three-piece grammar on our own real housing data. From that point forward, every example in this module runs on `ames_housing.csv`, the same file we have used since Module 1.

## From rough to finished, inside ggplot2 itself

`ggplot(housing, aes(x = gr_liv_area, y = sale_price)) + geom_point()` is a real, correct chart the moment you run it: ggplot2's own default appearance. It is not, though, a finished chart. The same raw-to-finished idea from Module 2 showed up again here: a real title, title-case axis labels with no underscores, a dollar-formatted y-axis, and one intentional color are what separate a default plot from something you would actually show someone.

## Mapping variables to aesthetics

`x` and `y` are aesthetics too, they just happen to be the two every chart needs. Any other visual property, color, size, shape, or transparency, can be mapped inside the same `aes()` call. I mapped our real `bldg_type` column (five real categories in this data: single-family, duplex, townhouse, townhouse end unit, and two-family conversion) onto color and onto shape, and mapped `overall_qual`, our real 1-to-10 quality rating, onto size. Color and shape both work for a nominal variable like `bldg_type`, though shape gets hard to read past six to eight categories. Size works well for a quantitative or ordinal variable, where "bigger" has a real meaning; mapping size to a nominal variable would imply an order that is not really there.

The distinction that trips up almost everyone the first time: `color = bldg_type` inside `aes()` maps color to a real column, so it changes row by row. `color = "#27496D"` outside `aes()`, inside `geom_point()` itself, sets one fixed color for every point, regardless of what the data says. Same word, two completely different jobs.

## Bar charts, rough to finished, again

`geom_bar()` counts rows for us directly from `bldg_type`; we never had to count them ourselves first. The default version had four real problems: a lowercase, underscored `labs()` title and axis label; raw category codes like `TwnhsE` that mean nothing without a legend, the same semantic problem from Module 2's communication model; bars in whatever order R stored the categories, not sorted by count; and a bare `2002` for the single-family count, with no comma, one more number this course's standing rule says needs a thousands separator before it goes in front of anyone. The finished version fixed all four: full category names, sorted bars, comma-formatted counts, and a real title.

## Themes and scales are their own layers

A theme controls everything about a chart that is not the data, the mapping, or the geom: background, grid lines, fonts, borders. Switching from `theme_gray()` (ggplot2's default) to `theme_minimal()`, `theme_classic()`, or `theme_bw()` never touches a single data point; it only changes how the same real numbers are dressed. A scale controls how one mapped aesthetic turns into pixels or colors; `scale_fill_manual()` let us replace ggplot2's default color palette with five colors we chose on purpose. Neither a theme nor a scale is optional extra polish bolted on at the end. They are two more pieces of the same grammar we have been using all along.

## Where this goes next

Module 4 puts this same grammar to work on one specific communication goal: showing "how much" or "how many" with bar and dot charts, still on our own housing data.
