#import "./template/template.typ": *
#import "@preview/tidy:0.3.0"

= Documentation for this template

#let docs = tidy.parse-module(
  read("/template/template.typ"),
  scope: (title_page: title_page),
)
#tidy.show-module(docs)
