---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Explorando información"
summary: ""
authors: []
tags: []
categories: []
date: 2020-11-28T18:57:52-05:00

# Optional external URL for project (replaces project detail page).
external_link: ""

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal points: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight.
image:
  caption: ""
  focal_point: ""
  preview_only: false

# Custom links (optional).
#   Uncomment and edit lines below to show custom links.
# links:
# - name: Follow
#   url: https://twitter.com
#   icon_pack: fab
#   icon: twitter

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
---

La teoría de probabilidad, no es un campo de la estadística, sino de la matemática (sí de la !matemática!), que estudia los fenómenos aleatorios. Sabemos que originalmente se creo a partir de los juegos de azar, con un clásico ejemplo del lanzamiento de dados, que dada las mismas condiciones de realización del experimento, en cada ejecución se obtendrá uno de todos los posibles resultados, denominándose a este conjunto espacio muestral. Una interpretación de la probabilidad es la frecuencia con la que un evento ocurre.

¿Pero y esto como se relaciona con los modelos estadísticos o los de ML (Machine Learning?. Te hare pensar no con los ejemplos clásicos del lanzamiento de una moneda, o la extraccion de una bola de una urna, sino con problemas que seguramente ya tuviste que afrontar pero sin darte cuenta estas aplicando estos conceptos.

```r
library(ggplot2)
```
# Distribuciones Discretas

Entre las distribuciones discretas más usadas tenemos la Bernoulli, binomial, geometrica, hipergeometrica, poisson, binomial negativa o pascal.

## Bernoulli


