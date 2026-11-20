# Module 4 Notes: Communicating Amounts: Bar and Dot Charts

## A new kind of question

Module 3 gave us the grammar to build almost any chart. Starting this module, we specialize that grammar toward specific communication goals, beginning with amounts: "how much" of something is there, or "how many" of something exist. Average sale price by neighborhood, number of sales by building type, total sales by year: all three are amount questions, and all three are naturally answered with the length of a bar or the position of a dot. Later modules take on two more communication goals, change over time and association between two variables; amounts come first because bars and dots are the foundation those other chart types build on.

## This module's running question

We already know, from Modules 2 and 3, that 23 Ames neighborhoods have at least 20 real sales in this data. This module asks a pure amount question about those same 23 neighborhoods: on average, how much did a home sell for in each one? The rough default version of that bar chart is a correct first look: alphabetical order, rotated labels, a lowercase underscored title. The finished version needed four real changes, not cosmetic ones: sort by value (alphabetical order answers a question nobody asked), annotate directly with the real dollar value next to each bar so a reader never has to estimate from gridlines, flip the coordinates so 23 labels are horizontal and readable, and finish the labels with a real title and a dollar-formatted axis.

## Dot charts: an alternative to bars

A bar chart encodes an amount as the length of a filled rectangle, starting at zero. A Cleveland dot plot, named for statistician William Cleveland, encodes the exact same amount as the position of a single point along an axis. In grammar-of-graphics terms, this is simply a different geom, `geom_point()` instead of `geom_col()`, mapped to the exact same data. Neither chart type is always correct. A bar chart's filled length needs no explanation for a general audience, which is why it stays the default choice for most amount questions in this course. A dot plot uses far less ink for the same information, which can make a long list of categories feel lighter and easier to scan, and it makes a second series easy to add as a second dot on the same row, something a bar chart handles far more awkwardly.

## Annotation can mean highlighting, not just labeling

We already annotated every bar with its own dollar value. A second kind of annotation calls out one specific category using color, so a reader's eye goes straight to the single most relevant bar without losing the full ranking around it. NoRidge has the single highest average sale price of all 23 qualifying neighborhoods, $326,114, and one new column mapped to `fill` was the entire mechanism behind highlighting it. Highlighting only works because the other 22 neighborhoods stay fully visible and truthfully represented; deleting or shrinking the "uninteresting" categories to make the highlight look more dramatic would cross from annotation into distortion. A chart with every category highlighted a different color has, in practice, highlighted nothing.

## Ordering is a communication choice

A second real question, average sale price by building type (`TwnhsE`: $183,772; `1Fam`: $179,185; `Duplex`: $141,191; `Twnhs`: $137,596; `2fmCon`: $126,127), let us compare three real orderings of the same five numbers. Alphabetical order answers a question nobody asked: which building type comes first in the dictionary. It is simply what R does by default, not a meaningful choice. Sorting by value directly answers the real "how much" question: which building type commands the highest average price. There are real exceptions, when categories already have a natural, meaningful sequence of their own, like years or days of the week or a 1-to-10 rating scale; keeping that natural order is itself part of the message. For a pure amount comparison with no natural category order of its own, the general rule is to sort by value, almost always.

## Where this goes next

Module 5 refines a visualization further: titles, legends, color, type, and axis scaling, and when a styling choice clarifies rather than misleads.
