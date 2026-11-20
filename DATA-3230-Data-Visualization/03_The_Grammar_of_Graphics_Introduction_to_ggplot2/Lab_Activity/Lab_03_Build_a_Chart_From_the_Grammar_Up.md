# Lab 3 (Guided): Build a Chart From the Grammar Up

## Learning Objectives

By the end of this lab, you will be able to build a ggplot2 chart from its three required pieces (data, aesthetic mapping, geom), map a real variable onto a non-position aesthetic, and finish a rough default chart into a presentation-ready one.

## Dataset

This lab uses `ames_housing.csv`, the same real, 2,413-row Ames, Iowa home-sale dataset from Modules 1 and 2. Full source and license details are in `Curriculum_Resources/Datasets/README.md`.

## Instructions

1. Load the packages this lab needs: `library(ggplot2)`, `library(readr)`, and `library(scales)`.
2. Load the housing data: `housing <- read_csv("ames_housing.csv")`.
3. Build the simplest possible scatterplot of `gr_liv_area` (above-ground living area) on the x-axis and `sale_price` on the y-axis, using only `ggplot()`, `aes()`, and `geom_point()`, exactly as we did together in class. Do not add any labels, colors, or themes yet.
4. Look at what you just built and write down, in your own words, which three pieces of the grammar each line of your code supplied.
5. Now map `overall_qual` (our real 1-to-10 quality rating) onto the `size` aesthetic of the same scatterplot, and separately build a second version mapping `bldg_type` onto `color` instead. Keep both versions.
6. Pick whichever of your two mapped versions you think communicates more clearly, and finish it: add a real title, title-case axis labels with no underscores, a dollar-formatted y-axis using `scales::label_dollar()`, and `theme_minimal()`.
7. Separately, build a bar chart of counts by `bldg_type` using `geom_bar()`, look at the rough default version, then rebuild it finished: full category names instead of codes, bars sorted by count, comma-formatted counts using `scales::comma()`, and a single intentional fill color.

## Guidance

Remember the mapped-versus-set distinction from class: a variable name inside `aes()` maps that aesthetic to the data, while a fixed value (like `color = "#27496D"`) outside `aes()`, inside the geom itself, sets that aesthetic to one value for every observation. Mixing these up is the single most common mistake at this stage.

If your bar chart's bars will not sort correctly after `coord_flip()`, remember the fix from Modules 1 and 2: convert the category column to a factor, with its levels set by the sort order of your computed counts, before you plot it.

## Reflection Questions

1. Between mapping `bldg_type` onto color and mapping it onto shape, which did you find easier to read on this particular scatterplot, and why?
2. Name one specific thing your rough default bar chart needed before it would have been ready to show someone outside this class.
3. A theme change (like switching from `theme_gray()` to `theme_minimal()`) never touches the underlying data. Explain, in one or two sentences, why that still matters for how a chart communicates.

## Extensions

If you finish early, repeat step 5 using `overall_cond` (overall condition rating) instead of `overall_qual` for the size aesthetic, and compare which of the two ratings produces a size pattern that is easier to see on the scatterplot.
