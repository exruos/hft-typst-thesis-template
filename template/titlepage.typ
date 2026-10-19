#import "locale.typ": *

#let titlepage(
  authors,
  date,
  start-date,
  title-font,
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
) = {
  // ---------- Page Setup ---------------------------------------

  set page(
    // identical to document
    margin: (top: 4cm, bottom: 3cm, left: 4cm, right: 3cm),
  )
  // The whole page in `title-font`, all elements centered
  set text(font: title-font, size: page-grid)
  set align(center)

  // ---------- Logo(s) ---------------------------------------

  if logo-left != none and logo-right == none {
    // one logo: centered
    place(
      top + center,
      dy: -3 * page-grid,
      box(logo-left, height: 3 * page-grid),
    )
  } else if logo-left != none and logo-right != none {
    // two logos: left & right
    place(
      top + left,
      dy: -4 * page-grid,
      box(logo-left, height: 3 * page-grid),
    )
    place(
      top + right,
      dy: -4 * page-grid,
      box(logo-right, height: 3 * page-grid),
    )
  }

  // ---------- Title ---------------------------------------

  v(4 * page-grid)
  // university
  text(university + [ ] + "\n" + university-faculty)

  v(1 * page-grid)

  text(weight: "bold", fill: luma(80), size: 1.5 * page-grid, title)
  v(page-grid)

  // ---------- Sub-Title-Infos ---------------------------------------
  //
  // type of thesis (optional)
  if (type-of-thesis != none and type-of-thesis.len() > 0) {
    align(center, text(size: page-grid, type-of-thesis))
    v(0.25 * page-grid)
  }

  // course of studies
  text(TITLEPAGE_SECTION_B.at(language) + authors.map(author => author.course-of-studies).dedup().join(" | "))
  v(0.25 * page-grid)



  // ---------- Author(s) ---------------------------------------

  place(
    bottom + center,
    dy: -11 * page-grid,
    grid(
      columns: 100%,
      gutter: if (many-authors) {
        14pt
      } else {
        1.25 * page-grid
      },
      ..authors.map(author => align(
        center,
        {
          text(author.name)
        },
      ))
    ),
  )

  // ---------- Info-Block ---------------------------------------

  set text(size: 11pt)
  place(
    bottom + center,
    grid(
      columns: (auto, auto),
      row-gutter: 1em,
      column-gutter: 1em,
      align: (right, left),

      // start date (optional, omitted entirely when not given)
      ..if (start-date != none) {
        (
          text(weight: "bold", fill: luma(80), TITLEPAGE_START_DATE.at(language)),
          text(start-date.display(date-format)),
        )
      },

      // submission date
      text(weight: "bold", fill: luma(80), TITLEPAGE_DATE.at(language)),
      text(
        if (type(date) == datetime) {
          date.display(date-format)
        } else {
          date.at(0).display(date-format) + [ -- ] + date.at(1).display(date-format)
        },
      ),

      // students
      align(text(weight: "bold", fill: luma(80), TITLEPAGE_STUDENT_ID.at(language)), top),
      stack(
        dir: ttb,
        for author in authors {
          text([#author.student-id])
          linebreak()
        },
      ),

      // university supervisor
      ..if ("university" in supervisor) {
        (
          text(
            weight: "bold",
            fill: luma(80),
            TITLEPAGE_SUPERVISOR.at(language) + university-short + [:],
          ),
          if (type(supervisor.university) == str) { text(supervisor.university) },
        )
      },

      // company supervisor
      ..if ("company" in supervisor) {
        (
          text(weight: "bold", fill: luma(80), TITLEPAGE_COMPANY_SUPERVISOR.at(language)),
          if (type(supervisor.company) == str) { text(supervisor.company) },
        )
      },


      // empty row for spacing
      hide[.], hide[.],
      
    ),
  )
}
