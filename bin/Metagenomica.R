## Análisis de datos de illumina desde amptk

## cambia tu wd a donde esta el archivo .biom

## carga paqueterías

library(phyloseq)
library(vegan)
library(ggplot2)

## Importa los datos
soil <- import_biom("../data/taxonomy.biom")

soil

head (tax_table(soil))
sample_data(soil)

## Cambio el nombre de las columnas
colnames (tax_table(soil)) <- c("Domain", "Phylum", "Class", "Order", "Family", "Genus", "Species")

## Transformar y verificar los datos
# Contaminaciones: eliminar los reads del control negativo en cada muestra (dyplr)

# Todas la muestras tienen que tener el mismo número de reads
# Rarefy: una manera de hacer que todas las muestras tengan el mismo número de reads
# why rarefy is inadmissible?
# Mejor usar frecuencias relativas

no.reads = sort(sample_sums(soil))
no.reads

## Diversidad alfa
plot_bar(soil, "Treatment", fill="Phylum") + 
  geom_bar(aes(color=Phylum, fill=Phylum), stat="identity", position= "stack") # position stack indica que ponga un OTU sobre otro


plot_bar(soil, "Host", fill="Phylum") + 
  geom_bar(aes(color=Phylum, fill=Phylum), stat="identity", position= "stack") # position stack indica que ponga un OTU sobre otro



plot_bar(soil, "THost", fill="Family") + 
  geom_bar(aes(color=Family, fill=Family), stat="identity", position= "stack") 
p + face_wrap("Treatment") ## Para tener los dos



### Número de especies por familia en cada muestra

### Abundancia de OTUS de cada familia/ tabla de presencia-ausencia

### vegan: decostand

### Abundancia de OTU no es la abundancia de secuencia

## Índice de diversidad, colocada en una tabla
diversity <- estimate_richness(soil, measures =c("Observed", "Fisher"))
diversity

## Combino las tablas
data <- cbind(sample_data(soil), diversity)
data

## Diferencia entre especies (diversidad alfa); Anova
anova<- aov(Fisher ~ Treatment, data=data)
summary(anova)

anova1<- aov(Fisher ~ Treatment * Host, data=data)
summary(anova1)
boxplot(Fisher ~ Host, data=data)

## Diferencia entre comunidades (beta-diversity).
## Ordenación, cuál es la muestra más parecida entre ellas
# NDMS, basado en una matrix de disimilitud
# Bray-curtis distance

## Primero se crea la matriz con las distancias
bray <- distance (soil, method="bray")
bray

NMDS = ordinate(soil, method="NMDS", distance= bray)
NMDS

plot_ordination(soil, NMDS, color="Host") + geom_point(size=3) + 
  facet_wrap(~ Treatment) +
  theme_bw()

## diferencias significativas en hospederos en términos de comunidad

adonis(bray~Host, data=data)

adonis(bray~Treatment, data=data)

adonis(bray~Host * Treatment, data=data)




