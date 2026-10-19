// Node helpers and color coding shared by all fletcher diagrams. Kept in one
// module rather than repeated per diagram, so the palette cannot drift between
// them. Import what a diagram needs:
//
//   #import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
//   #import "/content/diagram-common.typ": dia, tight, nd, lbl, col-blue, ...
//
// Fletcher manual: https://typst.app/universe/package/fletcher
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

// ---------------------------------------------------------------------------
// Text inside diagrams
//
// Node text must not inherit the thesis body's line spacing, otherwise every
// box grows by the document's leading and the diagram stretches vertically.
// Wrap the whole diagram in `dia(...)`, and node bodies in `tight(...)`.
// ---------------------------------------------------------------------------
#let tight(size, body, align-to: center) = {
  set par(leading: 0.4em, spacing: 0em, justify: false)
  set text(size: size, hyphenate: false)
  align(align-to, body)
}

#let dia(body) = {
  set par(leading: 0.4em, spacing: 0em, justify: false)
  set text(hyphenate: false)
  body
}

// ---------------------------------------------------------------------------
// Color coding. Give each color one meaning and keep it across the thesis
// (e.g. blue = external interfaces, red = infrastructure), and say what the
// colors mean in the caption of the first diagram that uses them.
// ---------------------------------------------------------------------------
#let col-blue   = rgb("#e8f0fe")
#let col-yellow = rgb("#fff6d6")
#let col-green  = rgb("#e6ffe6")
#let col-red    = rgb("#fde8e8")
#let col-violet = rgb("#f0e6ff")
#let col-grey   = rgb("#ececec")

// ---------------------------------------------------------------------------
// Nodes
//
// Uniform box node. `shape` must be given explicitly, otherwise fletcher picks
// an ellipse for roughly square content. `w` fixes the width so that boxes in
// one column line up; keep the whole diagram inside the text block, whose
// usable width is about 136 mm with the default margins.
// ---------------------------------------------------------------------------
#let nd(pos, fill, body, w: 30mm, size: 7pt, name: none) = node(
  pos, box(width: w, inset: 0pt, tight(size, body)),
  fill: fill, stroke: 0.5pt, corner-radius: 2pt, shape: fletcher.shapes.rect,
  name: name,
)

// Free-standing label without a frame, for annotations next to nodes.
#let lbl(pos, body, size: 6.5pt) = node(pos, tight(size, body), stroke: none)
