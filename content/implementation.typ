= Implementation <chapter:implementation>

#import "/content/helpers.typ": tbl, lst

Document what was built, focusing on the decisions that matter for the results rather than on the code itself. #lorem(50)

== Architecture <sec:architecture>

@fig:architecture shows the overall structure.

#include "/content/implementation/architecture-diagram.typ"

#lorem(60)

@tab:components maps the concepts onto the concrete technologies. Wrap tables in `tbl` from `content/helpers.typ`, which switches off the justified body spacing inside cells.

#figure(
  caption: [Realization of the architectural concepts],
  tbl(
    columns: (1.4fr, 2fr, 2fr),
    align: (left + horizon, left + horizon, left + horizon),
    table.header([*Concept*], [*Variant A*], [*Variant B*]),
    [Module boundary], [Package per module], [Crate per module],
    [Ingoing adapter], [REST controller], [HTTP router],
    [Outgoing adapter], [Repository], [SQL mapper],
  ),
) <tab:components>

== Code Listings <sec:listings>

Code is kept in `/code` and included with `lst`, which takes the path, the language and a caption. @lst:example shows an example.

#lst("/code/example-listing.txt", "rust")[Placeholder code listing] <lst:example>

Short inline code is written in backticks, e.g. `word_count`. #lorem(50)
