---
output: hugodown::md_document
title: "Tengo datos. ¿Y ahora qué?"
summary: Como importar datos a R de distintas fuentes.
date: '2021-09-18'
tags:
- Data Science
- Deep Learning
- R
external_link: ''
image:
  caption: ''
  focal_point: Smart
  placement: 1
links:
- icon: twitter
  icon_pack: fab
  name: Follow
  url: https://twitter.com/georgecushen
url_code: ''
url_pdf: ''
url_slides: ''
url_video: ''
slides: []
rmd_hash: 25c6eece7994f167

---

Esta es una serie de post, que nos ayudará a ver de manera aplicada los conceptos de estadística y de machine learning. Para comenzar, lo primero es conseguir información. Asumiendo que ya tenemos esto, el siguiente paso es ahora poder gestionarla dentro de R.

Podemos tener información en distintos formatos, desde un texto plano, separado por comas, excel, URL, base de datos, json,etc. Nos ayudaremos de datos abiertos de [kaggle](https://www.kaggle.com/priankravichandar/airline-delays-from-20032016/metadata) y de [openml](https://www.openml.org/).

# Leer información desde web (CSV)

El dataset "airlines" se compone por la información de los vuelos en Estados Unidos del 2003 al 2016.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'>
<span class='nv'>airline</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/r/utils/read.table.html'>read.csv</a></span><span class='o'>(</span><span class='s'>'https://corgis-edu.github.io/corgis/datasets/csv/airlines/airlines.csv'</span><span class='o'>)</span>

<span class='nf'><a href='https://rdrr.io/r/utils/head.html'>head</a></span><span class='o'>(</span><span class='nv'>airline</span><span class='o'>)</span><span class='o'>[</span>,<span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='m'>1</span><span class='o'>:</span><span class='m'>5</span><span class='o'>)</span><span class='o'>]</span>
<span class='c'>#&gt;   Airport.Code</span>
<span class='c'>#&gt; 1          ATL</span>
<span class='c'>#&gt; 2          BOS</span>
<span class='c'>#&gt; 3          BWI</span>
<span class='c'>#&gt; 4          CLT</span>
<span class='c'>#&gt; 5          DCA</span>
<span class='c'>#&gt; 6          DEN</span>
<span class='c'>#&gt;                                                          Airport.Name</span>
<span class='c'>#&gt; 1               Atlanta, GA: Hartsfield-Jackson Atlanta International</span>
<span class='c'>#&gt; 2                                     Boston, MA: Logan International</span>
<span class='c'>#&gt; 3 Baltimore, MD: Baltimore/Washington International Thurgood Marshall</span>
<span class='c'>#&gt; 4                      Charlotte, NC: Charlotte Douglas International</span>
<span class='c'>#&gt; 5                   Washington, DC: Ronald Reagan Washington National</span>
<span class='c'>#&gt; 6                                    Denver, CO: Denver International</span>
<span class='c'>#&gt;   Time.Label Time.Month Time.Month.Name</span>
<span class='c'>#&gt; 1    2003/06          6            June</span>
<span class='c'>#&gt; 2    2003/06          6            June</span>
<span class='c'>#&gt; 3    2003/06          6            June</span>
<span class='c'>#&gt; 4    2003/06          6            June</span>
<span class='c'>#&gt; 5    2003/06          6            June</span>
<span class='c'>#&gt; 6    2003/06          6            June</span></code></pre>

</div>

Se uso la funcion read.csv, ya que la informacion se encuentra separada por comas. Si la informacion estuviera separa por otro caracter, se agregaria el parametro *sep = "/"* por ejemplo.

# Leer información desde disco local (Zip file)

Para esto, primero descargar el archivo del siguiente [link](https://www.kaggle.com/mokar2001/house-price-tehran-iran). Se descargará un zip y dentro de el un archivo csv.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'>
<span class='nv'>house</span> <span class='o'>&lt;-</span> <span class='nv'>house</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/r/utils/read.table.html'>read.csv</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/connections.html'>unz</a></span><span class='o'>(</span><span class='s'>"archive.zip"</span>,<span class='s'>"housePrice.csv"</span><span class='o'>)</span>, header <span class='o'>=</span> <span class='kc'>T</span><span class='o'>)</span>

<span class='nf'><a href='https://rdrr.io/r/utils/head.html'>head</a></span><span class='o'>(</span><span class='nv'>house</span><span class='o'>)</span>
<span class='c'>#&gt;   Area Room Parking Warehouse Elevator                    Address     Price</span>
<span class='c'>#&gt; 1   63    1    True      True     True                    Shahran 1.850e+09</span>
<span class='c'>#&gt; 2   60    1    True      True     True                    Shahran 1.850e+09</span>
<span class='c'>#&gt; 3   79    2    True      True     True                     Pardis 5.500e+08</span>
<span class='c'>#&gt; 4   95    2    True      True     True              Shahrake Qods 9.025e+08</span>
<span class='c'>#&gt; 5  123    2    True      True     True             Shahrake Gharb 7.000e+09</span>
<span class='c'>#&gt; 6   70    2    True      True    False North Program Organization 2.050e+09</span>
<span class='c'>#&gt;   Price.USD.</span>
<span class='c'>#&gt; 1   61666.67</span>
<span class='c'>#&gt; 2   61666.67</span>
<span class='c'>#&gt; 3   18333.33</span>
<span class='c'>#&gt; 4   30083.33</span>
<span class='c'>#&gt; 5  233333.33</span>
<span class='c'>#&gt; 6   68333.33</span></code></pre>

</div>

