// ---------------------------------------------------------------------------
// Draft annotations -- DELETE THIS FILE AND EVERY USE OF IT BEFORE SUBMISSION.
//
// Color-coded so the margin can be skimmed for one kind of work at a time:
//   #draft   violet  drafted or summarised ; rewrite
//   #cut        amber   candidate for cutting or compressing if space is short
//   #check-ref  red     reference missing, or citation not yet verified
//
// Find them all with:  grep -rn "#draft\|#cut\[\|#check-ref" main.typ content/
// ---------------------------------------------------------------------------
#import "@preview/drafting:0.2.2": margin-note

#let draft(body) = margin-note(
  stroke: rgb("#7C3AED"), fill: rgb("#F5F3FF"), text(size: 7pt)[*REWRITE.* #body],
)
#let cut(body) = margin-note(
  stroke: rgb("#B45309"), fill: rgb("#FFFBEB"), text(size: 7pt)[*CUT?* #body],
)
#let check-ref(body) = margin-note(
  stroke: rgb("#B91C1C"), fill: rgb("#FEF2F2"), text(size: 7pt)[*SOURCE.* #body],
)
