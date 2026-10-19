#import "locale.typ": *

// Declaration on the use of aids and AI tools.
//
// The thesis-specific content is passed in via `declaration-of-tools-content`
// (see `/content/declaration-of-tools.typ`). Without it, only the heading and
// the generic introductory sentence are printed, so that an incomplete
// declaration is visible rather than silently absent.
#let declaration-of-tools(
  declaration-of-tools-content,
  language,
) = {
  heading(level: 1, DECLARATION_OF_TOOLS_TITLE.at(language))
  v(1em)

  par(justify: true, DECLARATION_OF_TOOLS_SECTION_A.at(language))

  if (declaration-of-tools-content != none) {
    declaration-of-tools-content
  }
}
