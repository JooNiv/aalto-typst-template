#import "lib/lib.typ": *

#show: styling

#intro(
  title: "Automatic Cut Finding",
  author: "Joonas Nivala",
  major: "Textile engineering",
  code: "SCI1234",
  teacher: "PHYS prof, another prof",
  supervisor: "Mikael Johansson",
  summary: lorem(100),
  keywords: ("Quantun", "circuit knittint", "circuit cutting", "circuit partitioning", "distributed quantum computing"),
  language: "English",
  abbreviations: (),
  date: datetime.today(),
  subtitle: "Automatic Cut Finding For Quantum Circuit Knitting"
)

#counter(page).update(1) 
#set page(numbering: "1. ")

= Introduction

= Foo

= Bar

== Baz

= Conclusion

#end(
  "bibfile.bib",
  [
    
  ],
)

