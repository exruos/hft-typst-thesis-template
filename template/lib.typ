#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.10": *
#import "@preview/hydra:0.6.2": hydra
#import "@preview/glossarium:0.5.10": make-glossary, register-glossary, print-glossary, gls, glspl, get-entry-back-references
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import "locale.typ": TABLE_OF_CONTENTS, APPENDIX, REFERENCES, LIST_OF_FIGURES, LIST_OF_TABLES, LIST_OF_LISTINGS, LIST_SHORT_FIGURE, LIST_SHORT_TABLE, LIST_SHORT_LISTING
#import "titlepage.typ": *
#import "declaration-of-authorship.typ": *
#import "declaration-of-tools.typ": *
#import "check-attributes.typ": *

// Workaround for the lack of an `std` scope.
#let std-bibliography = bibliography

#let thesis(
  title: none,
  authors: (:),
  language: none,
  at-university: none,
  type-of-thesis: none,
  show-confidentiality-statement: true,
  show-declaration-of-authorship: true,
  show-declaration-of-tools: true,
  show-table-of-contents: true,
  show-lists: true,
  show-abstract: true,
  abstract: none,
  show-acknowledgements: true,
  acknowledgements: none,
  appendix: none,
  declaration-of-authorship-content: none,
  declaration-of-tools-content: none,
  titlepage-content: none,
  university: none,
  university-faculty: none,
  university-short: none,
  city: none,
  supervisor: (:),
  date: none,
  start-date: none,
  date-format: "[day].[month].[year]",
  bibliography: none,
  glossary: none,
  acronyms: none,
  bib-style: "ieee",
  math-numbering: "(1)",
  logo-left: none,
  logo-right: none,
  ignored-link-label-keys-for-highlighting: (),
  body,
) = {
  // check required attributes
  check-attributes(
    title,
    authors,
    language,
    type-of-thesis,
    show-declaration-of-authorship,
    show-table-of-contents,
    show-abstract,
    abstract,
    appendix,
    university,
    university-faculty,
    supervisor,
    date,
    city,
    bibliography,
    glossary,
    acronyms,
    bib-style,
    logo-left,
    logo-right,
    university-short,
    math-numbering,
    ignored-link-label-keys-for-highlighting,
  )

  // ---------- Fonts & Related Measures ---------------------------------------

  let body-font = "Fira Sans"
  let body-size = 11pt
  let heading-font = "Fira Sans"
  let code-font = "Fira Code"
  let h1-size = 40pt
  let h2-size = 16pt
  let h3-size = 11pt
  let h4-size = 11pt
  let page-grid = 16pt  // vertical spacing on all pages

  // ---------- Layout Knobs (tune these to trade whitespace for pages) --------
  let par-spacing = 16pt        // gap between paragraphs
  let chapter-drop = 160pt      // blank space above a chapter heading
  let chapter-num-size = 160pt  // the large grey number on a chapter page
  let margin-top = 3.5cm
  let margin-bottom = 2.5cm
  let margin-left = 3.5cm
  let margin-right = 2.5cm

  
  // ---------- Basic Document Settings ---------------------------------------

  set document(title: title, author: authors.map(author => author.name))
  let many-authors = authors.len() > 3
  let in-frontmatter = state("in-frontmatter", true)    // to control page number format in frontmatter
  let in-body = state("in-body", true)                  // to control heading formatting in/outside of body

  // customize captions
  set figure.caption(separator: [ -- ], position: bottom)
  show figure.caption: set text(font: heading-font, size: body-size)

  // math numbering
  set math.equation(numbering: math-numbering)

  // code
  show: codly-init.with()
  codly(languages: codly-languages, inset: 0.1em, lang-outset: (x: -2pt, y: 3pt))
  show raw: set text(font: code-font)

  // initialize `glossarium`
  // CAVEAT: all `figure` show rules must come before this (see `glossarium` docs)
  show: make-glossary

  // register the glossary passed in `glossary`
  if (glossary != none) {
    register-glossary(glossary)
  }

  // register the acronyms passed in `acronyms`
  if (acronyms != none) {
    register-glossary(acronyms)
  }

  // show links in dark blue
  show link: set text(fill: blue.darken(40%))

  // ========== TITLEPAGE ========================================

  if (titlepage-content != none) {
    titlepage-content
  } else {
    titlepage(
      authors,
      date,
      start-date,
      heading-font,
      language,
      logo-left,
      logo-right,
      many-authors,
      supervisor,
      title,
      type-of-thesis,
      university,
      university-faculty,
      date-format,
      university-short,
      page-grid,
    )
  }
  counter(page).update(1)  

  // ---------- Page Setup ---------------------------------------

  // adapt body text layout to basic measures
  set text(
    font: body-font, 
    lang: language, 
    size: body-size - 0.5pt,      // 0.5pt adjustment because of large x-hight
    top-edge: 0.75 * body-size, 
    bottom-edge: -0.25 * body-size,
  )
  set par(
    spacing: par-spacing,
    leading: page-grid - body-size, 
    justify: true,
  )

  set page(
    margin: (top: margin-top, bottom: margin-bottom, left: margin-left, right: margin-right),
    header:
      grid(
        columns: (2fr, 1fr),
        align: (left, right),
        row-gutter: 0.5em,
        smallcaps(text(font: heading-font, size: body-size, 
          context {
            hydra(1, display: (_, it) => it.body, use-last: true, skip-starting: false)
          },
        )),
        text(
          font: heading-font, 
          size: body-size, 
          number-type: "lining",
          context counter(page).display(),
        ),
        grid.cell(colspan: 2, line(length: 100%, stroke: 0.5pt)),
      ),
      header-ascent: page-grid,
      footer: none,
  )


  // ========== FRONTMATTER ========================================

  set page(numbering: "i")
  
  // ---------- Heading Format (Part I) ---------------------------------------

  show heading: set text(weight: "bold", fill: luma(80), font: heading-font)
  show heading.where(level: 1): it => {v(2 * page-grid) + text(size: 2 * page-grid, it)}

  // ---------- Abstract ---------------------------------------

  if (show-abstract and abstract != none) {
    heading(level: 1, numbering: none, outlined: false, ABSTRACT.at(language))
    text(abstract)
    pagebreak()
  }

  // ---------- Acknowledgements ---------------------------------------

  if (show-acknowledgements and acknowledgements != none) {
    heading(level: 1, numbering: none, outlined: false, ACKNOWLEDGEMENTS.at(language))
    acknowledgements
    pagebreak()
  }

  // ---------- ToC (Outline) ---------------------------------------

  // top-level TOC entries in bold without filling
  show outline.entry.where(level: 1): it => {
    set block(above: 2 * page-grid / 3)
    set text(font: heading-font, weight: "semibold", size: body-size)
    link(
      it.element.location(),    // make entry linkable
      it.indented(it.prefix(), it.body() + box(width: 1fr,) +  it.page())
    )
  }

  // other TOC entries in regular with adapted filling
  show outline.entry.where(level: 2).or(outline.entry.where(level: 3)): it => {
    set block(above: page-grid - body-size)
    set text(font: heading-font, size: body-size)
    link(
      it.element.location(),  // make entry linkable
      it.indented(
          it.prefix(),
          it.body() + "  " +
            box(width: 1fr, repeat([.], gap: 2pt), baseline: 30%) +
            "  " + it.page()
      )
    )
  }

  if (show-table-of-contents) {
    outline(
      title: TABLE_OF_CONTENTS.at(language),
      indent: auto,
      depth: 3,
    )
  }

  // ---------- Lists of figures, tables and listings ----------------

  // Figure outlines are single-level, so the chapter rule above would set every
  // entry bold and without a leader. Restate the sub-entry style locally.
  // Captions may be explanatory and run to several lines, which is right under
  // a figure and useless in a list. Entries are therefore cut to the caption's
  // first sentence, flattened to plain text. Write the first sentence of every
  // caption so that it works as a short title on its own.
  let cap-to-string(c) = {
    if c == none { "" }
    else if type(c) == str { c }
    else if c.has("text") { c.text }
    else if c.has("children") { c.children.map(cap-to-string).join("") }
    else if c.has("body") { cap-to-string(c.body) }
    else if c.func() == smartquote { if c.double { "\"" } else { "\u{2019}" } }
    // A citation carries nothing a list entry needs, so it is dropped. An
    // acronym reference does: it is rendered as the short form, which is what a
    // terse list entry wants even where the caption itself spells the term out.
    else if c.func() == ref {
      let hit = if acronyms == none { () } else {
        acronyms.filter(a => a.key == str(c.target))
      }
      if hit.len() > 0 { hit.first().short } else { "" }
    }
    else { " " }
  }
  let first-sentence(c) = {
    let t = cap-to-string(c)
      .replace(regex("\s+"), " ")
      // Typst has no $1 syntax in a string replacement; use a function.
      .replace(regex(" +([.,;:])"), m => m.captures.at(0))
      .trim()
    let i = t.position(regex("\.(\s|$)"))
    if i == none { t } else { t.slice(0, i + 1) }
  }

  // "Figure"/"Table"/"Listing" spelled out costs about a centimetre of every
  // entry in the lists. Abbreviated there only; in-text references keep the
  // full supplement.
  let short-supplement(el) = {
    if el.kind == table { LIST_SHORT_TABLE.at(language) }
    else if el.kind == raw { LIST_SHORT_LISTING.at(language) }
    else { LIST_SHORT_FIGURE.at(language) }
  }

  if (show-lists) {
    show outline.entry: it => {
      // Tighter than the Contents: these lists are long and single-purpose, and
      // the entries read as a block rather than as a navigable hierarchy. The
      // leading matters as much as the gap between entries, because a caption
      // that wraps to a second line is otherwise separated from its own first
      // line by the body's line spacing.
      set block(above: 1pt)
      set par(leading: 2pt)
      set text(font: heading-font, size: body-size)
      let el = it.element
      // A float keeps its position in the text flow as `location()`, so both
      // the printed page number and the link would name the page the figure was
      // *declared* on rather than the one it was *placed* on. Almost everything
      // here floats (the `placement: auto` rule further down), which would leave
      // many entries pointing a page or more short of their target.
      // The caption is laid out together with the float, so its location is the
      // page the reader actually has to turn to. Matching on the caption body
      // is what ties the two together; if that is ever ambiguous, fall back to
      // the old behaviour rather than pointing somewhere arbitrary.
      let placed = {
        let same = query(figure.caption).filter(c => c.body == el.caption.body)
        if same.len() == 1 { same.first().location() } else { el.location() }
      }
      let num = numbering(
        el.numbering,
        ..counter(figure.where(kind: el.kind)).at(el.location()),
      )
      // Three columns rather than one inline run. Inline, the page number sits
      // after a 1fr leader box and can be pushed onto a line of its own when the
      // caption ends near the margin; in its own column it cannot move at all.
      // `bottom` alignment keeps it on the last line of a two-line entry.
      link(
        placed,
        grid(
          columns: (auto, 1fr, auto),
          column-gutter: (0.6em, 0.4em),
          align: (top + left, top + left, bottom + right),
          [#short-supplement(el)~#num],
          first-sentence(el.caption.body) + h(0.4em) +
            box(width: 1fr, repeat([.], gap: 2pt)),
          numbering("1", ..counter(page).at(placed)),
        ),
      )
    }
    for (title, kind) in (
      (LIST_OF_FIGURES.at(language), image),
      (LIST_OF_TABLES.at(language), table),
      (LIST_OF_LISTINGS.at(language), raw),
    ) {
      pagebreak()
      // `outline`'s own title is `outlined: false`, which is why these three
      // lists never appeared in the Contents. Emitting the heading separately
      // puts them there, in the same shape as Acronyms below.
      heading(level: 1, numbering: none, title)
      outline(title: none, target: figure.where(kind: kind))
    }
  }

  if (glossary != none) {
    pagebreak()
    heading(level: 1, GLOSSARY.at(language))
    print-glossary(glossary)
  }

  if (acronyms != none) {
    pagebreak()
    heading(level: 1, ACRONYMS.at(language))
    // glossarium decides whether to list an entry from a state counter, but a
    // `state.update` inside a figure caption never registers, because captions
    // are laid out out of band. An acronym used only in a caption therefore
    // renders and links correctly and still drops out of the list.
    //
    // Filtering the entry list beforehand does not work: the per-entry printer
    // is also what emits the `<key>` label each reference links to, so on the
    // first introspection round the query is empty, no labels are emitted, and
    // every reference fails with "label does not exist".
    //
    // The visibility test sits inside `user-print-gloss`, which is a public
    // hook, while the label is emitted around it. Replacing only that test
    // keeps "list what is referenced" and counts caption references too, since
    // back-references come from a label query rather than from the state.
    // Reproduces the 0.5.10 default rendering; check it if the package moves.
    print-glossary(
      acronyms,
      show-all: true,   // the real test is the one below
      user-print-gloss: (entry, ..args) => context {
        // `deduplicate` collapses several uses on the same page to one number;
        // without it an acronym used twice on a page is listed twice (API: 2, 2).
        let refs = get-entry-back-references(entry, deduplicate: true)
        if refs.len() > 0 {
          set par(hanging-indent: 1em, first-line-indent: 0em)
          strong(delta: 200, emph(entry.short) + [ -- ] + entry.long)
          " "
          refs.join(", ")
        }
      },
    )
  }

  in-frontmatter.update(false)  // end of frontmatter
  set page(numbering: "1")
  counter(page).update(1)       // so the first chapter starts at page 1 (now in arabic numbers)

  // ========== DOCUMENT BODY ========================================
  
  // ---------- Table Format ---------------------------------------

  set table(stroke: (x: none, y: 0.5pt))
  show table: set text(font: heading-font, size: body-size)
  show table.cell.where(y: 0): set text(weight: "bold")
  set table(align: left + horizon)  // cells only; `show table: set align` would also centre a bare table vertically on the page


  // ---------- Heading Format (Part II: H1-H4) ---------------------------------------

  set heading(numbering: "1.1.1")

  show heading: it => {
    set par(leading: 4pt, justify: false)
    text(it, top-edge: 0.75em, bottom-edge: -0.25em)
    v(page-grid, weak: true)
  }

  show heading.where(level: 1): it => {
    // a small positive leading, so that headings running over more than one line
    // (as in the legal backmatter) do not overlap
    set par(leading: 0.5em, justify: false)
    pagebreak()
    context{ 
      if in-body.get() {
        v(chapter-drop)
        place(              // place heading number prominently at the upper right corner
          top + right,
          dx: 9pt,          // slight adjustment for optimal alignment with right margin
          text(counter(heading).display(), 
            top-edge: "bounds",
            size: chapter-num-size, weight: 900, luma(235), 
          )
        )
        text(               // heading text on separate line
          it.body, size: h1-size,
          top-edge: 0.75em, 
          bottom-edge: -0.25em,
        )
      } else {
        v(2 * page-grid)
        // Appendix headings carry their letter; the reference list does not, so
        // an unnumbered heading drops both the letter and the gap after it.
        let label = if it.numbering == none {
          []
        } else {
          counter(heading).display() + h(0.5em)
        }
        text(size: 2 * page-grid, label + it.body)   // appendix
      }
    }
  }

  show heading.where(level: 2): it => {v(16pt) + text(size: h2-size, it)}
  show heading.where(level: 3): it => {v(16pt) + text(size: h3-size, it)}
  show heading.where(level: 4): it => {v(16pt) + smallcaps(text(size: h4-size, weight: "semibold", it.body))}

 // ---------- Body Text ---------------------------------------

  // Figures and tables in the body are placed as floats: a block that does not
  // fit in the space remaining on a page moves to the top or bottom of a page
  // instead of pushing the rest of that page out of the document. Two things are
  // deliberately excluded. Code listings stay in the flow, because a float
  // cannot break across pages and the long listings would be silently
  // overprinted. And the rule is scoped to `body` rather than set globally,
  // because the appendix is almost all tables with no prose between them: there
  // is nothing there for a float to flow around, and a float queued before an
  // appendix heading is flushed onto the page after the break, landing above the
  // heading it belongs under.
  {
    show figure.where(kind: image).or(figure.where(kind: table)): set figure(
      placement: auto,
    )
    body
  }


  // ========== APPENDIX ========================================

  in-body.update(false)
  set heading(numbering: "A.1")
  counter(heading).update(0)

  // ---------- Bibliography ---------------------------------------

  // The reference list is not an appendix. Numbering it "A" pushed the real
  // appendices to B-E and made the bibliography read as one of them; leaving it
  // unnumbered also keeps the heading counter at zero, so the first appendix is A.
  show std-bibliography: set heading(numbering: none)

  // A reference list is scanned, not read, so it does not need the body's line
  // spacing. Entries are set tighter within themselves and separated by a gap
  // that is still three times the intra-entry leading, so each entry stays a
  // visible unit. Tightening further than this saves no further page.
  show std-bibliography: set par(spacing: 9pt, leading: 3pt)

  if bibliography != none {
    set std-bibliography(
      title: REFERENCES.at(language),
      style: bib-style,
    )
    bibliography
  }

  // ---------- Appendix (other contents) ---------------------------------------

  if (appendix != none) {       // the user has to provide heading(s)
    appendix
  }

  // ========== LEGAL BACKMATTER ========================================

  set heading(numbering: it => h(-18pt) + "", outlined: false)


  // ---------- Declaration Of Used Aids And AI Tools ---------------------------

  if (show-declaration-of-tools) {
    declaration-of-tools(
      declaration-of-tools-content,
      language,
    )
  }

  // ---------- Declaration Of Authorship ---------------------------------------

  if (show-declaration-of-authorship) {
    declaration-of-authorship(
      authors,
      title,
      declaration-of-authorship-content,
      date,
      language,
      many-authors,
      city,
      date-format,
    )
  }

}
