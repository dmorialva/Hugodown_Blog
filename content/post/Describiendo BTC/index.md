---
output: hugodown::md_document
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Describiendo Bitcoin - I"
subtitle: ""
summary: "Analizaremos con la ayuda de la estadística descriptiva los movimientos de una criptomoneda"
authors: [admin]
tags: [Probabilidad, Estadistica, Criptomoneda]
categories: []
date: 2022-02-04
lastmod: 2022-02-04
featured: false
draft: false

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal points: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight.
image:
  caption: "Photo by [www.bolsamania.com](https://www.bolsamania.com/noticias/criptodivisas/el-bitcoin-corrige-un-10-fin-del-rally-o-toma-de-beneficios--8277113.html)"
  focal_point: "smart"
  preview_only: false
  placement: 1
  
# Custom links (optional).
#   Uncomment and edit lines below to show custom links.
links:
- icon: linkedin
  icon_pack: fab
  name: Follow
  url: https://www.linkedin.com/in/morialva27/

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects: []
rmd_hash: 888838b4088f6c35

---

<div style="text-align: justify">

Bitcoin es una moneda digital creada en el 2008 por una entidad bajo el pseudonimo de Satoshi Nakamoto, que sirve de intercambio como otra moneda física. La característica mas resaltante es que es una moneda descentralizada, es decir que no existe una autoridad o ente de control que sea responsable de su emisión y registro de sus movimientos y no sufre de inflación, ya que existe un numero limite de monedas. La tecnología que usa para la transferencia o movimientos de la moneda digital es la cadena de bloques o Blockchain, la cual en terminos simple lleva un registro de cada movimiento o etiqueta, y se copia en cada cadena de bloques de manera que todos los usuarios de la cadena deben tener la misma información para validar la transacción, lo que hace muy dificil la falsificación. Si quieres saber mas te dejo información [aquí](https://es.wikipedia.org/wiki/Bitcoin)

# Leer información desde (CSV)

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://tidyverse.tidyverse.org'>tidyverse</a></span><span class='o'>)</span>
<span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://github.com/braverock/PerformanceAnalytics'>PerformanceAnalytics</a></span><span class='o'>)</span>

<span class='nv'>btc</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/r/utils/read.table.html'>read.csv</a></span><span class='o'>(</span><span class='s'>"dailyDataBTC-USD.csv"</span>, stringsAsFactors <span class='o'>=</span> <span class='kc'>F</span>, header <span class='o'>=</span> <span class='kc'>T</span><span class='o'>)</span>
<span class='nv'>btc</span> <span class='o'>&lt;-</span> <span class='nv'>btc</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> <span class='nf'><a href='https://dplyr.tidyverse.org/reference/mutate.html'>mutate</a></span><span class='o'>(</span>fecha <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/as.Date.html'>as.Date</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/as.POSIXlt.html'>as.POSIXct</a></span><span class='o'>(</span><span class='nv'>unix</span>, origin <span class='o'>=</span> <span class='s'>"1970-01-01"</span><span class='o'>)</span><span class='o'>)</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> <span class='nf'><a href='https://dplyr.tidyverse.org/reference/arrange.html'>arrange</a></span><span class='o'>(</span><span class='nv'>fecha</span><span class='o'>)</span>
<span class='nf'><a href='https://rdrr.io/r/base/Extremes.html'>min</a></span><span class='o'>(</span><span class='nv'>btc</span><span class='o'>$</span><span class='nv'>fecha</span><span class='o'>)</span>
<span class='c'>#&gt; [1] "2020-12-28"</span>
<span class='nf'><a href='https://rdrr.io/r/base/Extremes.html'>max</a></span><span class='o'>(</span><span class='nv'>btc</span><span class='o'>$</span><span class='nv'>fecha</span><span class='o'>)</span>
<span class='c'>#&gt; [1] "2021-10-23"</span>
<span class='nf'><a href='https://rdrr.io/r/base/Extremes.html'>max</a></span><span class='o'>(</span><span class='nv'>btc</span><span class='o'>$</span><span class='nv'>fecha</span><span class='o'>)</span><span class='o'>-</span><span class='nf'><a href='https://rdrr.io/r/base/Extremes.html'>min</a></span><span class='o'>(</span><span class='nv'>btc</span><span class='o'>$</span><span class='nv'>fecha</span><span class='o'>)</span>
<span class='c'>#&gt; Time difference of 299 days</span></code></pre>

</div>

Para fines practicos usaremos este archivo para el análisis. Pero te dejaré un link para que puedas extraer informacion desde la una API.

Como un primer análisis, mostraremos la serie temporal del bitcoin con su precio ajustado al cierre diario.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ggplot2.tidyverse.org'>ggplot2</a></span><span class='o'>)</span>
<span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://plotly-r.com'>plotly</a></span><span class='o'>)</span>


<span class='c'># Convertimos el dataframe en un objeto xts</span>
<span class='nv'>btc_graph</span> <span class='o'>&lt;-</span> <span class='nv'>btc</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span>
            <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/ggplot.html'>ggplot</a></span><span class='o'>(</span> <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/aes.html'>aes</a></span><span class='o'>(</span>x<span class='o'>=</span><span class='nv'>fecha</span>, y<span class='o'>=</span><span class='nv'>close</span><span class='o'>)</span><span class='o'>)</span> <span class='o'>+</span>
            <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/geom_path.html'>geom_line</a></span><span class='o'>(</span>color<span class='o'>=</span><span class='s'>"#69b3a5"</span><span class='o'>)</span> <span class='o'>+</span>
            <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/labs.html'>ylab</a></span><span class='o'>(</span><span class='s'>"Bitcoin ($)"</span><span class='o'>)</span> 
<span class='nv'>btc_graph</span> 
</code></pre>
<img src="figs/unnamed-chunk-2-1.png" width="700px" style="display: block; margin: auto;" />

</div>

<div>

### Te parece útil? Considera compartirlo 🙌

