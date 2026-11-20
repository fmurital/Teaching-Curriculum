# Lab 4 (Guided): Annotate and Order a Chart

## Learning Objectives

By the end of this lab, you will be able to build a bar chart and a dot plot for the same real amount question, add a direct data-value annotation and a single-category highlight, and justify an ordering choice for a set of categories.

## Dataset

This lab uses `ames_housing.csv`, the same real, 2,413-row Ames, Iowa home-sale dataset from Modules 1 through 3. Full source and license details are in `Curriculum_Resources/Datasets/README.md`.

## Instructions

1. Load the packages this lab needs: `library(ggplot2)`, `library(readr)`, and `library(scales)`.
2. Load the housing data: `housing <- read_csv("ames_housing.csv")`.
3. Compute the real average `overall_qual` (the 1-to-10 quality rating) for each of the five real `bldg_type` categories, using `aggregate()`.
4. Build a rough, default bar chart of this result: do not sort it, leave the axis labels as the raw column names, and do not add any annotations.
5. Rebuild the same chart finished: sort the five bars by value, add a direct text annotation of each bar's real average quality rating (rounded to one decimal place), use `coord_flip()`, and give it a real title and clean axis labels.
6. Redraw the same five real numbers as a Cleveland dot plot instead of a bar chart (`geom_point()` in place of `geom_col()`, with a thin `geom_segment()` guide line back to zero), keeping the same sort order and annotations.
7. Pick whichever one building type you think deserves a highlight, add a new column that marks it against the other four, and rebuild the finished bar chart with that one category in a different color.

## Guidance

Remember the ordering rule from class: sort by value for a pure amount comparison with no natural category order of its own. `bldg_type` has no inherent sequence, so sorting by the computed quality average, not alphabetically, is the right call here.

If your dot plot's guide lines will not draw correctly, check that `geom_segment()`'s `x` argument is set to `0`, not left out; a dot plot's guide line always starts at zero, the same place a bar chart's bar does.

## Reflection Questions

1. Which building type had the highest average quality rating? Is it the same building type that had the highest average sale price in this module's own example, or a different one?
2. Describe, in your own words, one real situation where you would reach for a dot plot instead of a bar chart for this same data, and one real situation where you would stick with the bar chart.
3. Explain why highlighting every one of the five building types a different color would defeat the purpose of highlighting at all.

## Extensions

If you finish early, repeat steps 3 through 5 using `overall_cond` (overall condition rating) instead of `overall_qual`, and compare whether the ranking of building types changes between the two ratings.
