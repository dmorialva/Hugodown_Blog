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
rmd_hash: 34ad1361fc4c7a95

rmd_hash: 62d8c59e417e860a

---

La teoría de probabilidad, no es un campo de la estadística, sino de la matemática (sí de la matemática), que estudia los **fenómenos aleatorios**. Sabemos que originalmente se creo a partir de los juegos de azar, con un clásico ejemplo del lanzamiento de dados, que dada las mismas condiciones de realización del experimento, en cada ejecución se obtendrá uno de todos los posibles resultados, denominándose a este conjunto *espacio muestral*. Una interpretación de la probabilidad es la frecuencia con la que un evento ocurre.

# Definición de Probabilidad

La probabilidad es un cálculo matemático o medición que se le asigna a la realización de un suceso o evento aleatorio, y esta medida cuantifica la certidumbre que el suceso pueda ocurrir.

Bajo condiciones de eventos equiprobables en el espacio muestral, es decir, que cada suceso tenga la misma probabilidad de ocurrir, la regla de Laplace define el cálculo como: $$P(evento) = \frac{Casos Favorables}{Casos Totales}$$ Por ejemplo si lanzas un dado, y anotas si el resultado fue par o no. El espacio muestral esta definido por 2 sucesos, cada uno con la misma probabilidad.

¿Y cuándo se tiene un experimento con sucesos que no sean equiprobables?. Pensemos en el lanzamiento de 2 dados y el evento como la suma de los números de los dados. En este caso la probabilidad que el resultado sea 2 ${[(1,1)]}$, es distinto a la probabilidad que el resultado sea 4 $[(3,1),(1,3),(2,2)]$ es decir no son equiprobables.

## Probabilidad de eventos independientes

Puedes pensar que 2 eventos son independientes, cuando la realización de uno no depende de la realización del otro ni influye en el resultado. Formalmente se define como: $$P(A\cap B) = P(A)P(B)$$ No confundir con *eventos disjuntos o mutuamente excluyentes*. Esto se cumple cuando no existe interseccion, es decir cuando ambos eventos no pueden ocurrir simultaneamente. La intersección de ambos eventos es el conjunto vacio.

## Probabilidad Condicional

Esto se da cuando el evento "B" influye en el resultado de la realización del evento "A". Se define como: $$P(A/B) = \frac{P(A \cap B)}{P(B)}$$ Si el evento "B" no influye sobre el "A" entonces son eventos independientes. $$P(A/B) = P(A)$$ $$P(A) = \frac{P(A \cap B)}{P(B)} \implies P(A \cap B)= P(A)P(B)$$ aksejeaiem mejrekjrken nerkjekjre

