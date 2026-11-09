# NEWS for TxDb.Athaliana.Ensembl.TAIR10 Package

## Version 0.99.0 (2026-08-15)

### Initial Release

- First release of the package.
- The TxDb object provides transcript, exon, and CDS annotations
  for *Arabidopsis thaliana* based on the TAIR10 reference genome.
- The annotation was generated from the Ensembl Plants GFF3 annotation
  (release 63).
- Included annotation for the five nuclear chromosomes and the
  mitochondrial and plastid sequences.
- The TxDb resource was generated using the GenomicFeatures/txdbmaker
  infrastructure from the Ensembl Plants GFF3 annotation.

## Version 0.99.1 (2026-08-15)

- Fixed the bugs.

## Version 0.99.2 (2026-08-15)

- Fixed the bugs.

## Version 0.99.3 (2026-08-15)

- Corrected the `inst/scripts/make-data.R`

## Version 0.99.4 (2026-08-15)

- Fixed the bugs.

## Version 0.99.5 (2026-08-15)

- Fixed the WARNINGS.

## Version 0.99.6 (2026-11-09)

- Fixed RDataPath in metadata.csv to include .sqlite extension.
- Cleaned .gitignore for RStudio project compatibility.
