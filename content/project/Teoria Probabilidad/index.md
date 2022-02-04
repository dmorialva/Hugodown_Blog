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
rmd_hash: 7500c91e2a786a3f

---

<div style="text-align: justify">

# Definición de probabilidad

Como vimos en el post de [Explorando Probabilidades](https://www.dmorialva.com/post/explorando-informacion/), la probabilidad se define como la cuantificación de la ocurrencia de un evento en un experimento. Para ello, debemos conocer el **espacio muestral**, que es el conjunto de todos los posibles resultados. Empecemos con el lanzamiento de una moneda. En este experimento, el espacio muestral es de Cara (c) o Sello (s), tambien conocido como ensayo de [Bernoulli.](https://es.wikipedia.org/wiki/Ensayo_de_Bernoulli#:~:text=En%20la%20teoría%20de%20probabilidad,en%20honor%20a%20Jakob%20Bernoulli.)

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='c'># Lanzamiento de una moneda</span>
<span class='nf'><a href='https://rdrr.io/r/base/sample.html'>sample</a></span><span class='o'>(</span>x<span class='o'>=</span><span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"c"</span>,<span class='s'>"s"</span><span class='o'>)</span>, size <span class='o'>=</span> <span class='m'>1</span><span class='o'>)</span>
<span class='c'>#&gt; [1] "s"</span>
<span class='c'># La probabilidad de este evento es 1/2</span></code></pre>

</div>

Es fácil entender, que un lanzamiento no influye en el resultado del siguiente, esta característica hace que los eventos sean independientes.

Vamos a realizar el siguiente experimento: simulamos el lanzamiento de una moneda 100 veces, y cuantificaremos las probabilidades. ¿Esperas tener 50 caras y 50 sellos exactamente?. Este experimento se convierte en una distribución binomial, el cual se define como "n" ensayos de Bernoulli.

<div class="highlight">

<img src="figs/unnamed-chunk-2-1.gif" width="700px" style="display: block; margin: auto;" />

</div>

Como es de esperar, no obtenemos 50 caras y 50 sellos. Si repitiéramos este experimento, podemos tener muchas combinaciones posibles, por ejemplo, P(c) = 0.2 y P(s) = 0.8 Es decir, si en un lanzamiento obtenemos cara, no es de esperar que en siguiente sea sello, ya que los eventos son independientes. Vamos a ejecutar 1000 veces este experimento y graficar los histogramas.

<div class="highlight">

<img src="figs/unnamed-chunk-3-1.png" width="700px" style="display: block; margin: auto;" />

</div>

Tal ves la pregunta que viene a la cabeza es, ¿No era una moneda justa? ¿Por qué no obtenemos siempre 50/50? La respuesta es que en 1000 lanzamientos obtienes todas las combinaciones posibles, pero hay algo más que podríamos notar. ¿Cuál es el valor mas probable?.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'>
<span class='nv'>probabilityDistribution</span> <span class='o'>%&gt;%</span> 
  <span class='nf'>select</span><span class='o'>(</span><span class='nv'>Estimate</span>, <span class='nv'>Frecuencia</span>, <span class='nv'>Resultado</span><span class='o'>)</span> <span class='o'>%&gt;%</span> 
  <span class='nf'>group_by</span><span class='o'>(</span><span class='nv'>Resultado</span><span class='o'>)</span> <span class='o'>%&gt;%</span> 
  <span class='nf'>summarise</span><span class='o'>(</span>mode <span class='o'>=</span> <span class='nv'>Estimate</span><span class='o'>[</span><span class='nf'><a href='https://rdrr.io/r/base/which.min.html'>which.max</a></span><span class='o'>(</span><span class='nv'>Frecuencia</span><span class='o'>)</span><span class='o'>]</span><span class='o'>)</span>
<span class='c'>#&gt; <span style='color: #555555;'># A tibble: 2 × 2</span></span>
<span class='c'>#&gt;   Resultado mode </span>
<span class='c'>#&gt;   <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span>     <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>1</span> C         0.5  </span>
<span class='c'>#&gt; <span style='color: #555555;'>2</span> S         0.5</span></code></pre>

</div>

Exactamente, es el escenario donde se da el 50/50, el más probable (mayor frecuencia). ¿Y cuál es la medida promedio?

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>probabilityDistribution</span> <span class='o'>%&gt;%</span> 
  <span class='nf'>select</span><span class='o'>(</span><span class='nv'>Estimate</span>, <span class='nv'>Frecuencia</span>, <span class='nv'>Resultado</span><span class='o'>)</span> <span class='o'>%&gt;%</span> 
  <span class='nf'>group_by</span><span class='o'>(</span><span class='nv'>Resultado</span><span class='o'>)</span> <span class='o'>%&gt;%</span> 
  <span class='nf'>summarise</span><span class='o'>(</span>mean <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/sum.html'>sum</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/numeric.html'>as.numeric</a></span><span class='o'>(</span><span class='nv'>Estimate</span><span class='o'>)</span><span class='o'>*</span><span class='nv'>Frecuencia</span><span class='o'>)</span><span class='o'>/</span><span class='nf'><a href='https://rdrr.io/r/base/sum.html'>sum</a></span><span class='o'>(</span><span class='nv'>Frecuencia</span><span class='o'>)</span><span class='o'>)</span>
<span class='c'>#&gt; <span style='color: #555555;'># A tibble: 2 × 2</span></span>
<span class='c'>#&gt;   Resultado  mean</span>
<span class='c'>#&gt;   <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span>     <span style='color: #555555; font-style: italic;'>&lt;dbl&gt;</span></span>
<span class='c'>#&gt; <span style='color: #555555;'>1</span> C         0.496</span>
<span class='c'>#&gt; <span style='color: #555555;'>2</span> S         0.505</span></code></pre>

</div>

Conforme sigamos lanzando la moneda, la probabilidad que resulte cara en el infinito debe ser 0.5, por la definicion de [convergencia en probabilidad](https://es.wikipedia.org/wiki/Convergencia_en_probabilidad) siempre y cuando la moneda sea justa y no cargada. Esto también se podría demostrar mediante inferencia estadística, por ejemplo por una prueba de hipótesis, en el cual se quiere probar que el parámetro de interés resulte ser estadísticamente significativo a partir de una muestra.

Te dejo una razón más del porqué es importante la teoría de probabilidad. Para los casinos, que trabajan con juegos de azar que involucran las probabilidades, no les hace falta saber el resultado de cada experimento del juego de la ruleta o de un blackjack o del giro de una máquina de monedas, solamente necesitan saber que tienen probabilidades esperadas favorables a ellos, y que en promedio siempre estarán por encima que el jugador, así que no importa si el jugador saca una flor imperial, ya que es un resultado esperado.

<div/>

### Te parece útil? Considera compartirlo 🙌

