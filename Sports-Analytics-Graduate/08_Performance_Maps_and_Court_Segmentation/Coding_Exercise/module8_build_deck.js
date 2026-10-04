// Module 8 (Graduate) slide deck build script. Requires Node + pptxgenjs
// (npm install -g pptxgenjs) and the five real PNGs in Coding_Exercise/
// (referenced below as images_grad/<file>.png -- point that prefix at
// this folder, or copy the five PNGs into an images_grad subfolder next
// to this script).
//
// Three of those five PNGs (module8_gsw_shot_chart.png,
// module8_cart_cartesian_heatmap.png, module8_cart_polar_heatmap.png)
// had a real axis-alignment bug as of this run (hoop-relative y plotted
// directly instead of shifted into drawNBAcourt()'s own coordinate
// system). module8_fix_plots.R in this same folder regenerates all
// three correctly -- run it in RStudio first. The slides that would use
// those three images currently ship as honest text/table fallbacks
// instead of the broken charts (see "pending a plotting fix" comments
// below). Once the three PNGs are regenerated, swap those three slide
// blocks back to s.addImage({ path: "images_grad/<file>.png", ... })
// (see the Module 9 undergraduate build script or the Module 2 template
// in 00_Course_Admin/pptx_template/ for the addImage() pattern) and
// rerun this script to produce the final deck with all five real charts.
const pptxgen = require("pptxgenjs");

const NAVY_BG = "0B1D33";
const NAVY_TEXT = "16213E";
const ORANGE = "E4572E";
const MUTED_BLUE = "AEBBD1";
const CARD_FILL = "EDF1F7";
const ACCENT_BLUE = "27496D";
const WHITE = "FFFFFF";

const FONT_HEAD = "Cambria";
const FONT_BODY = "Calibri";

const MARGIN_X = 0.6;
const CONTENT_W = 12.13;

let pres = new pptxgen();
pres.layout = "LAYOUT_WIDE";

function newSlide(bg) {
  const s = pres.addSlide();
  s.background = { color: bg || WHITE };
  return s;
}
function eyebrow(s, text, opts) {
  opts = opts || {};
  s.addText(text.toUpperCase(), {
    x: MARGIN_X, y: opts.y || 0.45, w: CONTENT_W, h: 0.35,
    fontFace: FONT_BODY, fontSize: 13, bold: true, color: opts.color || ORANGE,
    charSpacing: 2, isTextBox: true, margin: 0,
  });
}
function title(s, text, opts) {
  opts = opts || {};
  s.addText(text, {
    x: MARGIN_X, y: opts.y || 0.8, w: opts.w || CONTENT_W, h: opts.h || 1.0,
    fontFace: FONT_HEAD, fontSize: opts.size || 32, bold: true,
    color: opts.color || NAVY_TEXT, isTextBox: true, margin: 0, valign: "middle",
  });
}
function body(s, text, opts) {
  opts = opts || {};
  s.addText(text, {
    x: opts.x !== undefined ? opts.x : MARGIN_X, y: opts.y, w: opts.w || CONTENT_W, h: opts.h || 1,
    fontFace: FONT_BODY, fontSize: opts.size || 16, color: opts.color || NAVY_TEXT,
    isTextBox: true, margin: 0, valign: opts.valign || "top", lineSpacingMultiple: opts.lineSpacing || 1.25,
    italic: opts.italic || false, bold: opts.bold || false,
  });
}
function card(s, x, y, w, h, fill) {
  s.addShape("roundRect", { x, y, w, h, rectRadius: 0.06, fill: { color: fill || CARD_FILL }, line: { type: "none" } });
}
function numberedItem(s, n, text, y) {
  const circleColor = (n % 2 === 1) ? ACCENT_BLUE : ORANGE;
  s.addShape("ellipse", { x: MARGIN_X, y, w: 0.45, h: 0.45, fill: { color: circleColor }, line: { type: "none" } });
  s.addText(String(n), {
    x: MARGIN_X, y, w: 0.45, h: 0.45, align: "center", valign: "middle",
    fontFace: FONT_BODY, fontSize: 16, bold: true, color: WHITE, isTextBox: true, margin: 0,
  });
  s.addText(text, {
    x: MARGIN_X + 0.65, y: y - 0.05, w: CONTENT_W - 0.65, h: 0.85,
    fontFace: FONT_BODY, fontSize: 16, color: NAVY_TEXT, isTextBox: true, margin: 0, valign: "middle",
  });
}
function footerNote(s, text) {
  s.addText(text, {
    x: MARGIN_X, y: 6.95, w: CONTENT_W, h: 0.4,
    fontFace: FONT_BODY, fontSize: 10, color: "6B7A99", isTextBox: true, margin: 0,
  });
}
function breakSlide(nextText) {
  const s = newSlide(NAVY_BG);
  title(s, "10-Minute Break", { y: 3.0, size: 40, color: WHITE, h: 1.0 });
  s.addText(nextText, { x: MARGIN_X, y: 4.0, w: CONTENT_W, h: 0.6, fontFace: FONT_BODY, fontSize: 16, color: MUTED_BLUE, isTextBox: true, margin: 0 });
}
function upcomingSlide() {
  const s = newSlide(WHITE);
  eyebrow(s, "Before We Start");
  title(s, "What's Coming Up", { y: 1.05, size: 30 });
  const rows = [
    ["Due This Week", "-- update before class --"],
    ["Coming Up", "-- update before class --"],
    ["Office Hours", "-- update before class --"],
  ];
  rows.forEach((r, i) => {
    const y = 2.2 + i * 1.35;
    card(s, MARGIN_X, y, CONTENT_W, 1.15, CARD_FILL);
    s.addText(r[0], { x: MARGIN_X + 0.3, y: y, w: 2.8, h: 1.15, fontFace: FONT_BODY, fontSize: 15, bold: true, color: ACCENT_BLUE, isTextBox: true, margin: 0, valign: "middle" });
    s.addText(r[1], { x: MARGIN_X + 3.3, y: y, w: CONTENT_W - 3.6, h: 1.15, fontFace: FONT_BODY, fontSize: 14, italic: true, color: "6B7A99", isTextBox: true, margin: 0, valign: "middle" });
  });
  return s;
}
function liveCodingCue(promptText) {
  const s = newSlide(ACCENT_BLUE);
  eyebrow(s, "Let's Run This Together", { color: WHITE });
  title(s, promptText || "Open our R session and run this with me.", { y: 2.6, size: 30, color: WHITE, h: 1.6 });
  s.addText("Pull up your own session. We'll run it line by line and look at the real output together.", {
    x: MARGIN_X, y: 4.3, w: CONTENT_W, h: 0.6, fontFace: FONT_BODY, fontSize: 16, color: WHITE, isTextBox: true, margin: 0,
  });
  return s;
}
function codeSlide(eyebrowText, titleText, code, caption) {
  const s = newSlide(WHITE);
  eyebrow(s, eyebrowText);
  title(s, titleText, { y: 1.05, size: 26 });
  card(s, MARGIN_X, 2.2, CONTENT_W, 3.1, NAVY_BG);
  s.addText(code, { x: MARGIN_X + 0.4, y: 2.45, w: CONTENT_W - 0.8, h: 2.6, fontFace: "Courier New", fontSize: 14, color: "D9E2F3", isTextBox: true, margin: 0, valign: "middle" });
  if (caption) body(s, caption, { y: 5.5, size: 13, italic: true, color: ACCENT_BLUE });
  return s;
}

// 1. Title
{
  const s = newSlide(NAVY_BG);
  eyebrow(s, "Sports Analytics", { y: 2.0, color: ORANGE });
  title(s, "Basketball Performance Maps Based on Court Segmentation", { y: 2.45, size: 33, color: WHITE, h: 1.5 });
  s.addText("Module 08 · Graduate · 3-hour session", {
    x: MARGIN_X, y: 4.0, w: CONTENT_W, h: 0.5, fontFace: FONT_BODY, fontSize: 20, color: MUTED_BLUE, isTextBox: true, margin: 0,
  });
  card(s, MARGIN_X, 4.8, 3.6, 0.85, "16213E");
  s.addText([{ text: "Week 8\n", options: { bold: true } }, { text: "Graduate · 3-hour session" }], {
    x: MARGIN_X + 0.2, y: 4.8, w: 3.2, h: 0.85, fontFace: FONT_BODY, fontSize: 13, color: WHITE, isTextBox: true, margin: 0, valign: "middle",
  });
  s.addText("Zuccolotto, P., Manisera, M., & Sandri, M. (2026). Advanced Basketball Data Science: With Applications in R, Ch. 8. CRC Press / Chapman & Hall.", {
    x: MARGIN_X + 3.9, y: 4.8, w: 7.6, h: 0.85, fontFace: FONT_BODY, fontSize: 12, color: MUTED_BLUE, isTextBox: true, margin: 0, valign: "middle",
  });
}

// 2. Upcoming
upcomingSlide();

// 3. Recap
{
  const s = newSlide(WHITE);
  eyebrow(s, "Recap");
  title(s, "Where We Left Off", { y: 1.05, size: 32 });
  card(s, MARGIN_X, 2.1, CONTENT_W, 2.8, CARD_FILL);
  body(s, "Module 7 tracked the ball itself through the air, using object detection and the physics of a shot's minimum-speed trajectory. Today asks a related but different question: once you know where on the court a shot was taken from, how do you turn that single location into a defensible statement about how likely that shot was to go in? We build the answer in three stages: a sector-based performance map, a shot chart, and two data-driven maps built with Classification and Regression Trees, one on Cartesian shot coordinates and one on polar shot coordinates.", {
    x: MARGIN_X + 0.4, y: 2.4, w: CONTENT_W - 0.8, h: 2.3, size: 15, valign: "middle",
  });
  footerNote(s, "Data: BasketballAnalyzeR::PbP.BDB, 14,354 shot attempts with valid location and distance, 2017-18 NBA season.");
}

// 4. Outline
{
  const s = newSlide(WHITE);
  eyebrow(s, "Outline For The Day");
  title(s, "Where We're Headed", { y: 1.05, size: 32 });
  const quads = [
    ["I", "Segment 1", "From sectors to a shot chart: the simplest performance map, then the ungrouped version"],
    ["II", "Segment 2", "Letting a model find the boundaries itself: CART on Cartesian shot coordinates"],
    ["III", "Segment 3", "The same question on polar coordinates, a model comparison, and wrap-up"],
    ["IV", "Before Next Class", "Lab 8, the Module 8 quiz, and the practice questions"],
  ];
  const colW = (CONTENT_W - 0.4) / 2;
  quads.forEach((q, i) => {
    const col = i % 2, row = Math.floor(i / 2);
    const x = MARGIN_X + col * (colW + 0.4);
    const y = 2.15 + row * 2.1;
    card(s, x, y, colW, 1.85, CARD_FILL);
    s.addText(q[0], { x: x + 0.25, y: y + 0.2, w: 0.6, h: 0.5, fontFace: FONT_BODY, fontSize: 16, bold: true, color: ORANGE, isTextBox: true, margin: 0 });
    s.addText(q[1], { x: x + 0.7, y: y + 0.2, w: colW - 1.0, h: 0.5, fontFace: FONT_HEAD, fontSize: 16, bold: true, color: NAVY_TEXT, isTextBox: true, margin: 0 });
    s.addText(q[2], { x: x + 0.25, y: y + 0.7, w: colW - 0.5, h: 1.05, fontFace: FONT_BODY, fontSize: 12, color: NAVY_TEXT, isTextBox: true, margin: 0, lineSpacingMultiple: 1.2 });
  });
}

// 5. Learning objectives
{
  const s = newSlide(WHITE);
  eyebrow(s, "Learning Objectives");
  title(s, "By the End of Today, You Will Be Able To", { y: 1.05, size: 28 });
  const objs = [
    "Build a sector-based performance map from normalized shot coordinates and compute field goal percentage within each cell.",
    "Explain why expected points per shot, not raw field goal percentage, is the correct basis for comparing shot values.",
    "Build and interpret a shot chart with drawNBAcourt() and connect its visual pattern back to the sector map.",
    "Fit a CART model with rpart() on Cartesian shot coordinates, read the printed tree, and translate a split back into a physical basketball situation.",
    "Fit the same model on polar coordinates, compare its accuracy and structure to the Cartesian model, and argue for one over the other given a stated goal.",
  ];
  objs.forEach((t, i) => numberedItem(s, i + 1, t, 2.1 + i * 0.9));
}

// 6. Concept: performance map roadmap
{
  const s = newSlide(WHITE);
  eyebrow(s, "Concept · Segment 1");
  title(s, "From a Location to a Probability", { y: 1.05, size: 28 });
  card(s, MARGIN_X, 2.3, CONTENT_W, 1.9, CARD_FILL);
  body(s, "A performance map answers one question at every point on the floor: given a shot taken from here, what is the probability it goes in? We will build four versions of that answer today, in increasing order of how much the data itself gets to decide the boundaries, from a map we design by hand to two maps a model discovers on its own.", {
    x: MARGIN_X + 0.4, y: 2.6, w: CONTENT_W - 0.8, h: 1.4, size: 16, valign: "middle",
  });
  body(s, "We start with the version we design ourselves: sectors.", { y: 4.5, size: 16, bold: true, color: ORANGE });
}

// 7. Concept: sector method
{
  const s = newSlide(WHITE);
  eyebrow(s, "Concept · Segment 1");
  title(s, "Segmenting the Court by Distance and Angle", { y: 1.05, size: 28 });
  card(s, MARGIN_X, 2.3, CONTENT_W, 1.9, CARD_FILL);
  body(s, "The most direct way to segment a court is to bucket every shot by its distance from the hoop (rim, paint, mid-range, three) and its angle (left, center, right), then compute field goal percentage inside each resulting cell. Hoop distance is normalized to whichever basket is closer, since this half-court dataset mixes shots taken toward either end of a full court.", {
    x: MARGIN_X + 0.4, y: 2.6, w: CONTENT_W - 0.8, h: 1.4, size: 15, valign: "middle",
  });
  footerNote(s, "Methodology follows Zuccolotto, Manisera & Sandri (2026), Ch. 8, applied to data computed independently for this course.");
}

// 8. Live coding cue
liveCodingCue("Let's normalize our shot coordinates and build the sector map together.");

// 9. Code: sector build
codeSlide("Worked Example, Step 1", "Normalizing Coordinates and Building the Sector Map",
  "sh <- PbPmanipulation(PbP.BDB)\nsh <- sh[!is.na(sh$shot_distance) & !is.na(sh$x) & !is.na(sh$y), ]\n\nsh$dist_band <- cut(sh$shot_distance, c(0,4,14,22,Inf),\n                     labels = c(\"Rim\",\"Paint\",\"Mid-range\",\"Three\"))\nsh$angle_sector <- cut(sh$angle_deg, c(-Inf,-15,15,Inf),\n                        labels = c(\"Left\",\"Center\",\"Right\"))\n\ntable(sh$dist_band, sh$angle_sector)",
  "Run this yourself. We'll compare your table to the one on the next slide.");

// 10. Sector table
{
  const s = newSlide(WHITE);
  eyebrow(s, "Worked Example, Step 2");
  title(s, "The Sector-Based Performance Map", { y: 1.0, size: 26 });
  const rows = [
    ["Distance Band", "Angle Sector", "Attempts", "FG%"],
    ["Rim (0-4 ft)", "Center", "4,513", "64.4"],
    ["Paint (4-14 ft)", "Left", "370", "47.8"],
    ["Paint (4-14 ft)", "Center", "2,052", "40.9"],
    ["Paint (4-14 ft)", "Right", "348", "40.5"],
    ["Mid-range (14-22 ft)", "Left", "842", "39.5"],
    ["Mid-range (14-22 ft)", "Center", "792", "43.8"],
    ["Mid-range (14-22 ft)", "Right", "700", "41.1"],
    ["Three (22 ft+)", "Left", "1,890", "37.1"],
    ["Three (22 ft+)", "Center", "1,003", "38.1"],
    ["Three (22 ft+)", "Right", "1,844", "37.3"],
  ];
  s.addTable(rows.map((r, ri) => r.map((c) => ({
    text: c, options: { bold: ri === 0, color: ri === 0 ? WHITE : NAVY_TEXT, fill: { color: ri === 0 ? ACCENT_BLUE : (ri % 2 === 0 ? CARD_FILL : WHITE) }, fontFace: FONT_BODY, fontSize: 12, align: "center", valign: "middle" },
  }))), { x: MARGIN_X, y: 1.75, w: CONTENT_W, h: 4.6, colW: [4.0, 2.7, 2.7, 2.73], border: { type: "none" } });
  footerNote(s, "Data: BasketballAnalyzeR::PbP.BDB, 14,354 shots with valid location, 2017-18 NBA season.");
}

// 11. Concept: no rim-left/right
{
  const s = newSlide(WHITE);
  eyebrow(s, "Reading the Map Honestly");
  title(s, "Why Is There No Rim-Left or Rim-Right Row?", { y: 1.05, size: 27 });
  card(s, MARGIN_X, 2.3, CONTENT_W, 2.0, CARD_FILL);
  body(s, "At a distance of 0 to 4 feet, almost every attempt is close enough to center that this module's angle cutoff never separates one out. That absence is not a coding error. It is itself an honest finding about where shots that close to the basket actually happen on the floor.", {
    x: MARGIN_X + 0.4, y: 2.6, w: CONTENT_W - 0.8, h: 1.4, size: 16, valign: "middle",
  });
  s.addNotes("Common student issue: students may assume these rows are simply missing due to an error. Clarify this is a real, honest consequence of shot geography, not a bug in the cut() call.");
}

// 12. Big stat callout: EPS vs FG%
{
  const s = newSlide(WHITE);
  eyebrow(s, "Concept · The Number to Sit With");
  title(s, "Higher Field Goal % Does Not Mean a Better Shot", { y: 1.05, size: 26 });
  const cw = (CONTENT_W - 0.4) / 2;
  card(s, MARGIN_X, 2.3, cw, 3.3, ACCENT_BLUE);
  s.addText("43.8%", { x: MARGIN_X, y: 2.55, w: cw, h: 0.9, align: "center", fontFace: FONT_HEAD, fontSize: 40, bold: true, color: WHITE, isTextBox: true, margin: 0 });
  s.addText("Mid-range center FG%\nExpected points: 2 x 0.438 = 0.876", { x: MARGIN_X + 0.3, y: 3.5, w: cw - 0.6, h: 0.9, align: "center", fontFace: FONT_BODY, fontSize: 13, color: WHITE, isTextBox: true, margin: 0, lineSpacingMultiple: 1.3 });
  const x2 = MARGIN_X + cw + 0.4;
  card(s, x2, 2.3, cw, 3.3, ORANGE);
  s.addText("38.1%", { x: x2, y: 2.55, w: cw, h: 0.9, align: "center", fontFace: FONT_HEAD, fontSize: 40, bold: true, color: WHITE, isTextBox: true, margin: 0 });
  s.addText("Three-point center FG%\nExpected points: 3 x 0.381 = 1.143", { x: x2 + 0.3, y: 3.5, w: cw - 0.6, h: 0.9, align: "center", fontFace: FONT_BODY, fontSize: 13, color: WHITE, isTextBox: true, margin: 0, lineSpacingMultiple: 1.3 });
  s.addNotes("Discussion: this is the single most important number in the module. Redirect every FG%-based claim back to expected points per shot. Push students to state why a lower-percentage shot can still be the better shot to take.");
}

// 13. Discussion: shot selection
{
  const s = newSlide(WHITE);
  eyebrow(s, "Interactive Activity");
  title(s, "Why Modern Offenses Avoid the Mid-Range", { y: 1.05, size: 27 });
  card(s, MARGIN_X, 2.3, CONTENT_W, 2.3, CARD_FILL);
  body(s, "You now have the two numbers that explain the three-point revolution in one comparison.\n\n1. If mid-range shots go in more often, why would a front office still discourage taking them?\n2. Is there a game situation where the higher-percentage, lower-value shot is still the correct one to take?", {
    x: MARGIN_X + 0.4, y: 2.6, w: CONTENT_W - 0.8, h: 1.9, size: 15, valign: "middle", lineSpacing: 1.35,
  });
}

// 14. Concept: from sectors to shot chart
{
  const s = newSlide(WHITE);
  eyebrow(s, "Concept · Segment 1");
  title(s, "From Grouped Cells to Every Shot", { y: 1.05, size: 28 });
  card(s, MARGIN_X, 2.3, CONTENT_W, 1.7, CARD_FILL);
  body(s, "A sector map compresses the court into a handful of cells. A shot chart keeps every shot's exact location. We plot all of Golden State's attempts from their complete 2017-18 season on a half-court, color-coded by make or miss.", {
    x: MARGIN_X + 0.4, y: 2.6, w: CONTENT_W - 0.8, h: 1.2, size: 16, valign: "middle",
  });
  footerNote(s, "Golden State is used here because it is the one team in PbP.BDB with a full, complete 82-game season, giving the densest, most representative sample.");
}

// 15. Live coding cue
liveCodingCue("Let's build the Golden State shot chart together.");

// 16. Code: shot chart
codeSlide("Worked Example, Step 3", "Building the Shot Chart with drawNBAcourt()",
  "sh.GSW <- subset(sh, team == \"Golden State Warriors\")\nnrow(sh.GSW)          # 6,978\nmean(sh.GSW$made)    # 0.503\n\ndrawNBAcourt(ylim = c(0,35))\npoints(sh.GSW$x, sh.GSW$y,\n       col = ifelse(sh.GSW$made, \"dodgerblue\", \"tomato\"),\n       pch = 19, cex = 0.5)",
  "Run this together. We'll look at the pattern on the next slide.");

// 17. Shot chart result (chart image pending a plotting fix; see speaker notes)
{
  const s = newSlide(WHITE);
  eyebrow(s, "Worked Example, Step 4");
  title(s, "Golden State's Full 2017-18 Shot Chart", { y: 1.0, size: 27 });
  card(s, MARGIN_X, 2.1, CONTENT_W, 1.5, ORANGE);
  s.addText([
    { text: "6,978", options: { bold: true, fontSize: 30 } }, { text: " attempts   " },
    { text: "50.3%", options: { bold: true, fontSize: 30 } }, { text: " field goal percentage", options: {} },
  ], { x: MARGIN_X + 0.4, y: 2.1, w: CONTENT_W - 0.8, h: 1.5, fontFace: FONT_BODY, fontSize: 17, color: WHITE, isTextBox: true, margin: 0, valign: "middle" });
  body(s, "Every Golden State attempt from their complete 2017-18 season, plotted on a half-court and color-coded by make or miss. The rendered image for this specific chart is being regenerated after a real axis-alignment issue was caught in this run's QA pass; this slide will carry the image once that is back in hand. The real numbers above, and the pattern described below, already come directly from that same real data.", {
    x: MARGIN_X + 0.4, y: 3.9, w: CONTENT_W - 0.8, h: 2.6, size: 14, valign: "top",
  });
  s.addNotes("QA note for Faruk: module8_gsw_shot_chart.png was plotted with the shot data offset onto the wrong half of the y-axis relative to drawNBAcourt() (hoop-relative y plotted directly instead of shifted to the court's own coordinate system, hoop near y = -41.75). A corrected plotting script, module8_fix_plots.R, is already saved in this module's Coding_Exercise folder. Running it in RStudio regenerates this image (and the two CART heat images) correctly; no underlying number changes.");
}

// 18. Concept: reading the pattern
{
  const s = newSlide(WHITE);
  eyebrow(s, "Concept · Segment 1");
  title(s, "The Pattern a Sector Map Can Only Hint At", { y: 1.05, size: 27 });
  card(s, MARGIN_X, 2.3, CONTENT_W, 2.0, CARD_FILL);
  body(s, "A dense cluster of makes right at the rim. A much sparser, more mixed cloud through the mid-range. Bands of attempts along the three-point line, heaviest above the break and in the corners. A shot chart is the ungrouped version of the same question the sector map already started answering.", {
    x: MARGIN_X + 0.4, y: 2.6, w: CONTENT_W - 0.8, h: 1.4, size: 15, valign: "middle",
  });
}

// 19. Recap segment 1
{
  const s = newSlide(WHITE);
  eyebrow(s, "Recap · Segment 1");
  title(s, "Two Hand-Designed Maps, Covered", { y: 1.05, size: 29 });
  const cw = (CONTENT_W - 0.4) / 2;
  card(s, MARGIN_X, 2.2, cw, 2.9, CARD_FILL);
  s.addText("Covered", { x: MARGIN_X + 0.3, y: 2.45, w: cw - 0.6, h: 0.4, fontFace: FONT_BODY, fontSize: 13, bold: true, color: ORANGE, isTextBox: true, margin: 0 });
  body(s, "A sector map by distance and angle, and a full shot chart for Golden State's complete season. Both are maps we designed ourselves, choosing the boundaries by hand.", { x: MARGIN_X + 0.3, y: 2.9, w: cw - 0.6, h: 2.0, size: 14 });
  const x2 = MARGIN_X + cw + 0.4;
  card(s, x2, 2.2, cw, 2.9, CARD_FILL);
  s.addText("Next", { x: x2 + 0.3, y: 2.45, w: cw - 0.6, h: 0.4, fontFace: FONT_BODY, fontSize: 13, bold: true, color: ORANGE, isTextBox: true, margin: 0 });
  body(s, "Segment 2 lets a model find its own boundaries directly from the data, using Classification and Regression Trees.", { x: x2 + 0.3, y: 2.9, w: cw - 0.6, h: 2.0, size: 14 });
}

breakSlide("Back at the top of the hour. Next: letting a model find the boundaries itself.");

// 21. Concept: CART intro
{
  const s = newSlide(NAVY_BG);
  eyebrow(s, "Concept · Segment 2", { color: ORANGE });
  title(s, "Classification and Regression Trees", { y: 1.05, size: 30, color: WHITE });
  const boxes = [
    ["A Non-Basketball Example First", "Picture a bank deciding loan approval. A tree might first split applicants by income, then split each income group again by credit score, repeating until the groups are as pure as possible.", ACCENT_BLUE],
    ["The Same Idea Here", "CART repeats that same recursive splitting on shot coordinates instead of loan applicants, looking for the splits that best separate makes from misses.", ORANGE],
  ];
  const cw = (CONTENT_W - 0.4) / 2;
  boxes.forEach((b, i) => {
    const x = MARGIN_X + i * (cw + 0.4);
    card(s, x, 2.3, cw, 3.3, b[2]);
    s.addText(b[0], { x: x + 0.35, y: 2.6, w: cw - 0.7, h: 0.8, fontFace: FONT_HEAD, fontSize: 17, bold: true, color: WHITE, isTextBox: true, margin: 0 });
    s.addText(b[1], { x: x + 0.35, y: 3.5, w: cw - 0.7, h: 2.0, fontFace: FONT_BODY, fontSize: 14, color: WHITE, isTextBox: true, margin: 0, lineSpacingMultiple: 1.3 });
  });
  s.addNotes("Do not rush the loan-approval analogy before showing any code. Several students will not have seen a classification tree before; the analogy is what makes the first real rpart() output legible.");
}

// 22. Live coding cue
liveCodingCue("Let's fit the Cartesian CART model together and read the tree.");

// 23. Code: cart_xy
codeSlide("Worked Example, Step 5", "Fitting CART on Cartesian Shot Coordinates",
  "library(rpart)\nlibrary(rpart.plot)\n\ncart_xy <- rpart(made ~ x_rel + y_rel, data = sh,\n                  method = \"class\",\n                  control = rpart.control(maxdepth = 4,\n                                          cp = 0.001, minbucket = 150))\n\nrpart.plot(cart_xy)\nprintcp(cart_xy)",
  "x_rel and y_rel are hoop-relative Cartesian coordinates. Run this and look at the printed tree.");

// 24. Cartesian tree image
{
  const s = newSlide(WHITE);
  eyebrow(s, "Worked Example, Step 6");
  title(s, "The Cartesian Tree, Four Terminal Nodes", { y: 1.0, size: 27 });
  s.addImage({ path: "images_grad/module8_cart_cartesian_tree.png", x: 2.0, y: 1.8, w: 9.3, h: 4.7 });
  footerNote(s, "rpart.plot(cart_xy). Data: PbP.BDB, 14,354 shots, 2017-18 NBA season.");
}

// 25. Cartesian tree result table
{
  const s = newSlide(WHITE);
  eyebrow(s, "Worked Example, Step 7");
  title(s, "Reading the Four Terminal Nodes", { y: 1.0, size: 27 });
  const rows = [
    ["Node Condition", "Attempts", "Scoring Probability"],
    ["y_rel >= 1.9 ft from the hoop", "9,888 (69%)", "40.1%"],
    ["y_rel < 1.9 ft, x_rel >= 2.15 ft", "646 (4%)", "41.0%"],
    ["y_rel < 1.9 ft, x_rel < 2.15 ft, x_rel < -1.95 ft", "536 (4%)", "45.1%"],
    ["y_rel < 1.9 ft, x_rel < 2.15 ft, x_rel >= -1.95 ft", "3,284 (23%)", "71.0%"],
  ];
  s.addTable(rows.map((r, ri) => r.map((c) => ({
    text: c, options: { bold: ri === 0, color: ri === 0 ? WHITE : NAVY_TEXT, fill: { color: ri === 0 ? ACCENT_BLUE : (ri % 2 === 0 ? CARD_FILL : WHITE) }, fontFace: FONT_BODY, fontSize: 12.5, align: "center", valign: "middle" },
  }))), { x: MARGIN_X, y: 1.9, w: CONTENT_W, h: 2.4, colW: [6.63, 2.5, 3.0], border: { type: "none" } });
  body(s, "Training accuracy: 62.19%. Full node-by-node output is saved in module8_cart_cartesian_rules.txt.", { y: 4.6, size: 13, italic: true, color: ACCENT_BLUE });
}

// 26. Discussion: close-range sharp-angle
{
  const s = newSlide(WHITE);
  eyebrow(s, "Interactive Activity · Discussion");
  title(s, "What Basketball Situation Does This Split Describe?", { y: 1.05, size: 26 });
  card(s, MARGIN_X, 2.3, CONTENT_W, 2.4, CARD_FILL);
  body(s, "Even among shots close enough to the rim to be in a high-percentage group, a sharp lateral angle (x_rel < -1.95, well off to one side, close to the baseline) drops scoring probability from 71.0% down to 45.1%. A smaller group on the opposite side (x_rel >= 2.15) lands at 41.0%, despite being just as close to the hoop.\n\n1. What real shot does the 71.0%-to-45.1% split describe?\n2. Why would a fixed distance-only sector rule, like the one from Segment 1, have missed this entirely?", {
    x: MARGIN_X + 0.4, y: 2.6, w: CONTENT_W - 0.8, h: 1.9, size: 15, valign: "middle", lineSpacing: 1.3,
  });
  s.addNotes("Target answer: a close shot taken from a sharp, tight angle near the baseline, a baseline floater or short runner that is close in distance but low-percentage because of the restricted finishing angle. This finding is the whole argument for letting CART find boundaries instead of fixing them by hand.");
}

// 27. Live coding cue
liveCodingCue("Let's render the CART performance-map heat image together.");

// 28. Cartesian heatmap result (chart image pending a plotting fix; see speaker notes)
{
  const s = newSlide(WHITE);
  eyebrow(s, "Worked Example, Step 8");
  title(s, "The Cartesian Model as a Performance-Map Heat Image", { y: 1.0, size: 25 });
  card(s, MARGIN_X, 2.2, CONTENT_W, 3.1, CARD_FILL);
  body(s, "predict(cart_xy, grid, type = \"prob\") turns the four terminal nodes from the previous slide into a continuous heat image over the full court: a wide, cooler region beyond 1.9 ft where scoring probability sits at 40.1%, and three small, warmer pockets right at the rim, two near 41-45% and one at 71.0%, exactly where the table said they would be. The rendered image for this chart is being regenerated after a real axis-alignment issue was caught in this run's QA pass.", {
    x: MARGIN_X + 0.4, y: 2.5, w: CONTENT_W - 0.8, h: 2.5, size: 15, valign: "middle",
  });
  footerNote(s, "Scoring probability by location, predicted from cart_xy. Compare this directly to the Part 1 sector map.");
  s.addNotes("QA note for Faruk: same axis-alignment issue as the shot chart (Step 4). module8_fix_plots.R in this module's Coding_Exercise folder regenerates this heat image with the correct hoop-aligned y-coordinate. No underlying prediction or probability changes.");
}

// 29. Concept: comparing to sector map
{
  const s = newSlide(WHITE);
  eyebrow(s, "Concept · Segment 2");
  title(s, "A Model-Found Map vs. a Hand-Designed One", { y: 1.05, size: 27 });
  card(s, MARGIN_X, 2.3, CONTENT_W, 1.9, CARD_FILL);
  body(s, "The sector map from Segment 1 used fixed, round-number boundaries we chose in advance: 4, 14, and 22 feet. The CART heat image found its own boundaries directly from the data, including the baseline-angle effect no fixed-distance rule could have found on its own.", {
    x: MARGIN_X + 0.4, y: 2.6, w: CONTENT_W - 0.8, h: 1.4, size: 15, valign: "middle",
  });
}

// 30. Recap segment 2
{
  const s = newSlide(WHITE);
  eyebrow(s, "Recap · Segment 2");
  title(s, "A Model-Found Map, Covered", { y: 1.05, size: 30 });
  const cw = (CONTENT_W - 0.4) / 2;
  card(s, MARGIN_X, 2.2, cw, 2.9, CARD_FILL);
  s.addText("Covered", { x: MARGIN_X + 0.3, y: 2.45, w: cw - 0.6, h: 0.4, fontFace: FONT_BODY, fontSize: 13, bold: true, color: ORANGE, isTextBox: true, margin: 0 });
  body(s, "A four-node CART model on Cartesian coordinates, 62.19% training accuracy, that found a close-range, sharp-angle split a fixed sector rule would have missed.", { x: MARGIN_X + 0.3, y: 2.9, w: cw - 0.6, h: 2.0, size: 14 });
  const x2 = MARGIN_X + cw + 0.4;
  card(s, x2, 2.2, cw, 2.9, CARD_FILL);
  s.addText("Next", { x: x2 + 0.3, y: 2.45, w: cw - 0.6, h: 0.4, fontFace: FONT_BODY, fontSize: 13, bold: true, color: ORANGE, isTextBox: true, margin: 0 });
  body(s, "Segment 3 asks the same question using polar coordinates instead of Cartesian, and compares the two models directly.", { x: x2 + 0.3, y: 2.9, w: cw - 0.6, h: 2.0, size: 14 });
}

breakSlide("Back at the top of the hour. Next: the same question on polar coordinates.");

// 32. Concept: polar coordinates
{
  const s = newSlide(WHITE);
  eyebrow(s, "Concept · Segment 3", { color: ORANGE });
  title(s, "The Same Question, in Distance and Angle", { y: 1.05, size: 28 });
  card(s, MARGIN_X, 2.3, CONTENT_W, 1.9, CARD_FILL);
  body(s, "Section 8.3 of this module's approach asks the same question using polar coordinates, distance and angle from the hoop, instead of x and y. The model is fit the same way, with the same control parameters, just on a different coordinate system.", {
    x: MARGIN_X + 0.4, y: 2.6, w: CONTENT_W - 0.8, h: 1.4, size: 16, valign: "middle",
  });
}

// 33. Live coding cue
liveCodingCue("Let's fit the polar CART model together and compare accuracy directly.");

// 34. Code: cart_polar
codeSlide("Worked Example, Step 9", "Fitting CART on Polar Shot Coordinates",
  "cart_polar <- rpart(made ~ shot_distance + angle_deg,\n                     data = sh, method = \"class\",\n                     control = rpart.control(maxdepth = 4,\n                                             cp = 0.001, minbucket = 150))\n\nrpart.plot(cart_polar)\nprintcp(cart_polar)",
  "Run this and compare the printed tree's size to the Cartesian tree from Segment 2.");

// 35. Polar tree image
{
  const s = newSlide(WHITE);
  eyebrow(s, "Worked Example, Step 10");
  title(s, "The Polar Tree: One Single Split", { y: 1.0, size: 27 });
  s.addImage({ path: "images_grad/module8_cart_polar_tree.png", x: 2.8, y: 1.85, w: 7.7, h: 4.6 });
  footerNote(s, "rpart.plot(cart_polar). Data: PbP.BDB, 14,354 shots, 2017-18 NBA season.");
}

// 36. Polar result table
{
  const s = newSlide(WHITE);
  eyebrow(s, "Worked Example, Step 11");
  title(s, "A Much Simpler Model, Nearly the Same Accuracy", { y: 1.0, size: 26 });
  const rows = [
    ["Node Condition", "Scoring Probability"],
    ["shot_distance < 2.5 ft", "70.2%"],
    ["shot_distance >= 2.5 ft", "40.2%"],
  ];
  s.addTable(rows.map((r, ri) => r.map((c) => ({
    text: c, options: { bold: ri === 0, color: ri === 0 ? WHITE : NAVY_TEXT, fill: { color: ri === 0 ? ACCENT_BLUE : (ri % 2 === 0 ? CARD_FILL : WHITE) }, fontFace: FONT_BODY, fontSize: 16, align: "center", valign: "middle" },
  }))), { x: MARGIN_X, y: 2.0, w: CONTENT_W, h: 1.6, colW: [8.13, 4.0], border: { type: "none" } });
  body(s, "One single split, at exactly 2.5 feet from the hoop, with no angle information used at all.", { y: 4.0, size: 15, color: ACCENT_BLUE });
}

// 37. Polar heatmap result (chart image pending a plotting fix; see speaker notes)
{
  const s = newSlide(WHITE);
  eyebrow(s, "Worked Example, Step 12");
  title(s, "The Polar Model as a Performance-Map Heat Image", { y: 1.0, size: 25 });
  card(s, MARGIN_X, 2.2, CONTENT_W, 3.1, CARD_FILL);
  body(s, "Because the polar model's only split is on distance, its heat image is a single ring around the hoop, not four distinct regions: everything inside 2.5 feet at 70.2%, everything outside it at 40.2%, with no lateral-angle detail at all. That single boundary is the whole model. The rendered image for this chart is being regenerated after a real axis-alignment issue was caught in this run's QA pass.", {
    x: MARGIN_X + 0.4, y: 2.5, w: CONTENT_W - 0.8, h: 2.5, size: 15, valign: "middle",
  });
  footerNote(s, "Scoring probability by location, predicted from cart_polar. A single ring around the hoop, not four distinct regions.");
  s.addNotes("QA note for Faruk: same axis-alignment issue as the other two spatial charts. module8_fix_plots.R in this module's Coding_Exercise folder regenerates this heat image correctly. No underlying prediction changes.");
}

// 38. Big stat callout: accuracy comparison
{
  const s = newSlide(WHITE);
  eyebrow(s, "Concept · The Comparison This Module Wants You to Carry");
  title(s, "Distance Alone Captured Nearly All the Signal", { y: 1.05, size: 25 });
  const cw = (CONTENT_W - 0.4) / 2;
  card(s, MARGIN_X, 2.3, cw, 3.3, ORANGE);
  s.addText("62.19%", { x: MARGIN_X, y: 2.55, w: cw, h: 0.8, align: "center", fontFace: FONT_HEAD, fontSize: 38, bold: true, color: WHITE, isTextBox: true, margin: 0 });
  s.addText("Cartesian model\n4 terminal nodes, x and y", { x: MARGIN_X + 0.3, y: 3.35, w: cw - 0.6, h: 0.9, align: "center", fontFace: FONT_BODY, fontSize: 14, color: WHITE, isTextBox: true, margin: 0, lineSpacingMultiple: 1.3 });
  const x2 = MARGIN_X + cw + 0.4;
  card(s, x2, 2.3, cw, 3.3, ACCENT_BLUE);
  s.addText("62.32%", { x: x2, y: 2.55, w: cw, h: 0.8, align: "center", fontFace: FONT_HEAD, fontSize: 38, bold: true, color: WHITE, isTextBox: true, margin: 0 });
  s.addText("Polar model\n1 split, distance only", { x: x2 + 0.3, y: 3.35, w: cw - 0.6, h: 0.9, align: "center", fontFace: FONT_BODY, fontSize: 14, color: WHITE, isTextBox: true, margin: 0, lineSpacingMultiple: 1.3 });
  body(s, "Distance from the hoop is the dominant signal in whether a shot goes in. The Cartesian model's extra nodes bought a small amount of nuance, the baseline-angle effect, not a large jump in overall accuracy.", { y: 5.8, size: 13, color: ACCENT_BLUE });
}

// 39. Concept: trade-off
{
  const s = newSlide(WHITE);
  eyebrow(s, "Concept · Segment 3");
  title(s, "Simplicity vs. Detail, Not Right vs. Wrong", { y: 1.05, size: 28 });
  card(s, MARGIN_X, 2.3, CONTENT_W, 2.0, CARD_FILL);
  body(s, "Both models are valid, honestly computed performance maps. They make a different trade-off between simplicity and detail: the polar model is nearly as accurate and far easier to explain, while the Cartesian model captures one additional real effect the polar model cannot see at all.", {
    x: MARGIN_X + 0.4, y: 2.6, w: CONTENT_W - 0.8, h: 1.4, size: 16, valign: "middle",
  });
}

// 40. Interactive: small group debate
{
  const s = newSlide(WHITE);
  eyebrow(s, "Interactive Activity · Small Groups");
  title(s, "Argue for One Model, to a Coaching Staff", { y: 1.05, size: 27 });
  card(s, MARGIN_X, 2.3, CONTENT_W, 2.4, CARD_FILL);
  body(s, "Groups of 3-4. Half the groups argue for the Cartesian model, half for the polar model, as the one they would hand to a real coaching staff.\n\n1. State your model's accuracy and structure.\n2. State one concrete reason a coaching staff would prefer it over the other.\n3. One group from each side presents its case to the class.", {
    x: MARGIN_X + 0.4, y: 2.6, w: CONTENT_W - 0.8, h: 1.9, size: 15, valign: "middle", lineSpacing: 1.3,
  });
}

// 41. PhD/advanced-project callout
{
  const s = newSlide(NAVY_BG);
  eyebrow(s, "PhD / Advanced-Project Track", { color: ORANGE });
  title(s, "The Same Model Structure, a Different Target", { y: 1.05, size: 28, color: WHITE });
  card(s, MARGIN_X, 2.3, CONTENT_W, 3.0, ACCENT_BLUE);
  s.addText("A CART-based performance map is exactly the kind of model structure the injury-risk track in Module 10 depends on: a model that takes a handful of measurable inputs and partitions them into interpretable groups. Here, the inputs are court coordinates and the groups are scoring-probability regions. In Module 10, the inputs are athlete workload indicators and the groups are risk categories.", {
    x: MARGIN_X + 0.4, y: 2.6, w: CONTENT_W - 0.8, h: 2.3, fontFace: FONT_BODY, fontSize: 16, color: WHITE, isTextBox: true, margin: 0, valign: "middle", lineSpacingMultiple: 1.35,
  });
  footerNote(s, "Connects to the PhD track: Muritala, Brown & Haller (2026), Research in Sports Medicine; West et al. (2026), JSCR.");
}

// 42. Recap segment 3
{
  const s = newSlide(WHITE);
  eyebrow(s, "Recap · Segment 3");
  title(s, "Cartesian vs. Polar, Covered", { y: 1.05, size: 29 });
  const cw = (CONTENT_W - 0.4) / 2;
  card(s, MARGIN_X, 2.2, cw, 2.9, CARD_FILL);
  s.addText("Covered", { x: MARGIN_X + 0.3, y: 2.45, w: cw - 0.6, h: 0.4, fontFace: FONT_BODY, fontSize: 13, bold: true, color: ORANGE, isTextBox: true, margin: 0 });
  body(s, "A one-split polar model nearly matched a four-node Cartesian model's accuracy, and we connected this CART structure to the Module 10 injury-risk track.", { x: MARGIN_X + 0.3, y: 2.9, w: cw - 0.6, h: 2.0, size: 14 });
  const x2 = MARGIN_X + cw + 0.4;
  card(s, x2, 2.2, cw, 2.9, CARD_FILL);
  s.addText("Next", { x: x2 + 0.3, y: 2.45, w: cw - 0.6, h: 0.4, fontFace: FONT_BODY, fontSize: 13, bold: true, color: ORANGE, isTextBox: true, margin: 0 });
  body(s, "Module 9 moves from CART-based scoring probability to full machine learning models: Random Forests, Oblique Random Forests, and Extremely Randomized Trees.", { x: x2 + 0.3, y: 2.9, w: cw - 0.6, h: 2.0, size: 14 });
}

// 43. Summary
{
  const s = newSlide(WHITE);
  eyebrow(s, "Summary");
  title(s, "What to Carry Forward", { y: 1.05, size: 30 });
  const items = [
    "A sector map and a shot chart are performance maps we design by hand; CART models let the data find its own boundaries.",
    "Expected points per shot, not raw field goal percentage, is the correct basis for comparing shot value: 0.876 for mid-range center versus 1.143 for three-point center.",
    "The Cartesian CART model found a close-range, sharp-angle effect a fixed sector rule could not: 71.0% dropping to 45.1%.",
    "The polar model's single distance-based split, at 2.5 feet, nearly matched the four-node Cartesian model's accuracy, 62.32% versus 62.19%, showing distance is the dominant signal.",
  ];
  items.forEach((t, i) => {
    const y = 2.1 + i * 1.05;
    s.addShape("rect", { x: MARGIN_X, y: y + 0.05, w: 0.18, h: 0.18, fill: { color: i % 2 === 0 ? ACCENT_BLUE : ORANGE }, line: { type: "none" } });
    body(s, t, { x: MARGIN_X + 0.4, y: y - 0.1, w: CONTENT_W - 0.4, h: 0.95, size: 14 });
  });
}

// 44. Before next class
{
  const s = newSlide(WHITE);
  eyebrow(s, "Before Module 09");
  title(s, "Before Next Class", { y: 1.05, size: 30 });
  const cw = (CONTENT_W - 0.4) / 2;
  card(s, MARGIN_X, 2.3, cw, 2.6, CARD_FILL);
  s.addText("Do", { x: MARGIN_X + 0.3, y: 2.55, w: cw - 0.6, h: 0.4, fontFace: FONT_BODY, fontSize: 13, bold: true, color: ORANGE, isTextBox: true, margin: 0 });
  body(s, "Complete Lab 8 (sector maps, shot charts, and both CART models), the practice questions, and the Module 8 quiz.", { x: MARGIN_X + 0.3, y: 3.0, w: cw - 0.6, h: 1.6, size: 14 });
  const x2 = MARGIN_X + cw + 0.4;
  card(s, x2, 2.3, cw, 2.6, CARD_FILL);
  s.addText("Looking Ahead", { x: x2 + 0.3, y: 2.55, w: cw - 0.6, h: 0.4, fontFace: FONT_BODY, fontSize: 13, bold: true, color: ORANGE, isTextBox: true, margin: 0 });
  body(s, "Module 9: full machine learning scoring probability models, Random Forests, Oblique Random Forests, and Extremely Randomized Trees.", { x: x2 + 0.3, y: 3.0, w: cw - 0.6, h: 1.6, size: 14 });
}

// 45. References
{
  const s = newSlide(WHITE);
  eyebrow(s, "Full Reading List");
  title(s, "References Cited Today", { y: 1.05, size: 30 });
  const refs = [
    "Zuccolotto, P., Manisera, M., & Sandri, M. (2026). Advanced Basketball Data Science: With Applications in R, Ch. 8. CRC Press / Chapman & Hall.",
    "Sandri, M., Zuccolotto, P., & Manisera, M. BasketballAnalyzeR (R package): PbP.BDB, PbPmanipulation(), drawNBAcourt(). CRAN.",
    "Therneau, T., & Atkinson, B. rpart (R package). Milborrow, S. rpart.plot (R package). CRAN.",
    "All figures in this module were computed directly from the real PbP.BDB dataset and can be reproduced by running Coding_Exercise/module8_performance_maps.R.",
  ];
  body(s, refs.join("\n\n"), { y: 2.1, size: 14, lineSpacing: 1.5 });
}

// 46. Closing
{
  const s = newSlide(NAVY_BG);
  title(s, "See You in Module 09", { y: 3.1, size: 40, color: WHITE, h: 1.0 });
  s.addText("Machine Learning Scoring Probability Models", { x: MARGIN_X, y: 4.1, w: CONTENT_W, h: 0.6, fontFace: FONT_BODY, fontSize: 18, color: MUTED_BLUE, isTextBox: true, margin: 0 });
}

pres.writeFile({ fileName: "Module08_Performance_Maps_and_Court_Segmentation.pptx" }).then(() => {
  console.log("Done.");
});
