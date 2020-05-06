library(phyloseq)
library(vegan)
library(ggplot2)

## Importa los datos
soil <- import_biom ("../data/taxonomy.biom")

## Crear una tabla de OTU binomial (presencia/ausencia) usando la función decostand (method="pa") 
## del paquete de vegan

data <- as.matrix(soil)

soil_pa <- decostand(data, method="pa")

## o no sé si así:
soil_pa <- decostand ("../data/taxonomy.biom", method="pa") 

soil_pa



## Realizar un plot_bar de la abundancia de OTUs por phylum en cada hospedero (host) y tratamiento (treatment) usando facet_wrap

## Hacer un anova de la riqueza observada ("Observed") por hospedero y tratamiento (two-way)

## Desde una matriz de distancia de Raup-Crick ("raup"), realizar una ordinación NMDS, visualizándole por hospedero y tratamiento usando facet_wrap

## Hacer un test de adonis de la composición de la comunidad por hospedero y tratamiento

## Sube los resultados a tu repo de gituhub (metagenomica) en un informe de R Markdown que incluye los gráficos.

## Documenta tu análisis en el README, describiendo brevemente los resultados que obtuviste: Viste un efecto significativo de los factores hospedero y tratamiento sobre la diversidad alfa y beta?
  
