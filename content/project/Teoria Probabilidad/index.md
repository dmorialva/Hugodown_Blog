---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/
output: hugodown::md_document
title: "Teoria Probabilidad"
summary: ""
authors: [admin]
tags: [Data Science, Teoria de Probabilidad, R, Estadística]
categories: []
date: 2021-10-05

# Optional external URL for project (replaces project detail page).
external_link: ""

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal points: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight.
image:
  caption: "Photo by [www.cuemath.com](https://www.cuemath.com)"
  focal_point: "Smart"
  preview_only: false
  placement: 1

# Custom links (optional).
#   Uncomment and edit lines below to show custom links.
links:
- icon: linkedin
  icon_pack: fab
  name: Follow
  url: https://www.linkedin.com/in/morialva27/

url_code: ""
url_pdf: ""
url_slides: ""
url_video: ""

# Slides (optional).
#   Associate this project with Markdown slides.
#   Simply enter your slide deck's filename without extension.
#   E.g. `slides = "example-slides"` references `content/slides/example-slides.md`.
#   Otherwise, set `slides = ""`.
slides: ""
rmd_hash: 94c2944d039c08cc

---

<div style="text-align: justify">

# Definición de probabilidad

Como vimos en el post de [Explorando Probabilidades](), la probabilidad se define como la cuantificación de la ocurrencia de un evento en un experimento. Para ello, debemos conocer el **espacio muestral**, que es el conjunto de todos los posibles resultados. Empecemos con el lanzamiento de una moneda. En este experimento, el espacio muestral es de Cara (c) o Sello (s).

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='c'># Lanzamiento de una moneda</span>
<span class='nf'><a href='https://rdrr.io/r/base/sample.html'>sample</a></span><span class='o'>(</span>x<span class='o'>=</span><span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"c"</span>,<span class='s'>"s"</span><span class='o'>)</span>, size <span class='o'>=</span> <span class='m'>1</span><span class='o'>)</span>
<span class='c'>#&gt; [1] "c"</span>
<span class='c'># La probabilidad de este evento es 1/2</span></code></pre>

</div>

<div/>

### Te parece útil? Considera compartirlo 🙌

