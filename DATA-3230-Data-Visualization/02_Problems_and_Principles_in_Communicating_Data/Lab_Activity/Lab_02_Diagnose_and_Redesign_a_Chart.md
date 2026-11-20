# Lab 2 (Guided): Diagnose and Redesign a Chart

## Learning Objectives

By the end of this lab, you will be able to diagnose which of the six principles of communicating data a visualization violates, and redesign a real chart from our housing data to fix it.

## Dataset

This lab uses `ames_housing.csv`, the same real, 2,413-row Ames, Iowa home-sale dataset from Module 1. Full source and license details are in `Curriculum_Resources/Datasets/README.md`.

## Instructions

1. Load the packages this lab needs: `library(ggplot2)` and `library(readr)`.
2. Load the housing data: `housing <- read_csv("ames_housing.csv")`.
3. Find every neighborhood with at least 20 sales (`table(housing$neighborhood)`), and compute the average `overall_qual` (the 1-to-10 quality rating) for each qualifying neighborhood using `aggregate()`.
4. Build a first version of a bar chart of average `overall_qual` by neighborhood, but do it deliberately badly: leave the default `theme_gray()`, do not sort the bars, leave the neighborhood labels unrotated so they overlap, and map `neighborhood` to `fill` so a legend appears.
5. Look at what you just built. Using the slide list from this module, write down which of the six principles your bad chart violates, and why.
6. Now rebuild the same chart well: sort the neighborhoods by average quality rating, use `coord_flip()` so the labels are readable, remove the now-unnecessary legend, pick a single intentional fill color, and add a clear title and axis labels.
7. Compare your two charts side by side. Write two sentences on what changed and why it matters, the same way we did in class with the average-sale-price chart.

## Guidance

`overall_qual` is a real ordinal variable, a 1-to-10 quality rating, not a true continuous quantity, but `aggregate()` and `geom_col()` will still treat it as numeric for averaging, which is fine here since we are summarizing a rating scale, not treating it as unordered categories.

If your bars come out in a strange order after `coord_flip()`, remember the fix from Module 1: convert `neighborhood` to a factor, with its levels set by the sort order of your computed average, before you plot it.

## Reflection Questions

1. Which neighborhood had the highest average overall quality rating? Does that match the neighborhood with the highest average sale price from Module 1's chart, or is it a different neighborhood?
2. Pick one of the six principles from this module. Name one real design choice in your "bad" chart that violated it, and the specific change you made to fix it.
3. A legend is not always the wrong choice. Describe a situation, using this same housing data, where a legend would actually be necessary rather than redundant.

## Extensions

If you finish early, repeat steps 3 through 6 using `overall_cond` (overall condition rating, also 1 to 10) instead of `overall_qual`, and compare the two resulting rankings of neighborhoods.
