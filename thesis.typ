#import "./template/template.typ": *

#show: setup-page-counting

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
#hide-counting

= Disabling page counting
#lorem(1000)
#enable-counting
= Enabling page counting
#lorem(1000)
