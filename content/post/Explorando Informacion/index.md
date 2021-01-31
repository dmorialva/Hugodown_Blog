---
output: hugodown::md_document
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Explorando Informacion"
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
projects: [inicio] 
rmd_hash: 99198b6546159070

---

La teoría de probabilidad, no es un campo de la estadística, sino de la matemática (sí de la !matemática!), que estudia los fenómenos aleatorios. Sabemos que originalmente se creo a partir de los juegos de azar, con un clásico ejemplo del lanzamiento de dados, que dada las mismas condiciones de realización del experimento, en cada ejecución se obtendrá uno de todos los posibles resultados, denominándose a este conjunto espacio muestral. Una interpretación de la probabilidad es la frecuencia con la que un evento ocurre.

¿Pero y esto como se relaciona con los modelos estadísticos o los de ML (Machine Learning?. Te hare pensar no con los ejemplos clásicos del lanzamiento de una moneda, o la extraccion de una bola de una urna, sino con problemas que seguramente ya tuviste que afrontar pero sin darte cuenta estas aplicando estos conceptos.

``` r
library(ggplot2)
```

Distribuciones Discretas
========================

Entre las distribuciones discretas más usadas tenemos la Bernoulli, binomial, geometrica, hipergeometrica, poisson, binomial negativa o pascal.

Bernoulli
---------

