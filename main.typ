// Entry point. Compile this file:  typst watch main.typ
//
// Everything that describes *this* thesis lives in the `thesis.with(...)` call
// below; the layout itself is in `template/lib.typ`. Chapters are included at
// the bottom in reading order. See README.md for where every kind of file goes.
#import "template/lib.typ": thesis
#import "acronyms.typ": acronym-entries
#import "glossary.typ": glossary-entries

#show: thesis.with(
  language: "en", // "en" or "de" -- switches every fixed label (Contents, Abstract, ...)
  title: "Title of Your Thesis",
  authors: (
    (name: "Firstname Lastname", student-id: "1234567", course-of-studies: "Software Technology"),
  ),
  type-of-thesis: "Master's Thesis", // or "Bachelor's Thesis"
  bibliography: bibliography("refs.bib"),
  bib-style: "ieee",
  city: "Stuttgart", // printed above the signature line of the declaration of authorship
  start-date: datetime(year: 2026, month: 3, day: 1),
  date: datetime(year: 2026, month: 9, day: 1), // submission date
  acronyms: acronym-entries,
  glossary: glossary-entries, // remove or comment out if you do not need a glossary
  // Either key may be omitted, but at least one supervisor is required.
  supervisor: (company: "Company Supervisor", university: "Prof. Dr. University Supervisor"),
  university: "Stuttgart Technical University of Applied Sciences",
  university-faculty: "Faculty Geomatics, Computer Science and Mathematics",
  university-short: "HFT",
  // Title page logos. Drop `logo-right` to get a single centered logo.
  logo-left: image("/figures/hft.svg", height: 110%),
  logo-right: image("/figures/logo-placeholder.svg", height: 90%),
  show-abstract: true,
  abstract: read("/content/abstract.typ"),
  acknowledgements: include("/content/acknowledgements.typ"),
  appendix: include("/content/appendix.typ"),
  declaration-of-tools-content: include("/content/declaration-of-tools.typ"),
)

// Main Content

#include "/content/introduction.typ"
#include "/content/background.typ"
#include "/content/related-work.typ"
#include "/content/methodology.typ"
#include "/content/implementation.typ"
#include "/content/evaluation.typ"
#include "/content/discussion.typ"
#include "/content/conclusion.typ"
