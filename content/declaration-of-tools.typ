// Declaration on the use of aids and AI tools. The heading and the
// introductory sentence come from `template/locale.typ`; list every tool you
// used and what you used it for. Check your examination regulations for the
// required wording.
#import "/content/helpers.typ": tbl

#tbl(
  columns: (0.7fr, 2.4fr),
  align: (left + top, left + top),
  table.header(
    [*Tool*], [*Purpose in this thesis*]
  ),

  [Tool name\ (vendor, version)],
  [
    - First purpose, e.g. language checking of text passages.
    - Second purpose, e.g. code completion during implementation.
  ],

  [Another tool],
  [Purpose.],
)

#v(1em)

Describe how the output of these tools was reviewed, and which parts of the work were done without them. #lorem(40)
