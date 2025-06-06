#import "@preview/abbr:0.1.1"
#import "@preview/linguify:0.4.1": *

#let lang-data = toml("lang.toml")

#let l(key) = linguify(key, from: lang-data )

#let styling(it) = {
  import "@preview/abbr:0.1.1"

  set text(font: "DejaVu Serif", 12pt)

  set par(leading: 0.8em, justify: true)

  set heading(numbering: "1.")
  show heading: set block(below: 1.5em, above: 2em)

  it
}

#let color-header(
  title: "Title",
  subtitle: "Subtitle",
  author: "Author",
  report-type: "Report",
  program: "Program",
) = {
  set page(fill: rgb(253, 99, 96))
  set text(weight: 1000, size: 10pt)
  [
    #program
  ]
  text()[
    \ \ \
  ]
  align()[
    #text(size: 35pt, white)[
      #title
      \ \
    ]
    #text(size: 12pt, white)[
      #subtitle
      \
      \
      #line(length: 100%, stroke: white)
      \
      #author
    ]]

  align(bottom)[
    #grid(
      columns: (1fr, 1fr),
      rows: 100pt,
      rect(stroke: none)[
        #image("logo-86630-1.png", width: 100pt)
      ],
      align(right)[
        #rect(stroke: none, width: 100pt, height: 100pt)[
          #align(horizon + left)[
            #grid(
              columns: (10pt, 1fr),
              rows: 35pt,
              line(end: (0%, 90%), stroke: white),
              align(horizon)[
                #text(white, size: 10pt, hyphenate: false)[
                  #report-type
                ]
              ],
            )
          ]
        ]
      ],
    )
  ]
}

#let header(program: "Program") = {
  [
    #l("aalto")\
    #l("sci")\
    #program
  ]
}

#let intro(
  title: "Title",
  author: "Jaakko Turpela",
  major: "Major",
  code: "SCI1234",
  teacher: "Teacher",
  supervisor: "Supervisor",
  summary: lorem(100),
  keywords: (),
  language: "English",
  abbreviations: (),
  date: datetime.today(),
  subtitle: "SubTitle",
  report-type: "Report",
  program: "Program",
) = {
  let date = (
    date.display("[day padding:none]. ") + l(lower(date.display("[month repr:long]"))) + date.display(" [year]")
  )

  set page(
  numbering: (..numbers) => {
    if numbers.pos().at(0) != 1 {
      numbering("i", numbers.pos().at(0))
    }
  },
)

  color-header(title: title, subtitle: subtitle, author: author, report-type: report-type)

  pagebreak()

  header(program: program)

  text()[
    \ \ \ \ \ \ \
  ]
  align(right)[
    #grid(
      columns: 70%,
      rows: 100pt,
      align(left)[
        #text(size: 22pt)[
          *#title*
        ]
        \ \ \ \
        #text(size: 13pt)[
          #subtitle
        ]
        \ \ \ \
        #text(size: 13pt)[
          *#author*
        ]
      ]
    )
  ]

  pagebreak()

  grid(
    columns: (50%, 50%),
    align: (left, right),
    image("logo-86626-1.png", width: 70pt),
    align(horizon)[
      #text(size: 12pt)[
        *Abstract*
      ]
    ],
  )

  show table.cell: it => {
    if it.x == 0 and it.colspan == 1 {
      strong(it)
    } else {
      it
    }
  }

  set table(
    stroke: (x, y) => (
      left: if x == 0 {
        0.5pt
      } else {
        0pt
      },
      right: 0.5pt,
      top: 0.5pt,
      bottom: 0.5pt,
    ),
  )
  text()[
    \ \ \
  ]
  table(
    columns: (25%, 75%),
    [#l("author")], author,
    [#l("title")], title,
    [#l("subtitle")], subtitle,
    [#l("date")], date,
    [#l("nof_pages")], context [ #counter(page).final().at(0) ],
    [#l("main_teacher")], teacher,
    [#l("supervisor")], supervisor,
    [#l("keywords")], keywords.join(", "),
    [#l("language")], language,
  )

  text(size: 13pt)[
    \ *Abstract* \
  ]

  summary

  pagebreak()

  outline()
  
  pagebreak()
}

#let end(bibfile, appendix) = {
  pagebreak(weak: true)

  show bibliography: bib => {
    show "vsk.": "vol."
    bib
  }
  let dd = "../" 
  let ddbib = dd + bibfile
  bibliography(ddbib, style: "ieee-aalto.csl")

  pagebreak(weak: true)

  counter(heading).update(0)
  set heading(numbering: "A")

  appendix
}
