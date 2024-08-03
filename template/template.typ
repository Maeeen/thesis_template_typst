/// This file defines multiple components that can be used
/// to generate a document.


/// This function generates a title page for a document. Sets the title, author, and date of the document.
/// *Example*:
/// ```typc
/// #title_page(
///  title: "Why AI may not be the solution to all our problems", 
///  school: "École Polytechnique Fédérale de Lausanne",
///  author: "Jordan Carter",
///  type: "Master Thesis",
///  address: [
///    Someplace around the world
///  ],
///  body: [
///    Definitely not approved by the Examining Committee:
///    
///    Prof. Dr. sc. ETH John Doe \
///    Thesis Advisor
///  ],
///  date: datetime(year: 2024, month: 8, day: 1),
///  logos: (
///    rect(width: 1in, height: 1in, fill: red),
///    rect(width: 1in, height: 1in, fill: blue)
///  )
/// )
/// ```
///
/// - title (string, content): The title of the document.
/// - school (string, content): The name of the school.
/// - author (string, content): The author of the document.
/// - type (string, content): The type of the document.
/// - address (list of strings, content): The address of the school.
/// - body (content): The content of the title page.
/// - date (datetime): Optional: the date of the document. If not provided, the current date is used.
/// - logos (list of content): Optional: logos to display on the title page.
/// -> content
#let title_page(
  title: "Default Title",
  school: "École Polytechnique Fédérale de Lausanne",
  author: "The Student",
  type: "Master Thesis",
  address: [
    EPFL IC IINFCOM HEXHIVE \
    BC 160 (Bâtiment BC) \
    Station 14 \
    CH-1015 Lausanne \
  ],
  body: [],
  date: none,
  logos: (),
) = {
  let date = if date == none { datetime.today() } else { date }

  set document(title: title, author: author, date: date)

  align(center)[
    #if logos != none {
      grid(
        columns: logos.map(_ => 1fr),
        align: horizon,
        gutter: 1em,
        ..logos
      )
    }
    #v(1fr)
    #text(school, size: 17pt)
    #v(2em)
    #text(title, size: 17pt)
    #v(2em)
    #text("by " + author, size: 14pt)
    #v(2fr)
    #text(type, size: 17pt)
    #v(2fr)
  ]

  body

  align(center)[
    #address
    #v(1em)
    #text(date.display("[month repr:long] [day padding:none], [year]"))
    #v(1fr)
  ]

  pagebreak(weak: true)
}


#let vertical-separator = v(2in)

/// This function generates a dedication page for a document.
/// *Example*:
/// ```typc
/// #dedication[
///   #align(right)[
///     #quote("Follow the white rabbit...", attribution: "The Matrix", block: true)
///   ]
/// 
///   #align(center)[
///     Dedicated to my pet bunny.
///   ]
/// 
///   The dedication is usually a short inspirational quote.
///   Define your dedication here.
/// ]```
///
/// - body (content): The content of the dedication page.
#let dedication(
  body
) = {
  pagebreak(to: "even")
  vertical-separator
  body
}


/// --- Page counting untils ---
#let page-number-reset = counter(page).update(1)
#let enable-counting = {
  page-number-reset
  [#[]<enable-page-numbering>]
}

#let disable-counting = {
  [#[]<disable-page-numbering>]
  page-number-reset
}

#let setup-counting = {
  
}

/// --- Page breaks ---

#let new_page(body) = {
  vertical-separator
  body
}

#let setup-