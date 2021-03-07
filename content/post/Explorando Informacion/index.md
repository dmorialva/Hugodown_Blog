---
output: hugodown::md_document
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Explorando Probabilidades"
subtitle: ""
summary: ""
authors: [admin]
tags: [Data Science, Visualizacion, Estadistica]
categories: []
date: 2021-01-31
lastmod: 2021-01-31
featured: false
draft: false

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal points: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight.
image:
  caption: ""
  focal_point: ""
  preview_only: false

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects: [] 
rmd_hash: 8a01bfd975b11799

---

La teoría de probabilidad, no es un campo de la estadística, sino de la matemática (sí de la matemática), que estudia los **fenómenos aleatorios**. Sabemos que originalmente se creo a partir de los juegos de azar, con un clásico ejemplo del lanzamiento de dados, que dada las mismas condiciones de realización del experimento, en cada ejecución se obtendrá uno de todos los posibles resultados, denominándose a este conjunto *espacio muestral*. Una interpretación de la probabilidad es la frecuencia con la que un evento ocurre.

¿Pero y esto cómo se relaciona con los modelos estadísticos o los de ML (Machine Learning). Te hare vincularlo no con los ejemplos clásicos del lanzamiento de una moneda, o la extraccion de una bola de una urna, sino con problemas que seguramente ya tuviste que afrontar pero sin darte cuenta aplicaste estos conceptos.

Definición de Probabilidad
==========================

La probabilidad es un cálculo matemático o medición que se le asigna a la realización de un suceso o evento aleatorio, y esta medida cuantifica la certidumbre que el suceso pueda ocurrir.

Bajo condiciones de eventos equiprobables en el espacio muestral, es decir, que cada suceso tenga la misma probabilidad de ocurrir, la regla de Laplace define el cálculo como: $$P(evento) = \frac{Casos Favorables}{Casos Totales}$$ Por ejemplo si lanzas un dado, y anotas si el resultado fue par o no. El espacio muestral esta definido por 2 sucesos, cada uno con la misma probabilidad.

¿Y cuándo se tiene un experimento con sucesos que no sean equiprobables?. Pensemos en el lanzamiento de 2 dados y el evento como la suma de los números de los dados. En este caso la probabilidad que el resultado sea 2 ${[(1,1)]}$, es distinto a la probabilidad que el resultado sea 4 $[(3,1),(1,3),(2,2)]$ es decir no son equiprobables.

Bernoulli
---------

