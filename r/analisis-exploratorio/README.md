# Analisis Exploratorio del CPS 1985

## A. Titulo del Proyecto y Resumen Ejecutivo

Analisis Exploratorio del CPS 1985 es un script de analisis exploratorio de datos (EDA) sobre los salarios por hora del Current Population Survey de 1985, almacenados en el archivo CPS1985.csv. El programa construye y refina de forma progresiva el histograma de la distribucion salarial para estudiar su forma, asimetria y comportamiento frente a la transformacion logaritmica. Su alcance tecnologico se limita al analisis estadistico descriptivo y a la visualizacion con R base, sin componente de servidor ni persistencia de datos.

## B. Arquitectura del Sistema

El programa sigue una arquitectura secuencial de procesamiento de datos. El flujo comienza con la carga del archivo CSV CPS1985.csv en el entorno de ejecucion de R. Posteriormente se construye un histograma de la distribucion salarial, se analiza la forma y asimetria de la misma, se aplica una transformacion logaritmica a los salarios y finalmente se comparan las distribuciones original y transformada. No hay capas logicas separadas ni patrones de diseño arquitectonico; todo el procesamiento ocurre dentro de un unico script de R.

## C. Caracteristicas Tecnicas Clave

- Carga de datos desde archivo CSV delimitado.
- Construccion de histogramas de distribucion salarial con R base.
- Analisis de forma y asimetria de la distribucion de salarios.
- Transformacion logaritmica de variables salariales para normalizacion visual.
- Comparacion de distribuciones antes y despues de la transformacion.
- No utiliza base de datos, ni concurrencia, ni procesamiento en tiempo real, ni protocolos de red.
- Seguridad limitada al ambito de ejecucion local; no maneja datos sensibles ni autenticacion.

## D. Especificacion del Stack Tecnologico

| Categoria | Tecnologia / Librería |
|-----------|----------------------|
| Lenguaje | R 4.x |
| Analisis | Estadistica descriptiva, analisis exploratorio de datos, transformacion logaritmica |
| Visualizacion | R base |

## E. Guia de Instalacion, Configuracion y Despliegue

### Requisitos previos del sistema

- R 4.x instalado en el sistema operativo.
- Acceso a terminal o consola de comandos.

### Secuencia de comandos para clonacion e instalacion

```bash
git clone https://github.com/Matthew-Garay/Analisisexploratorio.git
cd Analisisexploratorio
```

### Configuracion de variables de entorno

Este proyecto no requiere archivo .env ni variables de entorno.

### Comandos para ejecucion en entorno de Desarrollo

```bash
Rscript Practica8.R
```

### Comandos para ejecucion en entorno de Produccion

No aplica entorno de produccion separado; el script se ejecuta localmente con el mismo comando de desarrollo.

## F. Creditos de Autoría

Desarrollado por: Matthew Ilveneff Garay Pérez
Correo Electronico: 1911.garay.perez@gmail.com
