### =========================================================================
### make-metadata.R
### -------------------------------------------------------------------------
###
### Generates inst/extdata/metadata.csv for the AnnotationHub resource.
### SourceType and SourceUrl describe the GFF3 annotation used to construct
### the TxDb. The corresponding FASTA reference URL is retained in the
### description and in make-data.R for reproducibility.
###

# Update this value if the regenerated SQLite file is deposited under a
# new Zenodo record/version.
zenodo_record_id <- "23822386"

meta <- data.frame(
    Title = paste(
        "TxDb.Athaliana.Ensembl.TAIR10",
        "Ensembl Plants release 63"
    ),
    Description = paste(
        "Transcript Annotation Database for Arabidopsis thaliana",
        "based on the TAIR10 reference genome and Ensembl Plants",
        "release 63 GFF3 annotation."
    ),
    BiocVersion = "3.24",
    Genome = "TAIR10",
    SourceType = "GFF",
    SourceVersion = "63",
    SourceUrl = paste0(
        "https://ftp.ensemblgenomes.ebi.ac.uk/pub/plants/release-63/",
        "gff3/arabidopsis_thaliana/",
        "Arabidopsis_thaliana.TAIR10.63.gff3.gz"
    ),
    Species = "Arabidopsis thaliana",
    TaxonomyId = "3702",
    Coordinate_1_based = TRUE,
    DataProvider = "Ensembl Plants",
    Maintainer = "Kabilan S <kabilan151414@gmail.com>",
    RDataClass = "TxDb",
    DispatchClass = "SQLiteFile",
    Location_Prefix = "https://zenodo.org/",
    RDataPath = paste0(
        "records/", zenodo_record_id,
        "/files/TxDb.Athaliana.Ensembl.TAIR10"
    ),
    Tags = paste(
        "AnnotationData:TxDb:Arabidopsis_thaliana:",
        "SequenceAnnotation:AnnotationHub",
        sep = ""
    ),
    stringsAsFactors = FALSE
)

write.csv(
    meta,
    file = "inst/extdata/metadata.csv",
    row.names = FALSE,
    na = ""
)
