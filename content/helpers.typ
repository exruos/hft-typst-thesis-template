// Shared helpers for the chapter files. `#include` does not share scope, so
// every chapter that uses these has to import them:
//
//   #import "/content/helpers.typ": tbl, lst

// Tables: the body text is justified and double-spaced, which stretches narrow
// table cells; inside tables both are switched off.
#let tbl(..args) = {
  set par(justify: false, leading: 0.55em, spacing: 0.55em)
  set text(hyphenate: true)
  table(..args)
}

// Code listing read from a file in /code. The language is passed explicitly,
// so the files can keep a neutral `.txt` extension; it selects both the syntax
// highlighting and the language badge `codly` draws in the corner.
//
// A listing that fits on one page is placed as a float, which keeps a listing
// arriving near the foot of a page from emptying the rest of it. A float
// cannot break across pages, so a longer one stays in the flow, where it can
// break; the text block holds about 43 lines at the default size.
//
// `float: auto` applies that length heuristic. Pass `false` for a run of short
// listings that belong together: floated, they would be placed one to a page,
// whereas in the flow they stack under the paragraph that introduces them.
//
// The figure is returned bare rather than wrapped in a content block, so that
// a label written after the call attaches to the figure and `@` can reach it:
//
//   #lst("/code/example-listing.txt", "rust")[Caption.] <lst:example>
#let lst(path, lang, size: 8pt, float: auto, caption) = {
  let code = read(path)
  figure(
    text(size: size, raw(code, lang: lang, block: true)),
    caption: caption,
    placement: if float == false { none }
      else if float == true { auto }
      else if code.split("\n").len() > 44 { none } else { auto },
  )
}
