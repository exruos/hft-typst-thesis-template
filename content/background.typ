= Background <chapter:background>

// `gls` comes from glossarium; `@key` needs no import, `#gls` does.
#import "@preview/glossarium:0.5.10": gls

Introduce the concepts and technologies a reader needs to follow the rest of the thesis, and only those. #lorem(60)

== Fundamental Concept <sec:fundamental-concept>

// Citations: `@key` with a key from refs.bib. A supplement in brackets adds a page or section.
Cite sources with their key from `refs.bib`, for example @Doe2024, a book with a page @Roe2022[p.~42], or online documentation @example-docs. #lorem(50)

// Acronyms: `@key` with a key from acronyms.typ. The first use is expanded.
Acronyms are referenced the same way: the first use of @api is expanded, later uses of @api print only the short form, and @rest:pl gives the plural. #lorem(40)

// Glossary: `#gls("key")` with a key from glossary.typ.
Glossary terms such as #gls("placeholder-term") link to their definition in the glossary. #lorem(40)

== Interaction Model <sec:interaction-model>

Diagrams are kept in their own file next to the chapter, under `content/<chapter>/`, and pulled in with `#include`. @fig:sequence is an example of a sequence diagram built with fletcher.

#include "/content/background/sequence-diagram.typ"

#lorem(80)
