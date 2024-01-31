[![version](https://img.shields.io/badge/version-1.0.0-blue)](https://github.com/ibarram/CF/)
[![GitHub commit activity (branch)](https://img.shields.io/github/commit-activity/w/ibarram/CF)](https://github.com/ibarram/CF/)
[![GitHub discussions](https://img.shields.io/github/discussions/ibarram/CF)](https://github.com/ibarram/CF/discussions)
[![GitHub issues](https://img.shields.io/github/issues/ibarram/CF)](https://github.com/ibarram/CF/issues)
![Gitter](https://img.shields.io/gitter/room/ibarram/CF)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

<br />
<div align="center">
  <a href="https://github.com/ibarram/CF">
    <img src="/doc/img/escudo-png.png" alt="Logo" width="120" height="120">
  </a>

  <h3 align="center">Computación Flexible</h3>

  <p align="center">
    Redes neuronales artificiales y algoritmos genéticos.
    <br />
    <a href="https://github.com/ibarram/CF"><strong>Explorar la documentación »</strong></a>
    <br />
    <br />
    <a href="https://github.com/ibarram/CF">Ver Demo</a>
    ·
    <a href="https://github.com/ibarram/CF/issues">Reportar Bug</a>
    ·
    <a href="https://github.com/ibarram/CF/issues">Requiere Modificaciones</a>
  </p>
</div>

<details><summary>Table of Contents</summary><p>
 
 * [Resumen](#resumen)

 * [Redes Neuronales Artificiales](#Redes-Neuronales-Artificiales)

 * [Perceptrón simple](#Perceptrón-simple)

 * [License](#license)

</p></details><p></p>

## Resumen

La computación flexible en un subcampo multidisciplinario que se centra en el desarrollo de sistemas y algoritmos que pueden realizar tareas que normalmente requieren inteligencia humana, como el aprendizaje, la percepción, el razonamiento y la toma de decisión, este subcampo pertenece a la Inteligencia Artificial.

Dentro de la IA, las redes neuronales se relacionan principalmente con el subcampo del Aprendizaje Automático, que se basa en modelos inspirados en la estructura y el funcionamiento de las redes neuronales biológicas para realizar tareas de procesamiento de información, como el reconocimiento de patrones, el procesamiento de lenguaje natural y la visión por computadora.

Los algoritmos genéticos, por otro lado, son una técnica de optimización y búsqueda que se utiliza en la IA para encontrar soluciones óptimas o aproximadas a problemas complejos mediante la evolución de poblaciones de soluciones potenciales a lo largo de generaciones, similar a cómo funciona la evolución en la naturaleza.

Ambos enfoques, redes neuronales y algoritmos genéticos, son herramientas importantes en el campo de la inteligencia artificial y se utilizan en una variedad de aplicaciones, desde el procesamiento de datos hasta la toma de decisiones, la optimización y la resolución de problemas complejos.

## Redes Neuronales Artificiales

Las redes neuronales artificiales (RNA), también conocidas como redes neuronales o simplemente NN (por sus siglas en inglés, Neural Networks), son modelos computacionales inspirados en el funcionamiento del cerebro humano y diseñados para realizar tareas de aprendizaje automático y procesamiento de datos. Estas redes son una parte fundamental de la inteligencia artificial y han demostrado ser muy efectivas en una amplia gama de aplicaciones.

Las redes neuronales artificiales se componen de unidades básicas llamadas "neuronas artificiales" o "nodos", que están organizadas en capas interconectadas. A continuación, se explican sus componentes y funcionamiento básico:

1. **Neuronas Artificiales (Nodos):** Cada neurona artificial es una unidad de procesamiento que toma una o más entradas, realiza una suma ponderada de esas entradas y luego aplica una función de activación antes de emitir una salida. La función de activación introduce no linealidad en el modelo y es crucial para que la red pueda aprender y modelar relaciones complejas en los datos.

2. **Capas:** Las neuronas se organizan en capas en la red neuronal. Las capas se dividen típicamente en tres tipos:
    * **Capa de Entrada:** Recibe las señales de entrada y transmite estas señales a la capa oculta.
    * **Capas Ocultas (Hidden Layers):** Estas capas intermedias procesan la información y realizan cálculos para aprender representaciones más abstractas y complejas de los datos.
    * **Capa de Salida:** Produce la salida final de la red, que puede ser una clasificación, una predicción numérica o cualquier otro tipo de resultado deseado.

3. **Conexiones Ponderadas:** Cada conexión entre neuronas tiene un peso asociado que determina la importancia relativa de la entrada en la neurona receptora. Estos pesos se ajustan durante el proceso de entrenamiento para aprender la relación entre las entradas y las salidas deseadas.

4. **Aprendizaje:** Las redes neuronales artificiales aprenden ajustando los pesos de las conexiones a través de un proceso llamado entrenamiento. Esto se hace mediante algoritmos de optimización, como el descenso de gradiente, que minimizan una función de pérdida o error que cuantifica la diferencia entre las salidas predichas y las salidas reales.

Las redes neuronales artificiales son capaces de aprender y representar patrones complejos en datos, lo que las hace adecuadas para una amplia variedad de aplicaciones, como reconocimiento de patrones, procesamiento de lenguaje natural, visión por computadora, traducción automática, juegos, control de robots y mucho más. Su versatilidad y capacidad para manejar datos no lineales las convierten en una herramienta poderosa en el campo del aprendizaje automático y la inteligencia artificial.

Las notas de clase referentes a las Redes Neuronales Artificiales puede descargarlas desde el siguiente enlace: [Notas_RNA](/doc/pdf/Notas_RNA.pdf).

## Perceptrón simple
Un perceptrón simple es un tipo de red neuronal artificial inventada en 1957 por Frank Rosenblatt. Puede considerarse como la forma más básica de una red neuronal y se utiliza principalmente para la clasificación binaria, es decir, para predecir si una entrada pertenece a una de dos posibles categorías ($0$ o $1$, sí o no, verdadero o falso, etc.).

El funcionamiento de un perceptrón se basa en la suma ponderada de sus entradas para producir una salida. Las "entradas" (inputs) son características numéricas de un elemento que se quiere clasificar, y cada una de estas entradas se multiplica por un "peso" (weight) que indica la importancia de dicha entrada en la determinación de la salida. Además, a la suma de estas entradas ponderadas se le puede añadir un término llamado "sesgo" (bias), que ajusta la salida del perceptrón para ser más flexible.

Matemáticamente, la salida $y$ de un perceptrón se calcula de la siguiente manera:

$$y=f(w_1x_1+w_2x_2+...+w_nx_n+\theta)=f\left(\sum_{i=1}^{n}w_ix_i+\theta\right)$$

donde:

* $x_1$, $x_2$, ..., $x_n$ son las $n$ entradas,
* $w_1$, $w_2$, ..., $w_n$ son los $n$ pesos asociados a cada entrada,
* $\theta$ es el sesgo,
* $f$ es una función de activación que decide si la suma ponderada de las entradas activa la neurona para producir la salida $1$ o se queda inactiva produciendo la salida $0$. Una función de activación común en los perceptrones simples es la función escalón.

El perceptrón simple aprende ajustando los pesos y el sesgo a través de un proceso de entrenamiento con un conjunto de datos de entrada para el cual se conocen las salidas deseadas. El objetivo del entrenamiento es minimizar el error en las predicciones del modelo ajustando los pesos y el sesgo basándose en las diferencias entre las salidas predichas y las reales.

A pesar de su simplicidad y sus limitaciones (por ejemplo, solo puede clasificar linealmente problemas separables), el perceptrón simple ha sido fundamental en el desarrollo y la comprensión de redes neuronales más complejas y sigue siendo un concepto importante en el campo del aprendizaje automático y la inteligencia artificial.

El algoritmo de aprendizaje ajusta los pesos $w$ en función del error existente entre las salidas deseadas $d$ y las salidas obtenidas $y$. El factor de aprendizaje $\eta$ que esta definido en el rango $\left(0<\eta<\frac{1}{|\textbf{x}(k)|_{max}}\right)$, permite ajustar la fracción del error que será usado en el ajuste del peso. El factor de momentum $\mu$ que esta definido en el rango de $\left(0.6<\mu<0.9\right)$, permite agregar un factor de velocidad de aprendizaje al algoritmo.

El algoritmo de aprendizaje esta definido por la siguiente ecuación:

$$\textbf{w}(t+1)=\textbf{w}(t)+\eta\sum_{k=1}^{K}\left(\left[d(k)-y(k)\right]\cdot\textbf{x}(k)\right)+\mu\left(\textbf{w}(t)-\textbf{w}(t+1)\right)$$
