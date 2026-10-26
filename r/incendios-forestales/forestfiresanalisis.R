# ============================================================================
# forestfiresanalisis.R - Analitica de Incendios Forestales con Machine Learning
# Refactorizado: eliminacion de install.packages(), modularizacion de graficos,
# paleta de colores neutra y titulos sin emojis.
# ============================================================================

# ----------------------------------------------------------------------------
# Carga de paquetes (deben estar instalados previamente; ver README)
# ----------------------------------------------------------------------------
library(ggplot2)
library(dplyr)
library(rpart)
library(e1071)
library(rpart.plot)
library(randomForest)

# ----------------------------------------------------------------------------
# Validacion y carga del dataset
# ----------------------------------------------------------------------------
archivo_csv <- "forestfires.csv"

if (!file.exists(archivo_csv)) {
    stop("No se encontro el archivo: ", archivo_csv)
}

forestfires <- read.csv(archivo_csv)
set.seed(123)

cat("=== Analitica de Incendios Forestales - Montesinho, Portugal ===\n", sep = "")
cat("Dimensiones del dataset ForestFires:", dim(forestfires), "\n\n")
print(summary(forestfires))

# ----------------------------------------------------------------------------
# Funcion: graficar_dispersion_regresion
# Dibuja puntos + linea de prediccion con estilo limpio: paleta neutra,
# tema minimal y sin colores saturados.
# ----------------------------------------------------------------------------
graficar_dispersion_regresion <- function(datos, x_var, y_var, modelo,
                                          titulo, etiqueta_x, etiqueta_y,
                                          color_puntos = "#2C3E50",
                                          color_linea = "#7F8C8D") {
    ggplot() +
        geom_point(aes(x = datos[[x_var]], y = datos[[y_var]]),
                   colour = color_puntos) +
        geom_line(aes(x = datos[[x_var]], y = predict(modelo, newdata = datos)),
                  colour = color_linea) +
        ggtitle(titulo) +
        xlab(etiqueta_x) +
        ylab(etiqueta_y) +
        theme_minimal(base_size = 12) +
        theme(
            plot.title = element_text(face = "bold", size = 14, margin = margin(b = 12)),
            axis.title = element_text(size = 11, margin = margin(t = 8)),
            panel.grid.minor = element_blank()
        )
}

# ----------------------------------------------------------------------------
# Analisis exploratorio: area quemada por mes
# ----------------------------------------------------------------------------
area_por_mes <- forestfires %>%
    group_by(month) %>%
    summarise(area_total = sum(area)) %>%
    arrange(desc(area_total))

ggplot(area_por_mes, aes(x = reorder(month, -area_total), y = area_total)) +
    geom_bar(stat = "identity", fill = "#2C3E50") +
    labs(title = "Total de area quemada por mes",
         x = "Mes del ano",
         y = "Area quemada total (hectareas)") +
    theme_minimal() +
    theme(
        plot.title = element_text(face = "bold", size = 14, margin = margin(b = 12)),
        axis.title = element_text(size = 11),
        panel.grid.minor = element_blank()
    )

cat("\nFrecuencia de incendios por mes:\n")
print(table(forestfires$month))

cat("\nFrecuencia de incendios por dia:\n")
print(table(forestfires$day))

# ----------------------------------------------------------------------------
# Analisis: Temperatura y Viento
# ----------------------------------------------------------------------------
multi_reg_temp_wind <- lm(temp ~ FFMC + DMC + DC + ISI + RH + wind + area,
                          data = forestfires)
cat("\n--- Regresion Lineal Multiple: temp ~ variables meteorologicas ---\n")
print(summary(multi_reg_temp_wind))

grafico_temp_wind <- graficar_dispersion_regresion(
    datos = forestfires,
    x_var = "wind",
    y_var = "temp",
    modelo = multi_reg_temp_wind,
    titulo = "Temperatura vs Viento",
    etiqueta_x = "Viento",
    etiqueta_y = "Temperatura"
)
print(grafico_temp_wind)

# Transformaciones polinomiales del viento
forestfires$wind2 <- forestfires$wind^2
forestfires$wind3 <- forestfires$wind^3
forestfires$wind4 <- forestfires$wind^4

# ----------------------------------------------------------------------------
# Maquinas de vectores de soporte (SVM): temp ~ wind
# ----------------------------------------------------------------------------
svm_radial_temp_wind <- svm(temp ~ wind, data = forestfires,
                            type = "eps-regression", kernel = "radial")
cat("\n--- SVM (kernel radial): temp ~ wind ---\n")
print(summary(svm_radial_temp_wind))

svm_sigmoid_temp_wind <- svm(temp ~ wind, data = forestfires,
                             type = "eps-regression", kernel = "sigmoid")
cat("\n--- SVM (kernel sigmoid): temp ~ wind ---\n")
print(summary(svm_sigmoid_temp_wind))

# ----------------------------------------------------------------------------
# Random Forest: temp ~ wind
# ----------------------------------------------------------------------------
rf_temp_wind <- randomForest(temp ~ wind, data = forestfires, ntree = 500)
cat("\n--- Random Forest: temp ~ wind ---\n")
print(rf_temp_wind)
plot(rf_temp_wind, main = "Random Forest: temp ~ wind")

# ----------------------------------------------------------------------------
# Arbol de decision: log(area + 1) ~ temp + wind
# ----------------------------------------------------------------------------
arbol_temp_wind <- rpart(log(area + 1) ~ temp + wind,
                         data = forestfires, method = "anova")
cat("\n--- Arbol de decision: log(area + 1) ~ temp + wind ---\n")
print(summary(arbol_temp_wind))
rpart.plot(arbol_temp_wind, main = "Propagacion segun temperatura y viento")

# ----------------------------------------------------------------------------
# Analisis: Temperatura y Humedad (RH)
# ----------------------------------------------------------------------------
multi_reg_temp_rh <- lm(temp ~ FFMC + DMC + DC + ISI + RH + wind + area,
                        data = forestfires)
cat("\n--- Regresion Lineal Multiple: temp ~ variables meteorologicas ---\n")
print(summary(multi_reg_temp_rh))

grafico_temp_rh <- graficar_dispersion_regresion(
    datos = forestfires,
    x_var = "RH",
    y_var = "temp",
    modelo = multi_reg_temp_rh,
    titulo = "Temperatura vs Humedad Relativa",
    etiqueta_x = "Humedad Relativa",
    etiqueta_y = "Temperatura"
)
print(grafico_temp_rh)

# ----------------------------------------------------------------------------
# Maquinas de vectores de soporte (SVM): temp ~ RH
# ----------------------------------------------------------------------------
svm_radial_temp_rh <- svm(temp ~ RH, data = forestfires,
                          type = "eps-regression", kernel = "radial")
cat("\n--- SVM (kernel radial): temp ~ RH ---\n")
print(summary(svm_radial_temp_rh))

svm_sigmoid_temp_rh <- svm(temp ~ RH, data = forestfires,
                           type = "eps-regression", kernel = "sigmoid")
cat("\n--- SVM (kernel sigmoid): temp ~ RH ---\n")
print(summary(svm_sigmoid_temp_rh))

# ----------------------------------------------------------------------------
# Random Forest: temp ~ RH
# ----------------------------------------------------------------------------
rf_temp_rh <- randomForest(temp ~ RH, data = forestfires, ntree = 500)
cat("\n--- Random Forest: temp ~ RH ---\n")
print(rf_temp_rh)
plot(rf_temp_rh, main = "Random Forest: temp ~ RH")

# ----------------------------------------------------------------------------
# Arbol de decision: log(area + 1) ~ RH + temp
# ----------------------------------------------------------------------------
arbol_temp_rh <- rpart(log(area + 1) ~ RH + temp,
                       data = forestfires, method = "anova")
cat("\n--- Arbol de decision: log(area + 1) ~ RH + temp ---\n")
print(summary(arbol_temp_rh))
rpart.plot(arbol_temp_rh, main = "Propagacion segun temperatura y humedad")

# ----------------------------------------------------------------------------
# Analisis: ISI vs Viento
# ----------------------------------------------------------------------------
multi_reg_isi_wind <- lm(ISI ~ wind + FFMC + DMC + DC + RH + temp + area,
                         data = forestfires)
cat("\n--- Regresion Lineal Multiple: ISI ~ variables meteorologicas ---\n")
print(summary(multi_reg_isi_wind))

grafico_isi_wind <- graficar_dispersion_regresion(
    datos = forestfires,
    x_var = "wind",
    y_var = "ISI",
    modelo = multi_reg_isi_wind,
    titulo = "Indice de Propagacion Inicial (ISI) vs Viento",
    etiqueta_x = "Viento",
    etiqueta_y = "ISI (propagacion del fuego)"
)
print(grafico_isi_wind)

# ----------------------------------------------------------------------------
# Maquinas de vectores de soporte (SVM): ISI ~ wind
# ----------------------------------------------------------------------------
svm_radial_isi_wind <- svm(ISI ~ wind, data = forestfires,
                           type = "eps-regression", kernel = "radial")
cat("\n--- SVM (kernel radial): ISI ~ wind ---\n")
print(summary(svm_radial_isi_wind))

svm_sigmoid_isi_wind <- svm(ISI ~ wind, data = forestfires,
                            type = "eps-regression", kernel = "sigmoid")
cat("\n--- SVM (kernel sigmoid): ISI ~ wind ---\n")
print(summary(svm_sigmoid_isi_wind))

# ----------------------------------------------------------------------------
# Random Forest: ISI ~ wind
# ----------------------------------------------------------------------------
rf_isi_wind <- randomForest(ISI ~ wind, data = forestfires, ntree = 500)
cat("\n--- Random Forest: ISI ~ wind ---\n")
print(rf_isi_wind)
plot(rf_isi_wind, main = "Random Forest: ISI ~ wind")

# ----------------------------------------------------------------------------
# Analisis: ISI vs FFMC
# ----------------------------------------------------------------------------
multi_reg_isi_ffmc <- lm(FFMC ~ ISI + DMC + DC + RH + temp + area,
                         data = forestfires)
cat("\n--- Regresion Lineal Multiple: FFMC ~ variables meteorologicas ---\n")
print(summary(multi_reg_isi_ffmc))

grafico_isi_ffmc <- graficar_dispersion_regresion(
    datos = forestfires,
    x_var = "FFMC",
    y_var = "ISI",
    modelo = multi_reg_isi_ffmc,
    titulo = "Indice de Propagacion Inicial (ISI) vs FFMC",
    etiqueta_x = "FFMC (humedad del combustible fino)",
    etiqueta_y = "ISI (indice de propagacion inicial)"
)
print(grafico_isi_ffmc)

# ----------------------------------------------------------------------------
# Maquinas de vectores de soporte (SVM): ISI ~ FFMC
# ----------------------------------------------------------------------------
svm_radial_isi_ffmc <- svm(ISI ~ FFMC, data = forestfires,
                           type = "eps-regression", kernel = "radial")
cat("\n--- SVM (kernel radial): ISI ~ FFMC ---\n")
print(summary(svm_radial_isi_ffmc))

svm_sigmoid_isi_ffmc <- svm(ISI ~ FFMC, data = forestfires,
                            type = "eps-regression", kernel = "sigmoid")
cat("\n--- SVM (kernel sigmoid): ISI ~ FFMC ---\n")
print(summary(svm_sigmoid_isi_ffmc))

# ----------------------------------------------------------------------------
# Random Forest: ISI ~ FFMC
# ----------------------------------------------------------------------------
rf_isi_ffmc <- randomForest(ISI ~ FFMC, data = forestfires, ntree = 500)
cat("\n--- Random Forest: ISI ~ FFMC ---\n")
print(rf_isi_ffmc)
plot(rf_isi_ffmc, main = "Random Forest: ISI ~ FFMC")

# ----------------------------------------------------------------------------
# Arbol de decision: log(area + 1) ~ FFMC + ISI
# ----------------------------------------------------------------------------
arbol_isi_ffmc <- rpart(log(area + 1) ~ FFMC + ISI,
                        data = forestfires, method = "anova")
cat("\n--- Arbol de decision: log(area + 1) ~ FFMC + ISI ---\n")
print(summary(arbol_isi_ffmc))
rpart.plot(arbol_isi_ffmc, main = "Propagacion segun FFMC e ISI")

cat("\n=== Analisis completado ===\n")