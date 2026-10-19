// Acronyms, rendered with `glossarium`. Use one as `@key` in the text: the
// first use expands to "long (short)", later uses print only the short form.
// Plural: `@key:pl`. Forcing the long form: `#gls("key", long: true)`.
//
// An entry appears in the printed Acronyms list only if it is referenced at
// least once as `@key`; writing "API" as plain text does not register it.
// Keep the list to terms your reader cannot be assumed to know.
#let acronym-entries = (
  (
    key: "api",
    short: "API",
    long: "Application Programming Interface",
  ),
  (
    key: "rest",
    short: "REST",
    long: "Representational State Transfer",
  ),
  (
    key: "ci",
    short: "CI",
    long: "Continuous Integration",
  ),
)
