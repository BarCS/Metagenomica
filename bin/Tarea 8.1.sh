## Entrar al cluster
ssh -p 45789 cirio@200.12.166.164
6MsG9ze8auB4BZRwmPQie

## Crear carpetas
mkdir bcruzs
cd bcruzs

mkdir bin
mkdir data
cd bin

## 1. Preprocesamiento de los archivos. Aquí se ensamblan las lecturas (forward y reverse) y se eliminan los primers y las secuencias muy cortas; Aquí se está determinando una longitud minima de 200 pb
amptk illumina -i ../../metagenomica/fastq -o amptk -f GTGARTCATCRARTYTTTG -r CCTSCSCTTANTDATATGC -l 300 --min_len 200 --full_length --cleanup

-i, indica el archivo FASTQ de entrada

-o, indicas en nombre del output

-f, secuencia forward del primer (here: gITS7ngs)

-r, secuencia reverse del primer (here: ITS4ngsUni)

-l, longitud de las lecturas (here: 200 bp)

--min_len, indicas el mínimo de longitud para conservar una secuencia

--full_length, sirve para indicar que conserver solamente las secuencias con longitud completa

--cleanup, elimina archivos intermedios


## 2. Filtro de calidad. Se limpian las secuencias de secuencias quimericas y se agrupan en OTUs
amptk cluster -i amptk.demux.fq.gz -o cluster -m 2 --uchime_ref ITS

-i, input con secuencias pareadas, esto se obtuvo del paso anterior

-o, nombre del output

-m, número mínimo de lecturas para OTUs válidos para que seán conservadas (filtra singletons)

--uchime_ref, filtra quimeras (ITS, LSU, COI, 16S, custom path)


## 3. 3. Filtrar index bleed: reads asignados a muestras incorrectas en la secuenciación
amptk filter -i cluster.otu_table.txt -o filter -f cluster.cluster.otus.fa -p 0.005 --min_reads_otu 2

-i, archivo input de OTUs. Tabla obtenida en el paso anterior

-o, nombre del output

-f, archivo fasta con secuencias de referencias para cada OTU. Esto también se obtuvo en el paso anterior

-p, porcentaje de % index bleed entre muestras (if not calculated). El número convencional es 0.005

--min_reads_otu, mínimo de númros de lecturas par que un OTU sea considerado válido y retenido (singleton filter)

## 4. Asigar la taxonomía para cada otu mediante amptk. Aquí utilizamos la base de datos de secuencias de [UNITE] (https://unite.ut.ee/) para asignar la taxonomía de los OTUs. Dado que es una base de datos curada, en general da resultados mucho mejores que GenBank (por ejemplo usando QIMME).
amptk taxonomy -i filter.final.txt -o taxonomy -f filter.filtered.otus.fa -m ../../metagenomica/amptk.mapping_file.txt -d ITS2 --tax_filter Fungi

-i, tabla de OTUS de input OTU. Esto se generó con el paso anterior.

-o, nombre del output

-f, archivo fasta con las referencias de las secuencias de cada OTU

-m, archivo mapping con meta datos asociados a las muestras

-d, datos preinstalados [ITS1, ITS2, ITS, 16S LSU, COI]

--tax_filter, indica eliminar los OTUs que no coinciden con el filtro, i.e. Fungi to keep only fungi
