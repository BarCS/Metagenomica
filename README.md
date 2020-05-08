# Metagenomica
## Repositorio de Unidad8
## Bárbara Cruz Salazar

## Tarea 8.1
### El script se encuentra en el directorio `bin` (Tarea 8.1.sh), en él se describen los codigos para analizar las secuencias obtenidad y obtener el archivo .biom 

### En data está el archivo .biom de 200 y 300 pares de bases de longitud de las secuencias. Asimismo, están las gráficas obtenidas en los análisis de R.

### Se tienen 2 tratamientos (mixto y nativo) y dos hospederos (Juniperus y Quercus). El análisis de mínimo de 200pb de longitud de las secuencias muestra que no hay diferencias significativas en la diversidad alfa entre hospederos y tratamiento. Además, se obtiene un nivel de estres de 0.137. A nivel de diversidad beta, se obtiene una diferencia significativa entre comunidades de diferentes hospederos y con la interacción hospedero-tratamiento.

### En el análisis de un mínimo de 300 pb de longitud de las secuencias, no se encuentra diferencias en la diversidad alfa entre hospederos y tratamientos. El nivel de estres del NMDS se incrementa (0.179) lo que muestra un menor nivel de ajuste del modelo.Igualmente, la diversidad beta, es diferente significativamente entre comunidades de diferentes hospederos y con la interacción hospedero-tratamiento.

### En conclusión, el conjunto de datos con una longitud de 200 pb, muestra un mejor ajuste del modelo. Aunque no se encuentran diferencias significativas en la diversidad alfa, ni entre tratamientos ni hospederos, hay una clara diferencia entre las comunidades de los hospederos. Es posible que el mejor ajuste del modelo con 200 pb, se deba a que con esa longitud las diferencias entre especies disminuyan y sea posible un mejor análisis de diversidad.

## Tarea 8.2
### En el directorio `bin`se encuentra el script de este análsis (Tarea82.md).
### Los resultados se encuentran en la carpeta `data`(Tarea82.html).
### Los resultados muestran que la abundancia de OTUs varía dentro y entre tratamientos. En el tratamiento "nativo" la abundancia de OTUs es similar, mientras que, en el tratamiento "mezclado" la abundancia de OTUs es muy dispar entre hospederos. No obstante, el ANOVA no detectó diferencia significativa entre tratamientos y hospederos en la diversidad alfa. El análisis NDMS indica un nivel de estres en el límite aceptable (0.15) que sugiere un ajuste medio del modelo. Finalmente, la diversidad beta indicó diferencias entre tratamientos y la interacción con el hospedero, pero ninguna diferencia cuando solo se analiza entre hospederos.
