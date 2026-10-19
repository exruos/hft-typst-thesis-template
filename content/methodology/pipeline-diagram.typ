// Example 1: a left-to-right pipeline.
//
// Shows the basics: grid coordinates `(x, y)`, the shared `nd` box helper,
// arrows with labels, and a bent feedback edge. Included from
// `content/methodology.typ` with `#include`; the label after the figure makes
// it referenceable as `@fig:pipeline`.
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import "/content/diagram-common.typ": dia, nd, lbl, col-blue, col-yellow, col-green, col-grey

#figure(
  // `none` keeps the diagram where it is written. Remove the line to let the
  // template float it to the top or bottom of a page instead.
  placement: none,
  caption: [
    Placeholder pipeline from input to result. The first sentence of a caption
    is what appears in the List of Figures, so make it a short title; the rest
    can explain how to read the diagram.
  ],
  dia(diagram(
    // horizontal and vertical gap between grid cells
    spacing: (10mm, 6mm),
    node-inset: 4pt,
    edge-stroke: 0.7pt,

    // nodes: position, fill, body
    nd((0, 0), col-grey,   [*Input*\ raw data], w: 22mm),
    nd((1, 0), col-blue,   [*Stage A*\ prepare], w: 24mm),
    nd((2, 0), col-yellow, [*Stage B*\ process], w: 24mm),
    nd((3, 0), col-green,  [*Result*\ report], w: 22mm),

    // edges: from, to, arrow style, optional label
    edge((0, 0), (1, 0), "-|>"),
    edge((1, 0), (2, 0), "-|>", text(6.5pt)[step], label-side: left),
    edge((2, 0), (3, 0), "-|>"),

    // a feedback loop: `bend` curves the edge, a dashed stroke marks it as optional
    edge((2, 0), (1, 0), "-|>", bend: 40deg, stroke: (dash: "dashed"),
      text(6.5pt)[retry], label-side: left),

    // free annotation below the pipeline
    lbl((1.5, 1.8), [stages A and B repeat until the output is valid]),
  )),
) <fig:pipeline>
