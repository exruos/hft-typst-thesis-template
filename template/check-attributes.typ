#let check-attributes(
  title,
  authors,
  language,
  type-of-thesis,
  show-declaration-of-authorship,
  show-table-of-contents,
  show-abstract,
  abstract,
  appendix,
  university,
  university-location,
  supervisor,
  date,
  city,
  bibliography,
  glossary,
  acronyms,
  bib-style,
  logo-left,
  logo-right,
  university-short,
  math-numbering,
  ignored-link-label-keys-for-highlighting,
) = {

  
  // Check availability of title

  if (title == none or title == "") {
    panic("Title is missing. Specify a title in the 'title' attribute of the template.")
  }


  // Check type of boolean attributes

  let boolean-attributes = (
    show-table-of-contents: show-table-of-contents,
    show-declaration-of-authorship: show-declaration-of-authorship,
    show-abstract: show-abstract,
  )

  for (key, attribute) in boolean-attributes {
    if (type(attribute) != bool) {
      panic("Attribute '" + key + "' is invalid. Specify 'true' or 'false' in the '" + key + "' attribute of the template.")
    }
  }


  // Check type and content (some shouldn't be empty) of string attributes

  let string-attributes = (
    university: university,
    university-short: university-short,
  )

  // required string attributes
  for (key, attribute) in string-attributes {
    if (type(attribute) != str or attribute.len() == 0) {
      panic("Attribute '" + key + "' is missing. Specify a " + key + " in the '" + key + "' attribute of the template.")
    }
  }

  // optional string attribute
  let optional-string-attributes = (
    type-of-thesis: type-of-thesis,
    bib-style: bib-style,
    math-numbering: math-numbering,
  )
  for (key, attribute) in optional-string-attributes {
    if (attribute != none and (type(attribute) != str or attribute.len() == 0)) {
      panic("Attribute '" + key + "' is invalid. Specify a string in the '" + key + "' attribute of the template.")
    }
  }


  // Check type of attributes containing `length`-values

  let length-attributes = ()

  for (key, attribute) in length-attributes {
    if (type(attribute) != length) {
      panic("Attribute '" + key + "' is invalid. Specify a length in the '" + key + "' attribute of the template.")
    }
  }


  // Check consistency of all attributes related to `authors`

  if (authors == none or authors == ()) {
    panic("Author is missing. Specify authors in the 'authors' attribute of the template.")
  }

  let max-authors = 8

  if (authors.len() > max-authors) {
    panic("Too many authors. Specify a maximum of " + str(max-authors) + " authors in the 'authors' attribute of the template. To increase the maximum number of authors (max. 8), change one of the following attributes: 'at-university', 'type-of-thesis'. (See the package documentation for more information.)")
  }

  for author in authors {
    if ("name" not in author or author.name == none or author.name == "") {
      panic("Author name is missing. Specify a name for each author in the 'authors' attribute of the template.")
    }

    if ("student-id" not in author or author.student-id == none or author.student-id == "") {
      panic("Student ID of '" + author.name + "' is missing. Specify a student ID for each author in the 'authors' attribute of the template.")
    }

    if ("course-of-studies" not in author or author.course-of-studies == none or author.course-of-studies == "") {
      panic("Course of studies of '" + author.name + "' is missing. Specify a course of studies for each author in the 'authors' attribute of the template.")
    }

    if ("company" in author) {
      panic("Company of '" + author.name + "' is not allowed. Remove the 'company' object from the author.")
    }
  }


  // Check allowed languages

  if (language != "en" and language != "de") {
    panic("Language is invalid. Specify 'en' for English or 'de' for German in the 'language' attribute of the template.")
  }


  // Check correctness of `date`

  if (
    type(date) != datetime and (
      type(date) != array or date.len() != 2 or type(date.at(0)) != datetime or type(date.at(1)) != datetime
    )
  ) {
    panic("Date is invalid. Specify a datetime in the 'date' attribute of the template to display a specific date or use a array containing two datetime elements to display a date range.")
  }


  // Checkt type and content of image-attributes

  let image-attributes = (
    logo-left: logo-left,
    logo-right: logo-right,
  )

  for (key, attribute) in image-attributes {
    if (type(attribute) != content and attribute != none) {
      panic("Attribute '" + key + "' is invalid. Specify an image in the '" + key + "' attribute of the template.")
    }
  }


  // Check type of `glossary`
  if (glossary != none and type(glossary) != array) {
    panic("Type of `glossary` is invalid. It must be an array of arrays")
  }

  // Check type of `acronyms`
  if (acronyms != none and type(acronyms) != array) {
    panic("Type of `acronyms` is invalid. It must be an array of arrays")
  }
  
  
  // Check availability of `bibliography`

  if (type(bibliography) != content and bibliography != none) {
    panic("Bibliography is invalid. Specify a bibliography in the 'bibliography' attribute of the template.")
  }


  // Check correctness of `supervisor`

  if (
    type(supervisor) != dictionary or (
      "company" not in supervisor or supervisor.company == none or supervisor.company == ""
    ) and ("university" not in supervisor or supervisor.university == none or supervisor.university == "")
  ) {
    panic("Supervisor(s) is/are invalid. Specify a supervisor either for the company and/or the university in the 'supervisor' attribute of the template.")
  }


  // Check type and content (not empty) of string array attributes
  
  let string-array-attributes = (
    ignored-link-label-keys-for-highlighting: ignored-link-label-keys-for-highlighting,
  )

  for (key, attribute) in string-array-attributes {
    if (type(attribute) != array) {
      panic("Attribute '" + key + "' is invalid. Specify an array of strings in the '" + key + "' attribute of the template.")
    } else if (attribute.len() > 0) {
      if (type(attribute.at(0)) != str) {
        panic("Attribute '" + key + "' is invalid. Specify an array of strings in the '" + key + "' attribute of the template.")
      }
    }
  }
}