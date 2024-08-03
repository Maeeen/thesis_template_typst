#import "./template/template.typ": *

#set page(footer: context {
  let previous-enable-tags = query(selector(<enable-page-numbering>).before(here())).sorted(key: k => k.position())
  let previous-disable-tags = query(selector(<disable-page-numbering>).before(here())).sorted(key: k => k.position())
  if previous-enable-tags.len() == 0 {
    return none
  }
  if previous-disable-tags.len() == 0 or previous-enable-tags.last().location().position().y > previous-disable-tags.last().location().position().y {
    align(center)[#counter(page).display()]
  }
})

#title_page(
  title: "A wonderful thesis about the merits of scientific writing",
  logos: (
    image("./logos/EPFLlogo.svg"),
    image("./logos/LABlogo.svg")
  ),
  body: [
    Approved by the Examining Committee:

    Prof. Dr. sc. ETH John Doe \
    Thesis Advisor

    The External Reviewer \
    External Expert

    The Doctoral Student \
    Thesis Supervisor
  ]
)

#dedication[
  #align(right)[
    #quote("Follow the white rabbit...", attribution: "The Matrix", block: true)
  ]

  #align(center)[
    Dedicated to my pet bunny.
  ]

  The dedication is usually a short inspirational quote.
  Define your dedication here.
]

#pagebreak(weak: true)
#enable-counting
#lorem(5000)
#disable-counting

= Disabling page counting
#lorem(1000)
#enable-counting
= Enabling page counting
#lorem(1000)
