---
title: Tengo datos. ¿Y ahora qué?
summary: Como importar datos a R de distintas fuentes.
tags: ["Data Science","Deep Learning", "R"]
date: 2021-09-18

# Optional external URL for project (replaces project detail page).
external_link: ""

image:
  caption: ""
  focal_point: "Smart"
  placement: 1

links:
- icon: twitter
  icon_pack: fab
  name: Follow
  url: https://twitter.com/georgecushen
url_code: ""
url_pdf: ""
url_slides: ""
url_video: ""

# Slides (optional).
#   Associate this project with Markdown slides.
#   Simply enter your slide deck's filename without extension.
#   E.g. `slides = "example-slides"` references `content/slides/example-slides.md`.
#   Otherwise, set `slides = ""`.
slides: []
---

Esta es una serie de post, que nos ayudará a ver de manera aplicada los conceptos de estadística y de machine learning. Para comenzar, lo primero es conseguir información.
Asumiendo que ya tenemos esto, el siguiente paso es ahora poder gestionarla dentro de R. 

Podemos tener información en distintos formatos, desde un texto plano, separado por comas, excel, URL, base de datos, json,etc. Nos ayudaremos de datos abiertos de [kaggle](https://www.kaggle.com/priankravichandar/airline-delays-from-20032016/metadata) y de [openml](https://www.openml.org/).

# Leer información desde web

El dataset "airlines" se compone por la información de los vuelos en Estados Unidos del 2003 al 2016.

```{r}

airline <- read.csv('https://corgis-edu.github.io/corgis/datasets/csv/airlines/airlines.csv')

head(airline)

```
Se uso la funcion read.csv, ya que la informacion se encuentra separada por comas. Si la informacion estuviera separa por otro caracter, se agregaria el parametro *sep = "/"* por ejemplo.

I'm a very infrequent contributor to [#TidyTuesday](https://github.com/rfordatascience/tidytuesday) (though always planning to do more!)

As and when I do get a chance to participate, I'll be sharing my visualisations here.
