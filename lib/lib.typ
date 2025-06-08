#import "@preview/abbr:0.1.1"
#import "@preview/linguify:0.4.1": *

#let lang-data = toml("../lang.toml")

#let l(key) = linguify(key, from: lang-data)

#let styling-headers(it) = {
  import "@preview/abbr:0.1.1"

  set text(font: "DejaVu Serif", 12pt)

  set par(leading: 0.8em, justify: true)

  show heading: set block(below: 1.5em, above: 2em)

  set page(
    margin: (
      top: 2cm,
      bottom: 2cm,
      left: 3cm,
    ),
  )

  set page(
    numbering: (..numbers) => {
      if numbers.pos().at(0) != 1 {
        numbering("i", numbers.pos().at(0))
      }
    },
  )

  show outline: it => {
    show heading: set block(below: 10em)
    it
  }

  show outline.entry: it => link(
    it.element.location(),
    it.indented(it.prefix(), it.inner()),
  )


  show outline.entry.where(level: 1): it => {
    v(12pt)
    text(weight: "bold")[#it]
  }

  show outline.entry.where(level: 2): it => {
    v(12pt, weak: true)
    text(weight: "medium")[#it]
  }


  it
}

#let styling-main(it) = {
  import "@preview/abbr:0.1.1"
  counter(page).update(1)
  set text(font: "DejaVu Serif", 12pt)

  set page(numbering: "1.")

  set heading(numbering: "1.1")
  show heading: it => [
    #if it.level == 1 [
      #set block(below: 10em)
      #it
    ] else [
      #it
    ]

  ]

  set page(
    margin: (
      top: 3cm,
      bottom: 2.5cm,
      left: 5cm,
    ),
  )
  set text(size: 12pt, spacing: 150%)

  it
}

#let color-header(
  title: "Title",
  subtitle: "Subtitle",
  author: "Author",
  language: "English",
) = {
  set page(fill: rgb(253, 99, 96))
  set text(weight: 1000, size: 10pt)

  let a = lower(language.slice(0, 2))
  set text(lang: a)

  [
    #l("program")
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
      #subtitle\
      \
      \
      #line(length: 100%, stroke: white)
      \
      #author\
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
                  #l("type")
                ]
              ],
            )
          ]
        ]
      ],
    )
  ]
  pagebreak()

  counter(page).update(1)
}

#let header(
  title: "Title",
  subtitle: "Subtitle",
  author: "Author",
  language: "English",
) = {
  let a = lower(language.slice(0, 2))
  set text(lang: a)

  [
    #l("aalto")\
    #l("sci")\
    #l("program")
  ]

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
          #subtitle\
        ]
        \ \ \ \
        #text(size: 13pt)[
          *#author*
        ]
      ]
    )
  ]
  pagebreak()
}

#let intro(
  title: "Title",
  author: "Jaakko Turpela",
  teacher: "Teacher",
  supervisor: "Supervisor",
  keywords: (),
  language: "English",
  abbreviations: (),
  date: datetime.today(),
  subtitle: "SubTitle",
) = {
  let date = (
    date.display("[day padding:none]. ") + l(lower(date.display("[month repr:long]"))) + date.display(" [year]")
  )

  let a = lower(language.slice(0, 2))
  set text(lang: a)


  grid(
    columns: (50%, 50%),
    align: (left, right),
    image("logo-86626-1.png", width: 70pt),
    align(horizon)[
      #text(size: 12pt)[
        *#l("summary")*
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
    columns: (30%, 70%),
    [#l("author")], author,
    [#l("title")], title,
    [#l("subtitle")], subtitle,
    [#l("date")], date,
    [#l("nof_pages")], context [ #counter(page).final().at(0) ],
    [#l("main_teacher")], teacher,
    [#l("supervisor")], supervisor,
    [#l("language")], language,
  )

  text(size: 13pt)[
    \ *#l("summary")* \
  ]

  l("abstract")

  align(bottom)[
    #text(size: 13pt)[
      \ *#l("keywords"):*
    ]
    #keywords.join(", ")
    #line(length: 100%, stroke: black)
  ]

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
