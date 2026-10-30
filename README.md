# TxDb.Athaliana.Ensembl.TAIR10

**TxDb.Athaliana.Ensembl.TAIR10** provides transcript, exon, CDS, and gene
annotations for *Arabidopsis thaliana* based on the TAIR10 reference genome
and Ensembl Plants release 63 GFF3 annotation. It includes nuclear and
organellar sequence information and can be queried with
[GenomicFeatures](https://bioconductor.org/packages/GenomicFeatures).

## Installation

Install the package from Bioconductor:

```r
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}
BiocManager::install("TxDb.Athaliana.Ensembl.TAIR10")
```

The development version can be installed from GitHub:

```r
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}
BiocManager::install("kabilanbio/TxDb.Athaliana.Ensembl.TAIR10")
```

## Usage

The TxDb SQLite resource is hosted through AnnotationHub and is retrieved
when the package is used.

```r
library(TxDb.Athaliana.Ensembl.TAIR10)
library(GenomicFeatures)

txdb <- TxDb.Athaliana.Ensembl.TAIR10

seqinfo(txdb)
genes(txdb)
head(transcripts(txdb))
exonsBy(txdb, by = "tx")
cdsBy(txdb, by = "tx")
```

Alternatively, retrieve the resource directly through AnnotationHub:

```r
library(AnnotationHub)

ah <- AnnotationHub()
query(ah, "TxDb.Athaliana.Ensembl.TAIR10")
```

## Data source

The annotation was obtained from Ensembl Plants release 63 for the TAIR10
assembly. The GFF3 annotation and reference FASTA used to build the database
are both identified in `inst/scripts/make-data.R`. The FASTA is used to
derive sequence lengths and circularity information.

## Documentation

See the package vignette:

```r
vignette(
    "TxDb.Athaliana.Ensembl.TAIR10",
    package = "TxDb.Athaliana.Ensembl.TAIR10"
)
```
