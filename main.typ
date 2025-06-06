#import "lib/lib.typ": *

#show: styling

#intro(
  title: "Title of Paper",
  author: "Teemu Teekkari",
  major: "Major",
  code: "Code1234",
  teacher: "Dr. Professor",
  supervisor: "Super Visor",
  summary: lorem(100),
  keywords: ("keywords", "for", "paper"),
  language: "English",
  abbreviations: (),
  date: datetime.today(),
  subtitle: "Subtitle of Paper",
  report-type: "Report",
  program: "Program"
)

#counter(page).update(1) 
#set page(numbering: "1. ")

#set page(margin: (
  top: 3cm,
  bottom: 2.5cm,
  left: 5cm,
))
#set text(size: 12pt, spacing: 150%)

= Introduction
#lorem(100)

== Section
#lorem(100)

#pagebreak()

= Foo

#pagebreak()

= Conclusion

#pagebreak()


#end(
  "bibfile.bib",
  [
    = First Appendix
    #lorem(100),
    #pagebreak(),
  
    = Second Appendix
    #lorem(100),
  ],
)

