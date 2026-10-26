# Forest Fires Analitica con Machine Learning

## A. Titulo del Proyecto y Resumen Ejecutivo

Forest Fires Analitica con Machine Learning es un miniproyecto de analítica de datos que aplica algoritmos de machine learning sobre incendios forestales del Parque Natural de Montesinho, Portugal, durante el periodo 1999-2000. El sistema analiza el dataset forestfires.csv, que contiene 517 registros con variables meteorologicas (temperatura, humedad, viento, indices FWI) y el area quemada, para identificar factores relacionados con la temperatura, la propagacion (ISI) y el area quemada. Su alcance tecnologico se limita al analisis estadistico y modelado predictivo local en R, sin componente de servidor ni persistencia de datos.

## B. Arquitectura del Sistema

El programa sigue una arquitectura secuencial de analisis de datos. El flujo comienza con la lectura del archivo forestfires.csv, seguido de la instalacion condicional de los paquetes de R requeridos (ggplot2, dplyr, rpart, rpart.plot, e1071, randomForest). Posteriormente se ejecuta analisis exploratorio de datos, se aplican transformaciones log-area para manejar distribuciones sesgadas, y se entrenan y comparan multiples algoritmos de regresion: regresion lineal multiple, regresion polinomial, maquinas de vectores de soporte con kernels radial y sigmoide, random forest y arbol de decision. Los resultados se visualizan mediante graficas generadas con ggplot2 y rpart.plot. No existe arquitectura cliente-servidor ni capas de persistencia.

## C. Caracteristicas Tecnicas Clave

- Analisis exploratorio de datos: distribucion del area quemada por mes y frecuencia por dia.
- Regresion lineal múltiple y polinomial sobre variables meteorologicas.
- Maquinas de vectores de soporte (SVM) con kernels radial y sigmoide.
- Random Forest con 500 arboles y arbol de decision (rpart) con visualizacion rpart.plot.
- Transformacion log(area + 1) para manejar la distribucion sesgada del area quemada.
- Visualizaciones con ggplot2, dplyr y rpart.plot.
- No utiliza base de datos, ni concurrencia, ni procesamiento en tiempo real, ni protocolos de red.
- Seguridad limitada al ambito de ejecucion local; no maneja datos sensibles ni autenticacion.

## D. Especificacion del Stack Tecnologico

| Categoria | Tecnologia / Librería |
|-----------|----------------------|
| Lenguaje | R |
| Paquetes | ggplot2, dplyr, rpart, rpart.plot, e1071, randomForest |
| Dataset | forestfires.csv (517 registros, 1999-2000) |
| Analisis | Machine learning, regresion, SVM, Random Forest, arboles de decision |

## E. Guia de Instalacion, Configuracion y Despliegue

### Requisitos previos del sistema

- R o RStudio instalado en el sistema operativo.
- Conexión a Internet para instalacion de paquetes de R si no estan disponibles localmente.

### Secuencia de comandos para clonacion e instalacion

```bash
git clone https://github.com/Matthew-Garay/forestfires.git
cd forestfires
```

### Configuracion de variables de entorno

Este proyecto no requiere archivo .env ni variables de entorno.

### Comandos para ejecucion en entorno de Desarrollo

```r
source("forestfiresanalisis.R")
```

### Comandos para ejecucion en entorno de Produccion

No aplica entorno de produccion separado; el script se ejecuta localmente con el mismo comando de desarrollo.

## F. Creditos de Autoría

Desarrollado por: Matthew Ilveneff Garay Pérez
Correo Electronico: 1911.garay.perez@gmail.com

