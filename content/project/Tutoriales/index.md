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
rmd_hash: dbb7add04003075c

---

Esta es una serie de post, que nos ayudará a ver de manera aplicada los conceptos de estadística y de machine learning. Para comenzar, lo primero es conseguir información. Asumiendo que ya tenemos esto, el siguiente paso es ahora poder gestionarla dentro de R.

Podemos tener información en distintos formatos, desde un texto plano, separado por comas, excel, URL, base de datos, json,etc. Nos ayudaremos de datos abiertos de [kaggle](https://www.kaggle.com/priankravichandar/airline-delays-from-20032016/metadata) y de [openml](https://www.openml.org/).

# Leer información desde web

El dataset "airlines" se compone por la información de los vuelos en Estados Unidos del 2003 al 2016.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'>
<span class='nv'>airline</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/r/utils/read.table.html'>read.csv</a></span><span class='o'>(</span><span class='s'>'https://corgis-edu.github.io/corgis/datasets/csv/airlines/airlines.csv'</span><span class='o'>)</span>

<span class='nf'><a href='https://rdrr.io/r/utils/head.html'>head</a></span><span class='o'>(</span><span class='nv'>airline</span><span class='o'>)</span>
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
<span class='c'>#&gt;   Time.Label Time.Month Time.Month.Name Time.Year</span>
<span class='c'>#&gt; 1    2003/06          6            June      2003</span>
<span class='c'>#&gt; 2    2003/06          6            June      2003</span>
<span class='c'>#&gt; 3    2003/06          6            June      2003</span>
<span class='c'>#&gt; 4    2003/06          6            June      2003</span>
<span class='c'>#&gt; 5    2003/06          6            June      2003</span>
<span class='c'>#&gt; 6    2003/06          6            June      2003</span>
<span class='c'>#&gt;   Statistics...of.Delays.Carrier Statistics...of.Delays.Late.Aircraft</span>
<span class='c'>#&gt; 1                           1009                                 1275</span>
<span class='c'>#&gt; 2                            374                                  495</span>
<span class='c'>#&gt; 3                            296                                  477</span>
<span class='c'>#&gt; 4                            300                                  472</span>
<span class='c'>#&gt; 5                            283                                  268</span>
<span class='c'>#&gt; 6                            516                                  323</span>
<span class='c'>#&gt;   Statistics...of.Delays.National.Aviation.System</span>
<span class='c'>#&gt; 1                                            3217</span>
<span class='c'>#&gt; 2                                             685</span>
<span class='c'>#&gt; 3                                             389</span>
<span class='c'>#&gt; 4                                             735</span>
<span class='c'>#&gt; 5                                             487</span>
<span class='c'>#&gt; 6                                             664</span>
<span class='c'>#&gt;   Statistics...of.Delays.Security Statistics...of.Delays.Weather</span>
<span class='c'>#&gt; 1                              17                            328</span>
<span class='c'>#&gt; 2                               3                             66</span>
<span class='c'>#&gt; 3                               8                             78</span>
<span class='c'>#&gt; 4                               2                             54</span>
<span class='c'>#&gt; 5                               4                             58</span>
<span class='c'>#&gt; 6                              11                             98</span>
<span class='c'>#&gt;                                                                                                                                                                                                                                                                                                                           Statistics.Carriers.Names</span>
<span class='c'>#&gt; 1                                                                                  American Airlines Inc.,JetBlue Airways,Continental Air Lines Inc.,Delta Air Lines Inc.,Atlantic Southeast Airlines,AirTran Airways Corporation,America West Airlines Inc.,Northwest Airlines Inc.,ExpressJet Airlines Inc.,United Air Lines Inc.,US Airways Inc.</span>
<span class='c'>#&gt; 2 American Airlines Inc.,Alaska Airlines Inc.,Continental Air Lines Inc.,Atlantic Coast Airlines,Delta Air Lines Inc.,Atlantic Southeast Airlines,AirTran Airways Corporation,America West Airlines Inc.,American Eagle Airlines Inc.,Northwest Airlines Inc.,ExpressJet Airlines Inc.,ATA Airlines d/b/a ATA,United Air Lines Inc.,US Airways Inc.</span>
<span class='c'>#&gt; 3                                                                          American Airlines Inc.,Continental Air Lines Inc.,Delta Air Lines Inc.,AirTran Airways Corporation,America West Airlines Inc.,American Eagle Airlines Inc.,Northwest Airlines Inc.,ExpressJet Airlines Inc.,United Air Lines Inc.,US Airways Inc.,Southwest Airlines Co.</span>
<span class='c'>#&gt; 4                                                                             American Airlines Inc.,Continental Air Lines Inc.,Atlantic Coast Airlines,Delta Air Lines Inc.,Atlantic Southeast Airlines,American Eagle Airlines Inc.,Northwest Airlines Inc.,ExpressJet Airlines Inc.,ATA Airlines d/b/a ATA,United Air Lines Inc.,US Airways Inc.</span>
<span class='c'>#&gt; 5                             American Airlines Inc.,Alaska Airlines Inc.,Continental Air Lines Inc.,Atlantic Coast Airlines,Delta Air Lines Inc.,Atlantic Southeast Airlines,America West Airlines Inc.,American Eagle Airlines Inc.,Northwest Airlines Inc.,ExpressJet Airlines Inc.,ATA Airlines d/b/a ATA,United Air Lines Inc.,US Airways Inc.</span>
<span class='c'>#&gt; 6                                         American Airlines Inc.,Alaska Airlines Inc.,JetBlue Airways,Continental Air Lines Inc.,Delta Air Lines Inc.,Atlantic Southeast Airlines,AirTran Airways Corporation,America West Airlines Inc.,Northwest Airlines Inc.,SkyWest Airlines Inc.,ATA Airlines d/b/a ATA,United Air Lines Inc.,US Airways Inc.</span>
<span class='c'>#&gt;   Statistics.Carriers.Total Statistics.Flights.Cancelled</span>
<span class='c'>#&gt; 1                        11                          216</span>
<span class='c'>#&gt; 2                        14                          138</span>
<span class='c'>#&gt; 3                        11                           29</span>
<span class='c'>#&gt; 4                        11                           73</span>
<span class='c'>#&gt; 5                        13                           74</span>
<span class='c'>#&gt; 6                        13                           34</span>
<span class='c'>#&gt;   Statistics.Flights.Delayed Statistics.Flights.Diverted</span>
<span class='c'>#&gt; 1                       5843                          27</span>
<span class='c'>#&gt; 2                       1623                           3</span>
<span class='c'>#&gt; 3                       1245                          15</span>
<span class='c'>#&gt; 4                       1562                          14</span>
<span class='c'>#&gt; 5                       1100                          18</span>
<span class='c'>#&gt; 6                       1611                          22</span>
<span class='c'>#&gt;   Statistics.Flights.On.Time Statistics.Flights.Total</span>
<span class='c'>#&gt; 1                      23974                    30060</span>
<span class='c'>#&gt; 2                       7875                     9639</span>
<span class='c'>#&gt; 3                       6998                     8287</span>
<span class='c'>#&gt; 4                       7021                     8670</span>
<span class='c'>#&gt; 5                       5321                     6513</span>
<span class='c'>#&gt; 6                      10024                    11691</span>
<span class='c'>#&gt;   Statistics.Minutes.Delayed.Carrier Statistics.Minutes.Delayed.Late.Aircraft</span>
<span class='c'>#&gt; 1                              61606                                    68335</span>
<span class='c'>#&gt; 2                              20319                                    28189</span>
<span class='c'>#&gt; 3                              13635                                    26810</span>
<span class='c'>#&gt; 4                              14763                                    23379</span>
<span class='c'>#&gt; 5                              13775                                    13712</span>
<span class='c'>#&gt; 6                              26634                                    18969</span>
<span class='c'>#&gt;   Statistics.Minutes.Delayed.National.Aviation.System</span>
<span class='c'>#&gt; 1                                              118831</span>
<span class='c'>#&gt; 2                                               24400</span>
<span class='c'>#&gt; 3                                               17556</span>
<span class='c'>#&gt; 4                                               23804</span>
<span class='c'>#&gt; 5                                               20999</span>
<span class='c'>#&gt; 6                                               23538</span>
<span class='c'>#&gt;   Statistics.Minutes.Delayed.Security Statistics.Minutes.Delayed.Total</span>
<span class='c'>#&gt; 1                                 518                           268764</span>
<span class='c'>#&gt; 2                                  99                            77167</span>
<span class='c'>#&gt; 3                                 278                            64480</span>
<span class='c'>#&gt; 4                                 127                            65865</span>
<span class='c'>#&gt; 5                                 120                            52747</span>
<span class='c'>#&gt; 6                                 706                            75428</span>
<span class='c'>#&gt;   Statistics.Minutes.Delayed.Weather</span>
<span class='c'>#&gt; 1                              19474</span>
<span class='c'>#&gt; 2                               4160</span>
<span class='c'>#&gt; 3                               6201</span>
<span class='c'>#&gt; 4                               3792</span>
<span class='c'>#&gt; 5                               4141</span>
<span class='c'>#&gt; 6                               5581</span></code></pre>

</div>

Se uso la funcion read.csv, ya que la informacion se encuentra separada por comas. Si la informacion estuviera separa por otro caracter, se agregaria el parametro *sep = "/"* por ejemplo.

I'm a very infrequent contributor to [\#TidyTuesday](https://github.com/rfordatascience/tidytuesday) (though always planning to do more!)

As and when I do get a chance to participate, I'll be sharing my visualisations here.

