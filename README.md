# TxDb.Athaliana.Ensembl.TAIR10

**TxDb.Athaliana.Ensembl.TAIR10** provides transcript, exon, CDS, and gene
annotations for *Arabidopsis thaliana* based on the TAIR10 reference genome
and Ensembl Plants release 63 GFF3 annotation. The resource is available
through Bioconductor's AnnotationHub.

## Installation

Install the package from Bioconductor:

```r
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}
BiocManager::install("TxDb.Athaliana.Ensembl.TAIR10")
```

To install the development version from GitHub:

```r
if (!requireNamespace("remotes", quietly = TRUE)) {
    install.packages("remotes")
}
remotes::install_github("kabilanbio/TxDb.Athaliana.Ensembl.TAIR10")
```

## Usage

Retrieve the TxDb resource from AnnotationHub:

```r
library(AnnotationHub)
library(GenomicFeatures)

ah <- AnnotationHub()
query(ah, "TxDb.Athaliana.Ensembl.TAIR10")

# AnnotationHub identifier for this resource
txdb <- ah[["AH122287"]]

seqinfo(txdb)
genes(txdb)
head(transcripts(txdb))
exonsBy(txdb, by = "tx")
cdsBy(txdb, by = "tx")
```

## Data source and reproducibility

The annotation is based on the TAIR10 assembly and Ensembl Plants release 63.
The GFF3 annotation and corresponding reference FASTA URLs are recorded in
`inst/scripts/make-data.R`. The FASTA is used to provide sequence lengths
and circularity information when constructing the TxDb.

## Documentation

See the package vignette:

```r
vignette(
    "TxDb.Athaliana.Ensembl.TAIR10",
    package = "TxDb.Athaliana.Ensembl.TAIR10"
)
```
