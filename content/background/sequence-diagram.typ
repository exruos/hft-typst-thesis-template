// Example 3: a sequence diagram with lifelines.
//
// Fletcher has no built-in sequence diagram, but one is easy to build from
// nodes and edges: each actor is a header box with a dashed edge running down
// as its lifeline, and every message is a horizontal arrow at its own row `y`.
// The helpers below are local because only this kind of diagram needs them;
// move them to `diagram-common.typ` once a second sequence diagram exists.
// Included from `content/background.typ`; referenced as `@fig:sequence`.
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import "/content/diagram-common.typ": tight, col-blue, col-yellow, col-red, col-grey

#let lane-w = 26mm  // width of every lifeline header
#let hdr-h = 10mm   // fixed header height, so one-line and two-line headers match
#let rows = 6       // the lifelines run down to this row

// Actor lifeline: header box plus a dashed lifeline running down the diagram.
// Returns an array, so it is spread into the diagram with `..actor(...)`.
#let actor(x, fill, body) = (
  node((x, 0),
    box(width: lane-w, height: hdr-h, inset: 0pt,
      tight(7pt, body, align-to: center + horizon)),
    fill: fill, stroke: 0.5pt, corner-radius: 2pt, shape: fletcher.shapes.rect),
  edge((x, 0.4), (x, rows + 0.4), stroke: (paint: gray, dash: "dashed", thickness: 0.4pt)),
)

// Message label: step number plus text.
#let msg(n, body) = tight(7pt)[*#n* #h(1.5pt) #body]

// Rightward and leftward messages. A leftward arrow needs `right` to put its
// label on the same side (above) as a rightward one.
#let rmsg(y, a, b, n, body) = edge(
  (a, y), (b, y), "-|>", msg(n, body), label-side: left)
#let lmsg(y, a, b, n, body) = edge(
  (a, y), (b, y), "-|>", msg(n, body), label-side: right, stroke: (dash: "dashed"))

// Self-action note pinned onto a lifeline
#let note(x, y, fill, body) = node(
  (x, y), box(width: lane-w, inset: 0pt, tight(7pt, body)),
  fill: fill, stroke: (paint: gray, thickness: 0.4pt), corner-radius: 2pt,
  shape: fletcher.shapes.rect,
)

#figure(
  placement: none,
  caption: [
    Placeholder request sequence between a client, a service and its database.
    Solid arrows are requests, dashed arrows responses; the numbers give the
    order of the steps.
  ],
  {
    // neutralize the document's leading for everything inside the diagram
    set par(leading: 0.4em, spacing: 0em, justify: false)
    set text(hyphenate: false)
    diagram(
      spacing: (12mm, 5mm),
      node-inset: 2pt,
      label-sep: 0.2em, // gap between an arrow and its label
      node-stroke: none,

      // ---- lifelines -------------------------------------------------------
      ..actor(0, col-grey,   [*Client*]),
      ..actor(1, col-blue,   [*Service*\ API layer]),
      ..actor(2, col-red,    [*Database*]),

      // ---- messages, one row each ------------------------------------------
      rmsg(1, 0, 1, 1)[request],
      note(1, 2, col-yellow)[*2* validate input],
      rmsg(3, 1, 2, 3)[query],
      lmsg(4, 2, 1, 4)[rows],
      lmsg(5, 1, 0, 5)[response],
    )
  },
) <fig:sequence>
