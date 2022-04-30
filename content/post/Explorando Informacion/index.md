---
output: hugodown::md_document
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Explorando Probabilidades"
subtitle: ""
summary: "Examinaremos los tópicos iniciales de probabilidad"
authors: [admin]
tags: [Data Science, Probabilidad, Estadistica, Teorema de Bayes]
categories: []
date: 2021-01-31
lastmod: 2022-01-31
featured: false
draft: false
links:
- icon: linkedin
  icon_pack: fab
  name: Follow
  url: https://www.linkedin.com/in/morialva27/

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal points: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight.
image:
  caption: ""
  focal_point: "smart"
  preview_only: false
  placement: 1

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects: [] 
rmd_hash: e31dcb988a1ce67b

---

<div style="text-align: justify">

La teoría de probabilidad, no es un campo de la estadística, sino de la matemática (sí de la matemática), que estudia los **fenómenos aleatorios**. Sabemos que originalmente se creo al tratar de resolver algunos problemas relacionados con los juegos de azar. Por ejemplo el lanzamiento de dados, que dada las mismas condiciones de realización del experimento, en cada ejecución se obtendrá uno de todos los posibles resultados, denominándose a este conjunto *espacio muestral*. Una interpretación de la probabilidad es la frecuencia con la que un evento ocurre.

¿Y por qué nos debe interesar conocer este campo? En muchos de los temas de aplicación que podrán abordar en el día a día, mucho de estos se deseará tener medido la ocurrencia de un evento de interés, por ejemplo, la probabilidad de conversión de un cliente en una página web, o la probabilidad que un cliente no llegue a pagar el crédito que solicita, o cuál es la probabilidad que una persona pertenezca a un cluster en particular. Estoy seguro que si se detienen a pensar, ya sea en su trabajo o en su investigación, siempre existe la necesidad de medir algún evento de su interés. Para ello vamos a explicar algunas definiciones.

{{% alert note %}} Recordar que exite una diferencia entre fenomenos aleatorios o deterministas, los invito a buscar sus definiciones. {{% /alert %}}

# Definición de Probabilidad

La probabilidad es un cálculo matemático o medición que se le asigna a la realización de un suceso o evento aleatorio, y esta medida cuantifica la certidumbre que el suceso pueda ocurrir.

Bajo condiciones de eventos equiprobables en el espacio muestral, es decir, que cada suceso tenga la misma probabilidad de ocurrir, la regla de Laplace define el cálculo como: $$P(evento) = \frac{Casos Favorables}{Casos Totales}$$ Por ejemplo si lanzas un dado, y anotas si el resultado fue par o no. El espacio muestral esta definido por 2 sucesos, cada uno con la misma probabilidad.

¿Y cuándo se tiene un experimento con sucesos que no sean equiprobables?. Pensemos en el lanzamiento de 2 dados y el evento como la suma de los números de los dados. En este caso la probabilidad que el resultado sea 2 ${[(1,1)]}$, es distinto a la probabilidad que el resultado sea 4 $[(3,1),(1,3),(2,2)]$ es decir no son equiprobables.

## Probabilidad de eventos independientes

Puedes pensar que 2 eventos son independientes, cuando la realización de uno no depende de la realización del otro ni influye en el resultado. Formalmente se define como: $$P(A\cap B) = P(A)P(B)$$ No confundir con *eventos disjuntos o mutuamente excluyentes*. Esto se cumple cuando no existe interseccion, es decir cuando ambos eventos no pueden ocurrir simultaneamente. La intersección de ambos eventos es el conjunto vacio.

## Probabilidad Condicional

Esto se da cuando el evento "B" influye en el resultado de la realización del evento "A". Se define como: $$P(A/B) = \frac{P(A \cap B)}{P(B)}$$ Si el evento "B" no influye sobre el "A" entonces son eventos independientes. $$P(A/B) = P(A)$$ $$P(A) = \frac{P(A \cap B)}{P(B)} \implies P(A \cap B)= P(A)P(B)$$

{{% alert note %}} Por ejemplo, la probabilidad que no pague el credito dado que es hombre. {{% /alert %}}

## Teorema de la Probabilidad Total

Este teorema es bastante útil, cuando queremos encontrar la probabilidad de un evento a partir de las probabilidades condicionales. Para ellos debemos definir el concepto de **partición**.

**-Partición**: Si tenemos un espacio muestral "Z", se denomina *partición* si los eventos $A_1, A_2, A_3, ..., A_n$ cumplen la condición de ser **mutuamente excluyentes** y **colectivamente exhaustivos** $(A_1UA_2UA_3U...UA_n = Z)$

$$P(B) = \sum_{i=1}^{n}P(A_i)*P(B/A_i)$$

## Regla de Bayes

Thomas Bayes propuso que la probabilidad condicionada de A dado B, tambien puede ser calculada por la probabbilidad condicionada de B dado A. Esto implica un gran aporte para el campo científico, ya que vincula una explicacion de los efectos causales sobre la observación.

$$P(A_i/B) = \frac{P(B/A_i)*P(A_i)}{\sum_{k=1}^{n}P(B/A_k)*P(A_k)}$$

Dado las definiones anteriores, se puede llegar a su demostración. Este teorema mencionado, marca la una separación de la estadística tradicional o llamada frecuentista, ya que como vimos en esta publicación, tradicionalmente se espera que una probabilidad provenga de experimientos repetibles y que la evidencia sea empírica. Mientras que la estadística bayesiada, toma a las probabilidades subjetivas que se van modificando conforme se obtiene nueva información. Un ejemplo de esta aplicacion hoy en día es en el reconocimiento de correos spam con el empleo de [clasificadores bayesianos](https://es.wikipedia.org/wiki/Filtrado_bayesiano_de_spam) como también en la detección de cancer.

En la segunda parte, seguiremos examinando los conceptos de variable aleatoria, función de probabilidad y distribución de probabilidad. La aplicación la encontraremos en los tutoriales.
<div/>

### Te parece útil? Considera compartirlo 🙌

