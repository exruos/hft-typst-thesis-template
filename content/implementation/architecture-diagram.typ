// Example 2: a layered architecture with grouped components.
//
// Shows named nodes (`name: <...>`) that edges can refer to instead of
// coordinates, and `enclose`, which draws a frame around a group of nodes.
// Included from `content/implementation.typ`; referenced as `@fig:architecture`.
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import "/content/diagram-common.typ": dia, tight, nd, lbl, col-blue, col-yellow, col-green, col-red, col-grey

#figure(
  placement: none,
  caption: [
    Placeholder layered architecture. Blue boxes are ingoing interfaces, yellow
    the application logic, green the domain model and red the infrastructure;
    the dashed frame groups the parts deployed together.
  ],
  dia(diagram(
    spacing: (8mm, 8mm),
    node-inset: 4pt,
    edge-stroke: 0.7pt,

    nd((1, 0), col-grey, [*Client*], w: 24mm, name: <client>),

    nd((0, 1), col-blue,   [REST controller], name: <ctrl>),
    nd((2, 1), col-blue,   [Message consumer], name: <consumer>),
    nd((1, 2), col-yellow, [Use cases\ (application logic)], w: 40mm, name: <usecases>),
    nd((1, 3), col-green,  [Domain model], name: <domain>),
    nd((0, 3), col-red,    [Database adapter], name: <db-adapter>),
    nd((2, 3), col-red,    [External service\ client], name: <ext>),

    // Group frame. `enclose` takes node names or coordinates; the frame is
    // itself a node, so it gets a stroke, a fill and an inset like any other.
    // Fill it with `none` so the boxes inside stay readable.
    node(
      enclose: (<ctrl>, <consumer>, <usecases>, <domain>, <db-adapter>, <ext>),
      stroke: (paint: gray, dash: "dashed", thickness: 0.5pt),
      corner-radius: 4pt,
      inset: 8pt,
      fill: none,
      name: <service>,
    ),
    // a label in the free space inside the group frame
    lbl((0, 2), [*Service*], size: 7pt),

    // edges between named nodes; `"--|>"` is a dashed arrow
    edge(<client>, <ctrl>, "-|>", text(6.5pt)[HTTP], label-side: right),
    edge(<client>, <consumer>, "--|>", text(6.5pt)[events], label-side: left),
    edge(<ctrl>, <usecases>, "-|>"),
    edge(<consumer>, <usecases>, "-|>"),
    edge(<usecases>, <domain>, "-|>"),
    edge(<usecases>, <db-adapter>, "-|>"),
    edge(<usecases>, <ext>, "-|>"),
  )),
) <fig:architecture>
