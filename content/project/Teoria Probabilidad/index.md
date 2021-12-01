---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/
output: hugodown::md_document
code_folding: hide
title: "Teoria de Probabilidad"
summary: ""
authors: [admin]
tags: [Data Science, Teoria de Probabilidad, R, Estadística]
categories: []
date: 2021-10-05
draft: false

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
rmd_hash: 42305312e1cb0717

---

<div style="text-align: justify">

# Definición de probabilidad

Como vimos en el post de [Explorando Probabilidades](https://www.dmorialva.com/post/explorando-informacion/), la probabilidad se define como la cuantificación de la ocurrencia de un evento en un experimento. Para ello, debemos conocer el **espacio muestral**, que es el conjunto de todos los posibles resultados. Empecemos con el lanzamiento de una moneda. En este experimento, el espacio muestral es de Cara (c) o Sello (s).

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='c'># Lanzamiento de una moneda</span>
<span class='nf'><a href='https://rdrr.io/r/base/sample.html'>sample</a></span><span class='o'>(</span>x<span class='o'>=</span><span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"c"</span>,<span class='s'>"s"</span><span class='o'>)</span>, size <span class='o'>=</span> <span class='m'>1</span><span class='o'>)</span>
<span class='c'>#&gt; [1] "s"</span>
<span class='c'># La probabilidad de este evento es 1/2</span></code></pre>

</div>

Creo que nos hes fácil entender, que un lanzamiento no influye en el resultado del siguiente, esta caracteristica hace que los eventos sea independientes.

Vamos hacer el siguiente experimento: lanzaremos una moneda 100 veces, y comprobaremos las probabilidades. ¿Esperas tener 50 caras y 50 sellos exactamente?

<div class="highlight">

<img src="figs/unnamed-chunk-2-1.gif" width="700px" style="display: block; margin: auto;" />

</div>

Como es de esperar, no obtenemos 50 caras y 50 sellos. Si repitieramos este experimento muchas veces más, podemos tener muchas combinaciones posibles, por ejemplo P(c) = 0.2 y P(s) = 0.8 Es decir, si en un lanzamieno obtenemos cara, no es de esperar que en siguiente sea sello, ya que los eventos son independientes. Vamos a ejecutar 1000 veces este experimento y graficar los histogramas.

<div class="highlight">

<img src="figs/unnamed-chunk-3-1.png" width="700px" style="display: block; margin: auto;" />

</div>

Como vemos, el resultado no siempre es tener 50/50, es posible tener 10/90 o 70/30, pero con menos probabilidad. Si queremos obtener el valor mas probable seria:

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>probabilityDistribution</span> <span class='o'>%&gt;%</span> 
  <span class='nf'>select</span><span class='o'>(</span><span class='nv'>Estimate</span>, <span class='nv'>Frecuencia</span>, <span class='nv'>Resultado</span><span class='o'>)</span> <span class='o'>%&gt;%</span> 
  <span class='nf'>group_by</span><span class='o'>(</span><span class='nv'>Resultado</span><span class='o'>)</span> <span class='o'>%&gt;%</span> 
  <span class='nf'>summarise</span><span class='o'>(</span>mode <span class='o'>=</span> <span class='nv'>Estimate</span><span class='o'>[</span><span class='nf'><a href='https://rdrr.io/r/base/which.min.html'>which.max</a></span><span class='o'>(</span><span class='nv'>Frecuencia</span><span class='o'>)</span><span class='o'>]</span><span class='o'>)</span>
<span class='c'>#&gt; <span style='color: #555555;'># A tibble: 2 × 2</span></span>
<span class='c'>#&gt;   Resultado mode </span>
<span class='c'>#&gt;   <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span>     <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>1</span> Cara      0.5  </span>
<span class='c'>#&gt; <span style='color: #555555;'>2</span> Sello     0.5</span></code></pre>

</div>

Exactamente, es el escenario donde se da el 50/50. ¿Y cuál es la medida promedio?

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>probabilityDistribution</span> <span class='o'>%&gt;%</span> 
  <span class='nf'>select</span><span class='o'>(</span><span class='nv'>Estimate</span>, <span class='nv'>Frecuencia</span>, <span class='nv'>Resultado</span><span class='o'>)</span> <span class='o'>%&gt;%</span> 
  <span class='nf'>group_by</span><span class='o'>(</span><span class='nv'>Resultado</span><span class='o'>)</span> <span class='o'>%&gt;%</span> 
  <span class='nf'>summarise</span><span class='o'>(</span>mean <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/sum.html'>sum</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/numeric.html'>as.numeric</a></span><span class='o'>(</span><span class='nv'>Estimate</span><span class='o'>)</span><span class='o'>*</span><span class='nv'>Frecuencia</span><span class='o'>)</span><span class='o'>/</span><span class='nf'><a href='https://rdrr.io/r/base/sum.html'>sum</a></span><span class='o'>(</span><span class='nv'>Frecuencia</span><span class='o'>)</span><span class='o'>)</span>
<span class='c'>#&gt; <span style='color: #555555;'># A tibble: 2 × 2</span></span>
<span class='c'>#&gt;   Resultado  mean</span>
<span class='c'>#&gt;   <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span>     <span style='color: #555555; font-style: italic;'>&lt;dbl&gt;</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>1</span> Cara      0.509</span>
<span class='c'>#&gt; <span style='color: #555555;'>2</span> Sello     0.492</span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://github.com/jennybc/gapminder'>gapminder</a></span><span class='o'>)</span>
<span class='nv'>datos</span> <span class='o'>=</span> <span class='nv'>gapminder</span>

<span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ggplot2.tidyverse.org'>ggplot2</a></span><span class='o'>)</span>
<span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://dplyr.tidyverse.org'>dplyr</a></span><span class='o'>)</span>

<span class='nv'>grafico</span> <span class='o'>&lt;-</span> <span class='nv'>datos</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span>
  <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/ggplot.html'>ggplot</a></span><span class='o'>(</span><span class='o'>)</span> <span class='o'>+</span> 
    <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/geom_point.html'>geom_point</a></span><span class='o'>(</span><span class='nf'><a href='https://ggplot2.tidyverse.org/reference/aes.html'>aes</a></span><span class='o'>(</span>x <span class='o'>=</span> <span class='nv'>gdpPercap</span>, y <span class='o'>=</span> <span class='nv'>lifeExp</span>, col <span class='o'>=</span> <span class='nv'>continent</span>, size <span class='o'>=</span> <span class='nv'>pop</span><span class='o'>)</span>, alpha <span class='o'>=</span> <span class='m'>0.8</span><span class='o'>)</span> <span class='o'>+</span> <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/ggtheme.html'>theme_minimal</a></span><span class='o'>(</span><span class='o'>)</span> <span class='o'>+</span> 
    <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/theme.html'>theme</a></span><span class='o'>(</span>legend.position <span class='o'>=</span> <span class='s'>"bottom"</span><span class='o'>)</span> <span class='o'>+</span> <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/guides.html'>guides</a></span><span class='o'>(</span>size <span class='o'>=</span> <span class='s'>"none"</span><span class='o'>)</span> <span class='o'>+</span> 
    <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/labs.html'>labs</a></span><span class='o'>(</span>x <span class='o'>=</span> <span class='s'>"PIB per Capita"</span> ,y <span class='o'>=</span> <span class='s'>"Esperanza de Vida"</span>,  col <span class='o'>=</span> <span class='s'>""</span><span class='o'>)</span> 

<span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://gganimate.com'>gganimate</a></span><span class='o'>)</span>

<span class='nv'>grafico</span> <span class='o'>&lt;-</span> <span class='nv'>grafico</span> <span class='o'>+</span> <span class='nf'><a href='https://rdrr.io/pkg/gganimate/man/transition_time.html'>transition_time</a></span><span class='o'>(</span><span class='nv'>year</span><span class='o'>)</span>
<span class='nf'><a href='https://rdrr.io/pkg/gganimate/man/animate.html'>animate</a></span><span class='o'>(</span><span class='nv'>grafico</span>, fps <span class='o'>=</span> <span class='m'>15</span>, width <span class='o'>=</span> <span class='m'>750</span>, height <span class='o'>=</span> <span class='m'>450</span><span class='o'>)</span>
</code></pre>
<img src="figs/unnamed-chunk-6-1.gif" width="700px" style="display: block; margin: auto;" />

</div>

<div/>

### Te parece útil? Considera compartirlo 🙌

