/// This file defines multiple components that can be used
/// to generate a document.

// --- Utils ---
#let in-outline = state("in-outline", false)


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


#let vertical-separator = v(1.5in)

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


// --- Page counting utils ---

/// The resets the page counter number
#let page-number-reset = counter(page).update(1)

/// Shows the page numbers for the current and following pages
#let page-number-show = {
  [#[]<enable-page-numbering>]
}

/// Hides the page numbers for the current and following pages
#let page-number-hide = {
  [#[]<hide-page-numbering>]
}

/// Setups the page numbers.
/// ```typc
/// #show: setup-page-counting
/// ```
#let setup-page-counting(r) = {
  set page(footer: context {
    let previous-enable-tags = query(selector(<enable-page-numbering>).before(here())).sorted(key: k => k.location().position().y)
    let previous-hide-tags = query(selector(<hide-page-numbering>).before(here())).sorted(key: k => k.location().position().y)
    if previous-enable-tags.len() == 0 {
      return none
    }
    if previous-hide-tags.len() == 0 or previous-enable-tags.last().location().position().y > previous-hide-tags.last().location().position().y {
      align(center)[#counter(page).display()]
    }
  })
  r
}

// --- Page breaks ---

/// Inserts a page break.
#let new-page = {
  pagebreak(weak: true)
  vertical-separator
}

// --- First page title ---

/// Generates a new page with given title.
/// - title (content): The title of the page.
/// - outlined (bool): Whether the title should be outlined in the table of contents.
#let page-title(title: [Abstract], outlined: true) = {
  new-page
  text(weight: "bold", size: 26pt, heading(numbering: none, outlined: outlined, strong(title)))
  v(4em)
}

/// Generates a new page with given title.
/// - title (content): The title of the page.
#let chapter(title: [Introduction], numbering_: "1.1.1") = {
  counter(heading).step()
  let label = label("chapter-" + title)
  context {
    new-page
    text(weight: "bold", size: 22pt, [
      Chapter #{counter(heading).display()}
      #label
    ])
    text(weight: "bold", size: 26pt, heading(context {
      if in-outline.get() {
        strong(numbering(numbering_, ..counter(heading).at(label)) + "  " + title)
      } else {
        title
      }
    }))
    v(4em)
  }
}

/// Generates a new subchapter with given title.
/// - title (content): The title of the page.
#let subchapter(title: [Sub-chapter], numbering_: "1.1.1") = {
  counter(heading).step(level: 2)
  let label = label("subchapter-" + title)
  context [
    #text(weight: "bold", size: 12pt, heading(context {
      if in-outline.get() {
        numbering(numbering_, ..counter(heading).at(label)) + "  " + title
      } else [
        #{numbering(numbering_, ..counter(heading).at(label))} #title
      ]
    }, level: 2))
    #label
  ]
}


/// Generates the outline of the document
/// - title (content): The title of the outline.
/// - args (..any): Any argument that can be passed to the `outline` component.
#let generate-outline(title: "Contents", ..args) = {
  page-title(title: title, outlined: false)
  in-outline.update(true)
  outline(
    indent: 2em,
    title: none,
    fill: align(bottom, box(width: 1fr, height: 0.05em, fill: black)),
    ..args
  )
  in-outline.update(false)
}