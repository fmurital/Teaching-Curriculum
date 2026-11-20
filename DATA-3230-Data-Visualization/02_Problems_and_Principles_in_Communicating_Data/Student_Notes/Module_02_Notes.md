# Module 2 Notes: Problems and Principles in Communicating Data

## Why I'm starting here, not with code

Before we write another line of R, I want you to see, firsthand, why this course exists at all. Data visualization is not a decoration you add to an analysis after the real work is done. It is the step where your work either reaches people or it doesn't. This module runs on the exact same real dataset we met in Module 1, the 2,413 real Ames, Iowa home sales from De Cock (2011), because I want you watching the same real numbers succeed or fail depending on how they're shown, not distracted by a new dataset on top of a new idea.

## Same data, two outcomes

I asked one simple real question of our housing data: how many of the 2,413 sales happened in each of the 23 neighborhoods with at least 20 sales? I built that answer two ways. First as a pie chart with all 23 slices. Then as a sorted horizontal bar chart. The pie chart buried the answer in a wheel of similarly colored, similarly sized wedges, and the legend ended up doing more work than the chart itself. The bar chart answered the same question in about two seconds: NAmes had the most sales, NPkVill the fewest, and you could see the whole ranking at a glance. The data never changed. The visualization did.

## The research process

Data visualization is one step inside a larger process: a question, data collection, data organization, data analysis, and data communication. The question comes first, always. If I can't state what I'm trying to find out, I'm not ready to open R yet. Once the data is collected, it has to be organized into a tidy format: one row per observation, one column per variable. Our own housing data is already tidy this way, which is exactly why it has been so easy to work with since Module 1. Analysis comes next, and finally communication, which is where visualization almost always belongs.

## A model of communication

Any message, visual or spoken, moves from a source, into a message, through a transmitter, past noise, to a receiver. This comes from Shannon and Weaver's classic 1949 account of communication. For us, a chart is a transmitter exactly the way a voice is. It can add noise (clutter, a confusing color scheme, an unreadable label) just as easily as a mumbled sentence can. Communication problems tend to fall into three types: technical (can the symbols even get through, at the right resolution, the right format), semantic (do the symbols mean what you intend, which is why our own neighborhood codes like "NAmes" or "Blmngtn" mean nothing to someone without a legend), and effectiveness (does the received message actually change what the audience does, the "so what" behind the chart).

## Six principles I'll keep coming back to

Know your goal (who is this for, what should they know, what should they do about it). Use the right data (related to the goal, and enough of it, which is why I actually checked whether combining five years of housing sales into one average was defensible rather than assuming it). Select suitable visualizations, which starts with knowing whether a variable is quantitative (sale_price), ordinal (overall_qual, a real 1-to-10 quality rating), or nominal (neighborhood, no inherent order). Design for aesthetics, which I showed you directly: the exact same average-sale-price-by-neighborhood numbers, rendered once badly (rotated labels, a redundant legend, a cluttered default theme) and once well (sorted, labeled, dollar-formatted, no legend needed at all). Choose an effective medium and channel, since a standalone static graphic and a live narrated presentation call for different design choices. And finally, check the results: did the audience receive the message, interpret it correctly, and act on it.

## Where this goes next

Every module from here on puts these six principles into practice with a specific chart type, always on this same housing dataset. Module 3 introduces ggplot2's own grammar directly, the layered approach we've already been using without naming it yet.
