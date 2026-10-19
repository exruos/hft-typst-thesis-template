// Appendix. Each `=` heading becomes one lettered appendix (A, B, ...).
// The float placement used in the body does not apply here, so tables and
// listings stay exactly where they are written.
#import "/content/helpers.typ": tbl, lst

= Additional Tables <appendix:tables>

Material that supports the main text but would interrupt it: full configuration listings, complete result tables, questionnaires. Reference it from the body as @appendix:tables.

#figure(
  caption: [Placeholder appendix table],
  tbl(
    columns: (2fr, 3fr, 1fr),
    table.header([*Component*], [*Reference*], [*Version*]),
    [Component A], [`registry.example.org/a`], [`1.0.0`],
    [Component B], [`registry.example.org/b`], [`2.3.1`],
    [Component C], [`registry.example.org/c`], [`0.9.4`],
  ),
) <tab:appendix-example>

= Additional Listings <appendix:listings>

#lst("/code/example-listing.txt", "rust", float: false)[Placeholder listing in the appendix] <lst:appendix-example>
