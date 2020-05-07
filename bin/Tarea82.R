library(phyloseq)
library(vegan)
library(ggplot2)

## Lee los datos
soil <- import_biom ("../data/taxonomycam.biom") ## si lo hago con ìmport_biom, el resto ya no sale :()
soil

PA <- decostand (soil, method="pa", range.global = "range", MARGIN=1)

## Crear una tabla de OTU binomial (presencia/ausencia) usando la función decostand (method="pa") 
## del paquete de vegan

### Extraer los datos de la matriz ### este paso no es necesario.
soil_matrix <- (biom_data(soil))



### Extraer con la función `biom_data` los datos del objeto y convertirlo en matriz
soil_matriz <- as.matrix(biom_data(soil))

### Convertir un archivo (matriz) en p/a
soil_pa <- decostand(soil_matriz, method="pa")           

soil_pa 


## Realizar un plot_bar de la abundancia de OTUs por phylum en cada hospedero (host) y tratamiento (treatment) usando facet_wrap
plot_bar(soil, "Host", fill="Phylum") + 
  geom_bar(aes(color="Phylum", fill="Phylum"), stat="identity", position= "stack") 
p + face_wrap("Treatment") ## Para tener los dos


## Hacer un anova de la riqueza observada ("Observed") por hospedero y tratamiento (two-way)
### Índice de diversidad, colocada en una tabla
diversity <- estimate_richness(soil, measures =c("Observed", "Fisher"))
diversity
anova<- aov(Observed ~ Treatment*Host, data=data)
summary(anova)

boxplot(Fisher ~ Host, data=data)

## Desde una matriz de distancia de Raup-Crick ("raup"), realizar una ordinación NMDS, visualizándole por hospedero y tratamiento usando facet_wrap
## Primero se crea la matriz con las distancias
raup <- distance (soil, method="raup")
raup

NMDS = ordinate(soil, method="NMDS", distance=raup)
NMDS

plot_ordination(soil, NMDS, color="Host") + geom_point(size=3) + 
  facet_wrap(~ Treatment) +
  theme_bw()


## Hacer un test de adonis de la composición de la comunidad por hospedero y tratamiento
## diferencias significativas en hospederos en términos de comunidad

adonis(raup ~Host, data=data)

adonis(raup~Treatment, data=data)

adonis(raup ~Host * Treatment, data=data)

## Sube los resultados a tu repo de gituhub (metagenomica) en un informe de R Markdown que incluye los gráficos.

## Documenta tu análisis en el README, describiendo brevemente los resultados que obtuviste: Viste un efecto significativo de los factores hospedero y tratamiento sobre la diversidad alfa y beta?
  
