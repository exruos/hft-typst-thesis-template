# Thesis Template (Typst)

> **Unofficial.** This is a personal project. It is not provided, reviewed or endorsed by HFT Stuttgart. Check your faculty's current formatting requirements and your examination regulations before you submit.

An unofficial Typst template for a bachelor's or master's thesis at HFT Stuttgart, built for **computer science and software engineering topics**: theses where source code, architecture diagrams and measured results are as much a part of the argument as the prose. It ships a complete chapter structure with placeholder text, laid out for that kind of work (Background, Related Work, Methodology, Implementation, Evaluation, Discussion).

What it handles for you:

- **Source code listings** from files in `code/`, with syntax highlighting, line numbers and a language badge ([codly](https://typst.app/universe/package/codly)). Short listings float, long ones break across pages, and all of them appear in a List of Listings.
- **Diagrams as code** with [fletcher](https://typst.app/universe/package/fletcher): flowcharts, layered architectures and sequence diagrams, with three worked examples and shared helpers. Diagrams live in version control next to the text and keep the document's fonts.
- **Plots and tables** for evaluation results, with SVG figures and a table helper that keeps narrow cells readable.
- **References, acronyms and a glossary**: technical vocabulary like API or REST is expanded on first use and listed automatically.
- **Title page, declaration of authorship and declaration of AI tools** in English or German.

**See the result first:** [`example.pdf`](example.pdf) is this template compiled as it is, placeholder text included (31 pages).

## Used in practice

This template is extracted from my own master's thesis (Software Technology, HFT Stuttgart, 2026). That thesis ran to 155 pages with 18 fletcher diagrams, 34 result plots, code listings in several languages, over 100 references and an appendix of long tables, and it was submitted as built by this template. The layout decisions documented in the comments of `template/lib.typ` (float placement, list-of-figures entries, acronym handling) are fixes for problems that came up while writing it.

## Quick start

1. Install [Typst](https://typst.app) (developed with 0.15) and the fonts **Fira Sans** (text) and **Fira Code** (code listings). Both are free under the SIL Open Font License:
   - Fira Sans: [Google Fonts](https://fonts.google.com/specimen/Fira+Sans) or [github.com/mozilla/Fira](https://github.com/mozilla/Fira)
   - Fira Code: [github.com/tonsky/FiraCode](https://github.com/tonsky/FiraCode/releases) (download the latest release zip and install the `ttf` files)

   On Windows, select the `.ttf` files and choose *Install for all users*. On Linux, install your distribution's package (e.g. `fonts-firacode`) or copy the files to `~/.local/share/fonts`. Run `typst fonts` to check that Typst finds them. If a font is missing, Typst warns `unknown font family` and falls back to a default font, so the document still compiles but looks different. You can also skip installing them: put the files in a `fonts/` folder and build with `typst watch --font-path fonts main.typ`.
2. Fill in your metadata in `main.typ` (title, author, supervisors, dates, logos).
3. Build:

   ```bash
   typst watch main.typ
   ```

   Packages (`codly`, `hydra`, `glossarium`, `fletcher`, `drafting`) are downloaded on the first build.

In VS Code, the [Tinymist](https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist) extension gives a live preview.

## Where files go

```
thesis-template/
├─ main.typ                 # metadata + chapter order. Start here.
├─ refs.bib                 # bibliography (BibLaTeX; JabRef works well)
├─ acronyms.typ             # acronym list         -> @key
├─ glossary.typ             # glossary entries     -> #gls("key")
├─ template/                # the layout. Normally you do not touch this.
│  ├─ lib.typ               #   page setup, headings, lists, floats, appendix, back matter
│  ├─ locale.typ            #   fixed strings in English and German
│  └─ ...                   #   title page, declarations, attribute checks
├─ content/
│  ├─ <chapter>.typ         # one file per chapter, included from main.typ
│  ├─ <chapter>/            # everything that belongs to one chapter, mostly diagrams
│  │  └─ <name>-diagram.typ #   one fletcher diagram per file, included from the chapter
│  ├─ helpers.typ           # tbl() for tables, lst() for code listings
│  ├─ diagram-common.typ    # shared fletcher helpers and color palette
│  ├─ draft-notes.typ       # margin notes for drafting (remove before submission)
│  ├─ abstract.typ          # read as plain text (no markup)
│  ├─ acknowledgements.typ
│  ├─ declaration-of-tools.typ  # table of aids / AI tools used
│  └─ appendix.typ          # each `=` heading becomes appendix A, B, ...
├─ code/                    # code excerpts for listings, as .txt
├─ figures/                 # logos and static images
│  └─ results/              # generated plots (export as SVG)
└─ references/              # source PDFs of your references (ignored by git)
```

All paths inside `.typ` files are absolute from the project root (`"/figures/..."`, `"/content/..."`), so a file can be moved without breaking its imports.

## Conventions

**Labels.** Every chapter, section, figure, table and listing you refer to gets a label with a prefix:

| Prefix | For | Reference |
| --- | --- | --- |
| `<chapter:...>` | chapters | `@chapter:evaluation[Chapter]` |
| `<sec:...>` | sections | `@sec:metrics` |
| `<fig:...>` | figures and diagrams | `@fig:pipeline` |
| `<tab:...>` | tables | `@tab:components` |
| `<lst:...>` | code listings | `@lst:example` |
| `<eq:...>` | equations | `@eq:efficiency` |
| `<appendix:...>` | appendices | `@appendix:tables` |

**Captions.** The List of Figures/Tables/Listings shows only the **first sentence** of each caption. Write that sentence as a short title, then explain the figure in the sentences that follow.

**Floats.** Figures and tables in the body float to the top or bottom of a page automatically. Add `placement: none` to a `figure` to keep it exactly where it is written. Content in the appendix never floats.

**Imports.** `#include` does not share scope. A chapter that uses `tbl`, `lst`, `gls` or the draft notes must import them itself (see the top of `implementation.typ` and `background.typ`).

## How to ...

**Add a chapter.** Create `content/<name>.typ` starting with `= Title <chapter:name>`, and add `#include "/content/<name>.typ"` to `main.typ` in reading order.

**Cite a source.** Add the BibLaTeX entry to `refs.bib` and write `@key` (with a page: `@key[p.~42]`). Only cited entries are printed. The citation style is set with `bib-style` in `main.typ` (default `"ieee"`).

**Add an acronym.** Add an entry to `acronyms.typ` and write `@key` in the text. The first use is expanded, `@key:pl` gives the plural. An acronym appears in the Acronyms list only if it is used at least once as `@key`.

**Add a glossary term.** Add an entry to `glossary.typ` and write `#gls("key")` (import it with `#import "@preview/glossarium:0.5.10": gls`). Remove `glossary:` from `main.typ` if you do not need a glossary.

**Add a table.** Use `tbl(...)` from `content/helpers.typ` inside a `figure`. It turns off the justified, widely spaced body text inside cells. See `@tab:components` in `implementation.typ`.

**Add a code listing.** Save the excerpt as `code/<name>.txt` and write

```typ
#lst("/code/<name>.txt", "rust")[Caption.] <lst:name>
```

Short listings float, and longer ones (> 44 lines) stay in the flow so they can break across pages. Pass `float: false` to keep a short one in place.

**Add a plot.** Export it as SVG into `figures/results/` and include it with `image("/figures/results/<name>.svg", width: 100%)` inside a `figure` (see `evaluation.typ`).

## Diagrams with fletcher

Each diagram lives in its own file, `content/<chapter>/<name>-diagram.typ`. The file contains the complete `#figure(...) <fig:name>`, and the chapter pulls it in with `#include`. This keeps chapter files readable and lets you work on a diagram in isolation.

The three examples, from simple to advanced:

| File | Shows |
| --- | --- |
| `content/methodology/pipeline-diagram.typ` | grid coordinates, `nd` boxes, labelled arrows, a bent dashed feedback edge, a free label |
| `content/implementation/architecture-diagram.typ` | named nodes (`name: <x>`), edges between names, a dashed group frame with `enclose` |
| `content/background/sequence-diagram.typ` | a sequence diagram from lifelines and message arrows, built with small local helpers |

The minimum for a new diagram:

```typ
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import "/content/diagram-common.typ": dia, nd, lbl, col-blue, col-green

#figure(
  placement: none,
  caption: [Short title. Longer explanation.],
  dia(diagram(
    spacing: (10mm, 6mm),          // gap between grid columns, rows
    node-inset: 4pt,
    edge-stroke: 0.7pt,
    nd((0, 0), col-blue,  [*A*\ detail]),
    nd((1, 0), col-green, [*B*]),
    edge((0, 0), (1, 0), "-|>", text(6.5pt)[label]),
  )),
) <fig:my-diagram>
```

Things that will save you time:

- **Wrap diagrams in `dia(...)` and node text in `tight(...)`** (`nd` does the latter for you). Otherwise node text inherits the body's large line spacing and every box grows taller.
- **Give nodes an explicit shape.** Without `shape: fletcher.shapes.rect`, fletcher draws roughly square content as an ellipse. `nd` sets the shape for you.
- **Fix box widths** with `nd(..., w: 30mm)`, so that boxes in a column line up. The text block is about **136 mm** wide; keep the whole diagram inside it.
- **Arrow styles:** `"-|>"` solid arrow, `"--|>"` dashed arrow, `"<|-|>"` both ways, `"-"` plain line. Curve an edge with `bend: 30deg`.
- **Colors:** use the palette in `diagram-common.typ`. Give each color one meaning across the whole thesis and say what it means in the caption.
- Fractional coordinates such as `(1.5, 0.8)` are allowed and useful for labels and fine positioning.

The fletcher manual is linked from its [package page](https://typst.app/universe/package/fletcher).

## Drafting

`content/draft-notes.typ` provides color-coded margin notes: `#draft[...]` (rewrite), `#cut[...]` (candidate for cutting) and `#check-ref[...]` (citation missing or unverified). `introduction.typ` shows how they are used. Before submission, remove every use and the import. To find them:

```bash
grep -rn "#draft\|#cut\[\|#check-ref\|draft-notes" main.typ content/
```

## Language

Set `language: "de"` in `main.typ` to switch all fixed labels (Contents, Abstract, List of Figures, declarations, title page) to German. The strings are in `template/locale.typ`.

## Before submission

- [ ] All metadata in `main.typ` filled in, placeholder logo replaced or removed
- [ ] No draft notes left (grep above)
- [ ] No `#lorem` and no placeholder text left: `grep -rn "lorem\|Placeholder" content/`
- [ ] Declaration of tools filled in (`content/declaration-of-tools.typ`)
- [ ] Unused acronyms, glossary entries and figures removed
- [ ] `typst compile main.typ` runs without warnings
- [ ] `example.pdf` deleted (it shows the template, not your thesis)

To update `example.pdf` after you change the template itself, run `typst compile main.typ example.pdf`.

## Credits and license

The layout in `template/` is adapted from [clean-dhbw-typst-template](https://github.com/roland-KA/clean-dhbw-typst-template) by Roland Schätzle, which is itself a fork of [typst-dhbw-template](https://github.com/DannySeidel/typst-dhbw-template) by Danny Seidel. Both are MIT-licensed, and this template is too: see [LICENSE](LICENSE), which keeps the original copyright notices.

The HFT logo in `figures/hft.svg` is a trademark of HFT Stuttgart and is not covered by the MIT license. Use it only as your university's rules allow.
