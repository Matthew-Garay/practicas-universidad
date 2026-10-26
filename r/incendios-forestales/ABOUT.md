# Forest Fires Analitica con Machine Learning

## Acerca de

Miniproyecto de analitica de datos que aplica algoritmos de machine learning sobre incendios forestales del Parque Natural de Montesinho, Portugal, durante el periodo 1999-2000. Analiza el dataset forestfires.csv (517 registros con variables meteorologicas e indice FWI) para identificar factores relacionados con la temperatura, la propagacion (ISI) y el area quemada. Analisis estadistico y modelado predictivo local en R, sin componente de servidor ni persistencia de datos.

## Caracteristicas principales

- Analisis exploratorio de datos: distribucion del area quemada por mes y frecuencia por dia.
- Regresion lineal multiple y polinomial sobre variables meteorologicas.
- Maquinas de vectores de soporte (SVM) con kernels radial y sigmoide.
- Random Forest con 500 arboles y arbol de decision (rpart) con visualizacion rpart.plot.
- Transformacion log(area + 1) para manejar la distribucion sesgada del area quemada.

## Stack tecnologico

| Categoria | Tecnologia |
|-----------|------------|
| Lenguaje | R |
| Paquetes | ggplot2, dplyr, rpart, rpart.plot, e1071, randomForest |
| Dataset | forestfires.csv (517 registros, 1999-2000) |
| Analisis | Machine learning, regresion, SVM, Random Forest, arboles de decision |

## Creditos

Desarrollado por: Matthew Ilveneff Garay Perez
Correo Electronico: 1911.garay.perez@gmail.com