# ============================================================================
# Practica8.R - Analisis Exploratorio de Datos (EDA) del CPS 1985
# Refactorizado: modularizacion en funciones, eliminacion de attach(),
# paleta de colores neutra y validacion de entrada.
# ============================================================================

# ----------------------------------------------------------------------------
# Validacion de archivo de entrada
# ----------------------------------------------------------------------------
archivo_csv <- "CPS1985.csv"

if (!file.exists(archivo_csv)) {
    stop("No se encontro el archivo: ", archivo_csv)
}

cps1985 <- read.csv(archivo_csv, header = TRUE)

# ----------------------------------------------------------------------------
# Funcion: graficar_histograma
# Dibuja un histograma con estilo limpio: paleta neutra, bordes sutiles,
# margenes consistentes y sin colores saturados.
# ----------------------------------------------------------------------------
graficar_histograma <- function(datos, variable, titulo, etiqueta_x, etiqueta_y,
                                breaks = 20, xlim = NULL, ylim = NULL,
                                color_relleno = "#FFFFFF", color_borde = "#2C3E50") {
    hist(
        datos[[variable]],
        breaks = breaks,
        main = titulo,
        xlab = etiqueta_x,
        ylab = etiqueta_y,
        xlim = xlim,
        ylim = ylim,
        col = color_relleno,
        border = color_borde,
        axes = TRUE
    )
}

# ----------------------------------------------------------------------------
# Funcion: agregar_curva_densidad
# Superpone una curva de densidad sobre el histograma actual.
# ----------------------------------------------------------------------------
agregar_curva_densidad <- function(datos, variable, color = "#2C3E50", ajuste = 1, grosor = 2) {
    lines(density(datos[[variable]], adjust = ajuste), col = color, lwd = grosor)
}

# ----------------------------------------------------------------------------
# Funcion: agregar_linea_media
# Dibuja una linea vertical en la media de la variable.
# ----------------------------------------------------------------------------
agregar_linea_media <- function(datos, variable, color = "#34495E", grosor = 2, tipo_linea = 2) {
    abline(v = mean(datos[[variable]], na.rm = TRUE), col = color, lwd = grosor, lty = tipo_linea)
}

# ----------------------------------------------------------------------------
# Ejecucion del analisis exploratorio
# ----------------------------------------------------------------------------

# Resumen estadistico del dataset
cat("=== Analisis Exploratorio CPS 1985 ===\n", sep = "")
cat("Dimensiones del dataset:\n")
print(dim(cps1985))
cat("\nNombres de variables:\n")
print(names(cps1985))
cat("\nResumen estadistico:\n")
print(summary(cps1985))

# Configuracion de margenes consistentes (multiplos de 8px equivalentes en R)
par(mar = c(5, 5, 4, 2) + 0.1)

# ----------------------------------------------------------------------------
# Histograma 1: Distribucion original de salarios
# ----------------------------------------------------------------------------
graficar_histograma(
    datos = cps1985,
    variable = "wage",
    titulo = "Distribucion del salario (Dolares por hora)",
    etiqueta_x = "Salario",
    etiqueta_y = "Numero de personas",
    breaks = 20,
    xlim = c(0, 50),
    color_relleno = "#FFFFFF",
    color_borde = "#2C3E50"
)

agregar_curva_densidad(cps1985, "wage", color = "#2C3E50", ajuste = 1, grosor = 2)
agregar_linea_media(cps1985, "wage", color = "#34495E", grosor = 2, tipo_linea = 2)

# ----------------------------------------------------------------------------
# Histograma 2: Distribucion con escala de densidad
# ----------------------------------------------------------------------------
graficar_histograma(
    datos = cps1985,
    variable = "wage",
    titulo = "Distribucion del salario (Escala de densidad)",
    etiqueta_x = "Salario",
    etiqueta_y = "Densidad",
    breaks = 20,
    xlim = c(0, 50),
    ylim = c(0, 0.15),
    freq = FALSE,
    color_relleno = "#FFFFFF",
    color_borde = "#2C3E50"
)

agregar_curva_densidad(cps1985, "wage", color = "#2C3E50", ajuste = 1, grosor = 2)
agregar_curva_densidad(cps1985, "wage", color = "#7F8C8D", ajuste = 2, grosor = 2)
agregar_linea_media(cps1985, "wage", color = "#34495E", grosor = 2, tipo_linea = 2)

# ----------------------------------------------------------------------------
# Histograma 3: Distribucion de salario transformado (logaritmo)
# ----------------------------------------------------------------------------
graficar_histograma(
    datos = cps1985,
    variable = "log_wage",
    titulo = "Distribucion del salario logaritmico",
    etiqueta_x = "Log(Salario)",
    etiqueta_y = "Densidad",
    breaks = 20,
    xlim = c(0, 4),
    ylim = c(0, 0.80),
    freq = FALSE,
    color_relleno = "#FFFFFF",
    color_borde = "#2C3E50"
)

# Crear variable transformada si no existe
if (!"log_wage" %in% names(cps1985)) {
    cps1985$log_wage <- log(cps1985$wage)
}

agregar_curva_densidad(cps1985, "log_wage", color = "#2C3E50", ajuste = 1, grosor = 2)
agregar_curva_densidad(cps1985, "log_wage", color = "#7F8C8D", ajuste = 2, grosor = 2)
agregar_linea_media(cps1985, "log_wage", color = "#34495E", grosor = 2, tipo_linea = 2)

cat("\nAnalisis completado.\n")