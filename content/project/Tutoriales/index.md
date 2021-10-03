---
output: hugodown::md_document
title: "Tengo datos. ¿Y ahora?"
subtitle: "Carga de datos - I"
summary: Como importar datos a R de distintas fuentes.
date: '2021-09-18'
tags:
- Data Science
- Manejo Datos
- R
- Importar datos a R
external_link: ''
image:
  caption: ''
  focal_point: Smart
  placement: 1
links:
- icon: linkedin
  icon_pack: fab
  name: Follow
  url: https://www.linkedin.com/in/morialva27/
url_code: ''
url_pdf: ''
url_slides: ''
url_video: ''
slides: []
rmd_hash: 71b0d616fc52cffa

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

Se usó la funcion read.csv, ya que la informacion se encuentra separada por comas. Si la informacion estuviera separa por otro caracter, se agregaria el parametro *sep = "/"* por ejemplo. No es indispensable que el formato almacenado en la web sea un CSV, tambien puede ser un texto plano (.TXT) u otro.

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

# Leer información de una base de datos externa (online)

Con *R* podemos conectarnos a distintos gestores de base datos (MS Accsess, SQL, MySQL, Oracle, etc), por medio de la ODBC [(Open DataBase Connectivity)](https://es.wikipedia.org/wiki/Open_Database_Connectivity). Para ello se cuentan con distintos paquetes, entre ellos DBI, ODBC, etc. Si nuestra información se encuentra en una base SQL cuyo servidor físico se encuentra en tu centro laboral, o ubicado fuera de tu red local, podemos conectarnos a ella conociendo la IP, el usuario y contraseña y asegurar que tengas un perfil de acceso.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://dbi.r-dbi.org'>DBI</a></span><span class='o'>)</span>
<span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://github.com/r-dbi/odbc'>odbc</a></span><span class='o'>)</span>

<span class='nv'>conn</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://dbi.r-dbi.org/reference/dbConnect.html'>dbConnect</a></span><span class='o'>(</span><span class='nf'>odbc</span><span class='nf'>::</span><span class='nf'><a href='https://rdrr.io/pkg/odbc/man/odbc.html'>odbc</a></span><span class='o'>(</span><span class='o'>)</span>, Driver <span class='o'>=</span> <span class='s'>"SQL Server"</span>,
Server <span class='o'>=</span> <span class='s'>"161.132.193.XXX"</span>,
Database <span class='o'>=</span> <span class='s'>"Nombre_Base"</span>,
UID <span class='o'>=</span> <span class='s'>"usuario"</span>,
PWD <span class='o'>=</span> <span class='s'>"usuario"</span>,
encoding <span class='o'>=</span> <span class='s'>"latin1"</span><span class='o'>)</span>
</code></pre>

</div>

Creamos un objeto de tipo Conexión llamado "conn". Para esto debes conocer si el gestor es un SQL Server, MySQL, etc. En el campo "Server", tienes que ingresar la IP del servidor. En "UID" el nombre del usuario de tu perfil de acceso y en "PWD" el password. El tipo de "encoding" ayuda con los caracteres especiales, como la ñ.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>consulta</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://dbi.r-dbi.org/reference/dbGetQuery.html'>dbGetQuery</a></span><span class='o'>(</span><span class='nv'>conn</span>, <span class='s'>"SELECT * FROM TABLA"</span><span class='o'>)</span></code></pre>

</div>

Una vez que se estableció con éxito la conexión, se podrán hacer extracciones y filtros de la información con las sentencias **SELECT** por medio de la función "dbGetQuery" cuyo parámetro será la conexión que hicimos anteriormente.

# Leer información de una base de datos local (MS Accsess)

En el caso que contemos con información en nuestro disco local, y en un gestor de base de datos como por ejemplo un MS Accsess, podemos usar el paquete de R "RODBC". Para pode acceder al servidor local, debemos hacer lo siguiente:

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'>RODBC</span><span class='o'>)</span>

<span class='nv'>conn</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/pkg/RODBC/man/odbcConnect.html'>odbcConnectAccess2007</a></span><span class='o'>(</span><span class='s'>"basedatos.accdb"</span><span class='o'>)</span>

<span class='nv'>sin</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/pkg/RODBC/man/sqlQuery.html'>sqlQuery</a></span><span class='o'>(</span><span class='nv'>conn</span>, <span class='s'>"SELECT * FROM Tabla"</span>, stringsAsFactors <span class='o'>=</span> <span class='kc'>FALSE</span><span class='o'>)</span>

<span class='nf'><a href='https://rdrr.io/pkg/RODBC/man/odbcClose.html'>odbcCloseAll</a></span><span class='o'>(</span><span class='o'>)</span>
</code></pre>

</div>

Al igual que en el bloque anterior, debemos construir primero la conexión, esto se hace con la función **odbcConnectAccess2007**. Notar que esta se utiliza con versiones de access mayores a 2007. Para poder extraer datos de las tablas de la base, se usa la función **sqlQuery** cuyo parámetro es la conexión abierta y el query que necesites.

Por último, es recomendable cerrar la conexión por el tráfico, para ellos puedes usar la función **odbcCloseAll()**.

# Leer información por medio de REST API (JSON)

Podemos tener información valiosa proveniente de sitios web, en el cual si existe una API desarrollada para poder hacer peticiones o request HTTP, *R* nos entrega una librerias para poder extraer información. En este ejemplo, usaremos la API de Wikipedia, para recolectar las respuestas en ingles y español de lo que es un [capacitor](https://www.wikidata.org/wiki/Q5322), sus definiciones y sus alias.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://httr.r-lib.org/'>httr</a></span><span class='o'>)</span>
<span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='http://www.omegahat.net/RSXML'>XML</a></span><span class='o'>)</span>
<span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://arxiv.org/abs/1403.2805'>jsonlite</a></span><span class='o'>)</span>

<span class='nv'>query</span> <span class='o'>&lt;-</span> 
  <span class='s'>'https://www.wikidata.org/w/api.php?action=wbgetentities&amp;ids=Q5322&amp;format=json'</span>
<span class='nv'>response</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://httr.r-lib.org/reference/GET.html'>GET</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/utils/URLencode.html'>URLencode</a></span><span class='o'>(</span><span class='nv'>query</span><span class='o'>)</span><span class='o'>)</span>
<span class='nv'>response</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/r/base/rawConversion.html'>rawToChar</a></span><span class='o'>(</span><span class='nv'>response</span><span class='o'>$</span><span class='nv'>content</span><span class='o'>)</span>
<span class='nv'>response</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/pkg/jsonlite/man/fromJSON.html'>fromJSON</a></span><span class='o'>(</span><span class='nv'>response</span><span class='o'>)</span>

<span class='c'># Buscamos como se dice capacitor en distintos idiomas:</span>

<span class='nv'>labels</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/r/base/lapply.html'>lapply</a></span><span class='o'>(</span><span class='nv'>response</span><span class='o'>$</span><span class='nv'>entities</span><span class='o'>$</span><span class='nv'>Q5322</span><span class='o'>$</span><span class='nv'>labels</span>, <span class='kr'>function</span><span class='o'>(</span><span class='nv'>x</span><span class='o'>)</span> <span class='o'>&#123;</span>
  <span class='nf'><a href='https://rdrr.io/r/base/paste.html'>paste0</a></span><span class='o'>(</span><span class='nv'>x</span><span class='o'>$</span><span class='nv'>value</span>, <span class='s'>"("</span>, <span class='nv'>x</span><span class='o'>$</span><span class='nv'>language</span>, <span class='s'>")"</span><span class='o'>)</span>
<span class='o'>&#125;</span><span class='o'>)</span>
<span class='nv'>labels</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/r/base/paste.html'>paste</a></span><span class='o'>(</span><span class='nv'>labels</span>, collapse <span class='o'>=</span> <span class='s'>", "</span><span class='o'>)</span>
<span class='nf'><a href='https://rdrr.io/r/base/print.html'>print</a></span><span class='o'>(</span><span class='nv'>labels</span><span class='o'>)</span>
<span class='c'>#&gt; [1] "condensatore(it), condensateur(fr), kondensator(nb), capacitor(en), Kondensator(de), Kapasitor(af), Condensador(an), &lt;U+0645&gt;&lt;U+064F&gt;&lt;U+0643&gt;&lt;U+062B&gt;&lt;U+0651&gt;&lt;U+0641&gt;(ar), &lt;U+0627&gt;&lt;U+0644&gt;&lt;U+0645&gt;&lt;U+0643&gt;&lt;U+062B&gt;&lt;U+0641&gt;(arz), Kondensator(az), &lt;U+041A&gt;&lt;U+0430&gt;&lt;U+043D&gt;&lt;U+0434&gt;&lt;U+044D&gt;&lt;U+043D&gt;&lt;U+0441&gt;&lt;U+0430&gt;&lt;U+0442&gt;&lt;U+0430&gt;&lt;U+0440&gt;(be), &lt;U+041A&gt;&lt;U+043E&gt;&lt;U+043D&gt;&lt;U+0434&gt;&lt;U+0435&gt;&lt;U+043D&gt;&lt;U+0437&gt;&lt;U+0430&gt;&lt;U+0442&gt;&lt;U+043E&gt;&lt;U+0440&gt;(bg), &lt;U+09A7&gt;&lt;U+09BE&gt;&lt;U+09B0&gt;&lt;U+0995&gt;(bn), Kondenzator(bs), condensador(ca), kondenz攼㸱tor(cs), Cynhwysydd(cy), elektrisk kondensator(da), &lt;U+03A0&gt;&lt;U+03C5&gt;&lt;U+03BA&gt;&lt;U+03BD&gt;&lt;U+03C9&gt;t&lt;U+03AE&gt;&lt;U+03C2&gt;(el), Capacitor(en-ca), capacitor(en-gb), kondensilo(eo), condensador el攼㸹ctrico(es), Kondensaator(et), Kondentsadore elektriko(eu), &lt;U+062E&gt;&lt;U+0627&gt;&lt;U+0632&gt;&lt;U+0646&gt;(fa), kondensaattori(fi), &lt;U+96FB&gt;&lt;U+5BB9&gt;(gan), Condensador(gl), &lt;U+05E7&gt;&lt;U+05D1&gt;&lt;U+05DC&gt;(he), &lt;U+0938&gt;&lt;U+0902&gt;&lt;U+0927&gt;&lt;U+093E&gt;&lt;U+0930&gt;&lt;U+093F&gt;&lt;U+0924&gt;&lt;U+094D&gt;&lt;U+0930&gt;(hi), Elektricni kondenzator(hr), Kondenz攼㸱tor(hu), condensator(ia), Kondensator(id), Kondensatoro(io), Raf昼㹥攼㸹ttir(is), &lt;U+30B3&gt;&lt;U+30F3&gt;&lt;U+30C7&gt;&lt;U+30F3&gt;&lt;U+30B5&gt;(ja), Kondensator(jv), &lt;U+10D4&gt;&lt;U+10DA&gt;&lt;U+10D4&gt;&lt;U+10E5&gt;&lt;U+10E2&gt;&lt;U+10E0&gt;&lt;U+10E3&gt;&lt;U+10DA&gt;&lt;U+10D8&gt; &lt;U+10D9&gt;&lt;U+10DD&gt;&lt;U+10DC&gt;&lt;U+10D3&gt;&lt;U+10D4&gt;&lt;U+10DC&gt;&lt;U+10E1&gt;&lt;U+10D0&gt;&lt;U+10E2&gt;&lt;U+10DD&gt;&lt;U+10E0&gt;&lt;U+10D8&gt;(ka), &lt;U+041C&gt;&lt;U+0414&gt;&lt;U+0428&gt;-&lt;U+043A&gt;&lt;U+043E&gt;&lt;U+043D&gt;&lt;U+0434&gt;&lt;U+0435&gt;&lt;U+043D&gt;&lt;U+0441&gt;&lt;U+0430&gt;&lt;U+0442&gt;&lt;U+043E&gt;&lt;U+0440&gt;(kk), &lt;U+CD95&gt;&lt;U+C804&gt;&lt;U+AE30&gt;(ko), Kondansator(ku), Condensatrum(la), Kondensatorius(lt), Kondensators(lv), &lt;U+043A&gt;&lt;U+043E&gt;&lt;U+043D&gt;&lt;U+0434&gt;&lt;U+0435&gt;&lt;U+043D&gt;&lt;U+0437&gt;&lt;U+0430&gt;&lt;U+0442&gt;&lt;U+043E&gt;&lt;U+0440&gt;(mk), &lt;U+0D15&gt;&lt;U+0D2A&gt;&lt;U+0D4D&gt;&lt;U+0D2A&gt;&lt;U+0D3E&gt;&lt;U+0D38&gt;&lt;U+0D3F&gt;&lt;U+0D31&gt;&lt;U+0D4D&gt;&lt;U+0D31&gt;&lt;U+0D7C&gt;(ml), &lt;U+041A&gt;&lt;U+043E&gt;&lt;U+043D&gt;&lt;U+0434&gt;&lt;U+0435&gt;&lt;U+043D&gt;&lt;U+0441&gt;&lt;U+0430&gt;&lt;U+0442&gt;&lt;U+043E&gt;&lt;U+0440&gt;(mn), &lt;U+0927&gt;&lt;U+093E&gt;&lt;U+0930&gt;&lt;U+093F&gt;&lt;U+0924&gt;&lt;U+094D&gt;&lt;U+0930&gt;(mr), Pemuat(ms), &lt;U+101C&gt;&lt;U+103B&gt;&lt;U+103E&gt;&lt;U+1015&gt;&lt;U+103A&gt;&lt;U+101E&gt;&lt;U+102D&gt;&lt;U+102F&gt;(my), condensator(nl), kondensator(nn), Condensador(oc), &lt;U+0A38&gt;&lt;U+0A70&gt;&lt;U+0A27&gt;&lt;U+0A3E&gt;&lt;U+0A30&gt;&lt;U+0A3F&gt;&lt;U+0A24&gt;&lt;U+0A30&gt;(pa), kondensator(pl), Condensator(pms), &lt;U+06A9&gt;&lt;U+06CC&gt;&lt;U+067E&gt;&lt;U+06CC&gt;&lt;U+0633&gt;&lt;U+06CC&gt;&lt;U+0679&gt;&lt;U+0631&gt;(pnb), &lt;U+06A9&gt;&lt;U+0627&gt;&lt;U+0646&gt;&lt;U+0689&gt;&lt;U+0646&gt;&lt;U+0633&gt;&lt;U+0631&gt;(ps), capacitor(pt), capacitor(pt-br), &lt;U+044D&gt;&lt;U+043B&gt;&lt;U+0435&gt;&lt;U+043A&gt;&lt;U+0442&gt;&lt;U+0440&gt;&lt;U+0438&gt;&lt;U+0447&gt;&lt;U+0435&gt;&lt;U+0441&gt;&lt;U+043A&gt;&lt;U+0438&gt;&lt;U+0439&gt; &lt;U+043A&gt;&lt;U+043E&gt;&lt;U+043D&gt;&lt;U+0434&gt;&lt;U+0435&gt;&lt;U+043D&gt;&lt;U+0441&gt;&lt;U+0430&gt;&lt;U+0442&gt;&lt;U+043E&gt;&lt;U+0440&gt;(ru), &lt;U+041A&gt;&lt;U+043E&gt;&lt;U+043D&gt;&lt;U+0434&gt;&lt;U+0435&gt;&lt;U+043D&gt;&lt;U+0437&gt;&lt;U+0430&gt;&lt;U+0442&gt;&lt;U+043E&gt;&lt;U+0440&gt;(rue), Kondenzator(sh), &lt;U+0DB0&gt;&lt;U+0DCF&gt;&lt;U+0DBB&gt;&lt;U+0DD2&gt;&lt;U+0DAD&gt;&lt;U+0DCA&gt; &lt;U+0DBB&gt;&lt;U+0D9A&gt;(si), kondenz攼㸱tor(sk), Kondenzator(sl), Kondensatori(sq), &lt;U+043A&gt;&lt;U+043E&gt;&lt;U+043D&gt;&lt;U+0434&gt;&lt;U+0435&gt;&lt;U+043D&gt;&lt;U+0437&gt;&lt;U+0430&gt;&lt;U+0442&gt;&lt;U+043E&gt;&lt;U+0440&gt;(sr), Kondensatore(stq), Kapasitor(su), kondensator(sv), &lt;U+0BAE&gt;&lt;U+0BBF&gt;&lt;U+0BA9&gt;&lt;U+0BCD&gt;&lt;U+0BA4&gt;&lt;U+0BC7&gt;&lt;U+0B95&gt;&lt;U+0BCD&gt;&lt;U+0B95&gt;&lt;U+0BBF&gt;(ta), &lt;U+0E15&gt;&lt;U+0E31&gt;&lt;U+0E27&gt;&lt;U+0E40&gt;&lt;U+0E01&gt;&lt;U+0E47&gt;&lt;U+0E1A&gt;&lt;U+0E1B&gt;&lt;U+0E23&gt;&lt;U+0E30&gt;&lt;U+0E08&gt;&lt;U+0E38&gt;(th), Kapasitor(tl), Kondansat昼㸶r(tr), &lt;U+041A&gt;&lt;U+043E&gt;&lt;U+043D&gt;&lt;U+0434&gt;&lt;U+0435&gt;&lt;U+043D&gt;&lt;U+0441&gt;&lt;U+0430&gt;&lt;U+0442&gt;&lt;U+043E&gt;&lt;U+0440&gt;(tt), &lt;U+0643&gt;&lt;U+0648&gt;&lt;U+0646&gt;&lt;U+062F&gt;&lt;U+06D0&gt;&lt;U+0646&gt;&lt;U+0633&gt;&lt;U+0627&gt;&lt;U+062A&gt;&lt;U+0648&gt;&lt;U+0631&gt;(ug), &lt;U+0415&gt;&lt;U+043B&gt;&lt;U+0435&gt;&lt;U+043A&gt;&lt;U+0442&gt;&lt;U+0440&gt;&lt;U+0438&gt;&lt;U+0447&gt;&lt;U+043D&gt;&lt;U+0438&gt;&lt;U+0439&gt; &lt;U+043A&gt;&lt;U+043E&gt;&lt;U+043D&gt;&lt;U+0434&gt;&lt;U+0435&gt;&lt;U+043D&gt;&lt;U+0441&gt;&lt;U+0430&gt;&lt;U+0442&gt;&lt;U+043E&gt;&lt;U+0440&gt;(uk), &lt;U+06AF&gt;&lt;U+0646&gt;&lt;U+062C&gt;&lt;U+0627&gt;&lt;U+0626&gt;&lt;U+0634&gt;&lt;U+062F&gt;&lt;U+0627&gt;&lt;U+0631&gt;(ur), T&lt;U+1EE5&gt; di&lt;U+1EC7&gt;n(vi), Kapasitor(war), Fattalukaay(wo), &lt;U+05E7&gt;&lt;U+05D0&gt;&lt;U+05E0&gt;&lt;U+05D3&gt;&lt;U+05E2&gt;&lt;U+05E0&gt;&lt;U+05E1&gt;&lt;U+05D0&gt;&lt;U+05D8&gt;&lt;U+05D0&gt;&lt;U+05E8&gt;(yi), &lt;U+7535&gt;&lt;U+5BB9&gt;&lt;U+5668&gt;(zh), &lt;U+96FB&gt;&lt;U+5BB9&gt;(yue), Kondensator(de-ch), Toilleoir(ga), &lt;U+0915&gt;&lt;U+094D&gt;&lt;U+092F&gt;&lt;U+093E&gt;&lt;U+092A&gt;&lt;U+093E&gt;&lt;U+0938&gt;&lt;U+093F&gt;&lt;U+0924&gt;&lt;U+0930&gt;(new), &lt;U+041A&gt;&lt;U+043E&gt;&lt;U+043D&gt;&lt;U+0434&gt;&lt;U+0435&gt;&lt;U+043D&gt;&lt;U+0441&gt;&lt;U+0430&gt;&lt;U+0442&gt;&lt;U+043E&gt;&lt;U+0440&gt;(os), &lt;U+043A&gt;&lt;U+043E&gt;&lt;U+043D&gt;&lt;U+0434&gt;&lt;U+0435&gt;&lt;U+043D&gt;&lt;U+0437&gt;&lt;U+0430&gt;&lt;U+0442&gt;&lt;U+043E&gt;&lt;U+0440&gt;(sr-ec), kondenzator(sr-el), capacitor(sco), condensator electric(ro), &lt;U+042D&gt;&lt;U+043B&gt;&lt;U+0435&gt;&lt;U+043A&gt;&lt;U+0442&gt;&lt;U+0440&gt;&lt;U+0438&gt;&lt;U+0447&gt;&lt;U+0435&gt;&lt;U+0441&gt;&lt;U+043A&gt;&lt;U+0438&gt; &lt;U+043A&gt;&lt;U+043E&gt;&lt;U+043D&gt;&lt;U+0434&gt;&lt;U+0435&gt;&lt;U+043D&gt;&lt;U+0441&gt;&lt;U+0430&gt;&lt;U+0442&gt;&lt;U+043E&gt;&lt;U+0440&gt;(ce), Kondensator(uz), &lt;U+062E&gt;&lt;U+0627&gt;&lt;U+0632&gt;&lt;U+0646&gt;(mzn), &lt;U+043A&gt;&lt;U+0430&gt;&lt;U+043D&gt;&lt;U+0434&gt;&lt;U+044D&gt;&lt;U+043D&gt;&lt;U+0441&gt;&lt;U+0430&gt;&lt;U+0442&gt;&lt;U+0430&gt;&lt;U+0440&gt;(be-tarask), Kondensator(gsw), Kondensaator(frr), Kadobo(mg), &lt;U+0567&gt;&lt;U+056C&gt;&lt;U+0565&gt;&lt;U+056F&gt;&lt;U+057F&gt;&lt;U+0580&gt;&lt;U+0561&gt;&lt;U+056F&gt;&lt;U+0561&gt;&lt;U+0576&gt; &lt;U+056F&gt;&lt;U+0578&gt;&lt;U+0576&gt;&lt;U+0564&gt;&lt;U+0565&gt;&lt;U+0576&gt;&lt;U+057D&gt;&lt;U+0561&gt;&lt;U+057F&gt;&lt;U+0578&gt;&lt;U+0580&gt;(hy), &lt;U+0915&gt;&lt;U+094D&gt;&lt;U+092F&gt;&lt;U+093E&gt;&lt;U+092A&gt;&lt;U+093E&gt;&lt;U+0938&gt;&lt;U+093F&gt;&lt;U+091F&gt;&lt;U+0930&gt;(ne), Kaappaasiterii(om), &lt;U+06A9&gt;&lt;U+0648&gt;&lt;U+0646&gt;&lt;U+062F&gt;&lt;U+0627&gt;&lt;U+0646&gt;&lt;U+0633&gt;&lt;U+0627&gt;&lt;U+062A&gt;&lt;U+0648&gt;&lt;U+0631&gt;(azb), Tian-i昼㸴ng-kh攼㹣(nan), condensador(ast), &lt;U+09A7&gt;&lt;U+09BE&gt;&lt;U+09F0&gt;&lt;U+0995&gt;(as), Kiapasita(jam), &lt;U+042D&gt;&lt;U+043B&gt;&lt;U+0435&gt;&lt;U+043A&gt;&lt;U+0442&gt;&lt;U+0440&gt; &lt;U+043A&gt;&lt;U+043E&gt;&lt;U+043D&gt;&lt;U+0434&gt;&lt;U+0435&gt;&lt;U+043D&gt;&lt;U+0441&gt;&lt;U+0430&gt;&lt;U+0442&gt;&lt;U+043E&gt;&lt;U+0440&gt;&lt;U+044B&gt;(ba), &lt;U+0C15&gt;&lt;U+0C46&gt;&lt;U+0C2A&gt;&lt;U+0C3E&gt;&lt;U+0C38&gt;&lt;U+0C3F&gt;&lt;U+0C1F&gt;&lt;U+0C30&gt;&lt;U+0C4D&gt;(te), &lt;U+7535&gt;&lt;U+5BB9&gt;&lt;U+5668&gt;(wuu), &lt;U+041A&gt;&lt;U+043E&gt;&lt;U+043D&gt;&lt;U+0434&gt;&lt;U+0435&gt;&lt;U+043D&gt;&lt;U+0441&gt;&lt;U+0430&gt;&lt;U+0442&gt;&lt;U+043E&gt;&lt;U+0440&gt;(tg), Kondensatoa(bar), &lt;U+041A&gt;&lt;U+043E&gt;&lt;U+043D&gt;&lt;U+0434&gt;&lt;U+0435&gt;&lt;U+043D&gt;&lt;U+0441&gt;&lt;U+0430&gt;&lt;U+0442&gt;&lt;U+043E&gt;&lt;U+0440&gt;(ky), Kapasita(sw), &lt;U+0927&gt;&lt;U+0930&gt;&lt;U+0928&gt;&lt;U+0940&gt;(bho), Condensator (elettrotecnica)(lmo), &lt;U+0643&gt;&lt;U+0648&gt;&lt;U+0646&gt;&lt;U+062F&gt;&lt;U+0627&gt;&lt;U+0633&gt;&lt;U+0627&gt;&lt;U+062A&gt;&lt;U+0648&gt;&lt;U+0631&gt;(ary), &lt;U+96FB&gt;&lt;U+5BB9&gt;&lt;U+5668&gt;(zh-hant), Elektrik kondensator(crh), Asguday(shi)"</span></code></pre>

</div>

Para poder entender como usar la información, es necesario entender el modelo de datos o el diccionario de datos de la fuente en este caso de [wikipedia](https://www.mediawiki.org/wiki/Wikibase/DataModel), que si es bastante complicado, pero una vez comprendido, se tiene a una gran fuente de datos.

# Leer información por medio de REST API (XML)

Tomamos el mismo ejemplo, extraer toda la información de wikipedia de lo que es un capacitor.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://httr.r-lib.org/'>httr</a></span><span class='o'>)</span>
<span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='http://www.omegahat.net/RSXML'>XML</a></span><span class='o'>)</span>
<span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://arxiv.org/abs/1403.2805'>jsonlite</a></span><span class='o'>)</span>

<span class='nv'>query</span> <span class='o'>&lt;-</span> 
  <span class='s'>'https://www.wikidata.org/w/api.php?action=wbgetentities&amp;ids=Q5322&amp;languages=en&amp;format=xml'</span>
<span class='nv'>response</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://httr.r-lib.org/reference/GET.html'>GET</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/utils/URLencode.html'>URLencode</a></span><span class='o'>(</span><span class='nv'>query</span><span class='o'>)</span><span class='o'>)</span>
<span class='nv'>response</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/r/base/rawConversion.html'>rawToChar</a></span><span class='o'>(</span><span class='nv'>response</span><span class='o'>$</span><span class='nv'>content</span><span class='o'>)</span>
<span class='nv'>response</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/pkg/XML/man/xmlTreeParse.html'>xmlParse</a></span><span class='o'>(</span><span class='nv'>response</span><span class='o'>)</span>
<span class='nv'>response</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/pkg/XML/man/xmlToList.html'>xmlToList</a></span><span class='o'>(</span><span class='nv'>response</span><span class='o'>)</span></code></pre>

</div>

Aquí te dejo la versión de los paquetes que se usó en esta sesión.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='c'>#&gt;  package  * version  date       lib source        </span>
<span class='c'>#&gt;  DBI        1.1.1    2021-01-15 [1] CRAN (R 4.0.4)</span>
<span class='c'>#&gt;  httr     * 1.4.2    2020-07-20 [1] CRAN (R 4.0.2)</span>
<span class='c'>#&gt;  jsonlite * 1.7.2    2020-12-09 [1] CRAN (R 4.0.4)</span>
<span class='c'>#&gt;  odbc       1.3.1    2021-03-16 [1] CRAN (R 4.0.4)</span>
<span class='c'>#&gt;  openxlsx * 4.2.3    2020-10-27 [1] CRAN (R 4.0.4)</span>
<span class='c'>#&gt;  RODBC      1.3-17   2020-05-11 [1] CRAN (R 4.0.0)</span>
<span class='c'>#&gt;  XML      * 3.99-0.7 2021-08-17 [1] CRAN (R 4.0.5)</span>
<span class='c'>#&gt; </span>
<span class='c'>#&gt; [1] C:/Users/d_mor/Documents/R/win-library/4.0</span>
<span class='c'>#&gt; [2] C:/Program Files/R/R-4.0.5/library</span></code></pre>

</div>

Te invito a realizar tus propias conexiones, aplicarlo en algún proyecto personal o laboral. Si tienes alguna pregunta o consejo, déjalo en los comentarios.

<div/>

### Te parece útil? Considera compartirlo 🙌

