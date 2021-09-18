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
rmd_hash: 3a8cf63082d462a7

---

<div style="text-align: justify">

Esta es una serie de post, que nos ayudará a ver de manera aplicada los conceptos de estadística y de machine learning. Para comenzar, lo primero es conseguir información. Asumiendo que ya tenemos esto, el siguiente paso es ahora poder gestionarla dentro de R.

Podemos tener información en distintos formatos, desde un texto plano, separado por comas, excel, XML, base de datos, json, etc. Nos ayudaremos de datos abiertos de [kaggle](https://www.kaggle.com) y de [openml](https://www.openml.org/).

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

Se usó la funcion read.csv, ya que la informacion se encuentra separada por comas. Si la informacion estuviera separa por otro caracter, se agregaria el parametro *sep = "/"* por ejemplo.

# Leer información desde disco local (Zip file)

Para esto, primero descargar el archivo del siguiente [link](https://www.kaggle.com/mokar2001/house-price-tehran-iran). Se descargará un zip y dentro de el un archivo csv.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'>
<span class='nv'>house</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/r/utils/read.table.html'>read.csv</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/connections.html'>unz</a></span><span class='o'>(</span><span class='s'>"archive.zip"</span>,<span class='s'>"housePrice.csv"</span><span class='o'>)</span>, header <span class='o'>=</span> <span class='kc'>T</span><span class='o'>)</span>

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

Para que funcione el código de arriba, es necesario saber el nombre del archivo que se encuentra dentro del zip, en este caso es "housePrice.csv"

# Leer información desde disco local (Excel file)

Cuando tenemos un archivo en formato excel, debemos ser cuidadosos en ver si la extensión es ".xls" o ".xlsx". A partir de la extensión tendremos que escoger qué libreria usar. Por otra parte, a diferencia de un texto plano, o un csv, el formato de excel como sabemos esta organizado por pestañas, es decir un archivo podria tener información en más de una pestaña. Para el siguiente ejemplo, por favor descargue el siguiente [archivo](https://www.kaggle.com/akouaorsot/fintech-stock-price-data) y descomprímalo en su disco local.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://ycphs.github.io/openxlsx/index.html'>openxlsx</a></span><span class='o'>)</span>
<span class='nv'>paypal</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/pkg/openxlsx/man/read.xlsx.html'>read.xlsx</a></span><span class='o'>(</span><span class='s'>"Fintech Stocks.xlsx"</span>, sheet <span class='o'>=</span> <span class='s'>"PayPal"</span><span class='o'>)</span>
<span class='nv'>coinbase</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/pkg/openxlsx/man/read.xlsx.html'>read.xlsx</a></span><span class='o'>(</span><span class='s'>"Fintech Stocks.xlsx"</span>, sheet <span class='o'>=</span> <span class='s'>"Coinbase"</span><span class='o'>)</span>

<span class='nf'><a href='https://rdrr.io/r/utils/head.html'>head</a></span><span class='o'>(</span><span class='nv'>paypal</span>,<span class='m'>5</span><span class='o'>)</span>
<span class='c'>#&gt;    Date  Open  High    Low Close Adj.Close   Volume</span>
<span class='c'>#&gt; 1 42557 35.94 36.17 35.715 35.93     35.93  7821300</span>
<span class='c'>#&gt; 2 42558 35.92 36.39 35.840 36.32     36.32  7326700</span>
<span class='c'>#&gt; 3 42559 36.78 37.46 36.660 37.36     37.36  6828600</span>
<span class='c'>#&gt; 4 42562 37.45 38.33 37.400 38.15     38.15 10096200</span>
<span class='c'>#&gt; 5 42563 38.47 38.91 38.240 38.79     38.79  9997200</span>

<span class='nf'><a href='https://rdrr.io/r/utils/head.html'>head</a></span><span class='o'>(</span><span class='nv'>coinbase</span>,<span class='m'>5</span><span class='o'>)</span>
<span class='c'>#&gt;    Date   Open   High    Low  Close Adj.Close   Volume</span>
<span class='c'>#&gt; 1 44300 381.00 429.54 310.00 328.28    328.28 81065700</span>
<span class='c'>#&gt; 2 44301 348.90 349.20 317.27 322.75    322.75 39777900</span>
<span class='c'>#&gt; 3 44302 327.50 345.99 321.03 342.00    342.00 22654500</span>
<span class='c'>#&gt; 4 44305 337.26 341.01 326.79 333.00    333.00 11405600</span>
<span class='c'>#&gt; 5 44306 333.43 334.83 312.02 320.82    320.82 18082300</span></code></pre>

</div>

<div/>

### Te parece útil? Considera compartirlo 🙌

