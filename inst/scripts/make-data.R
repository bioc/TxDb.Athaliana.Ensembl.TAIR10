### =========================================================================
### make-data.R
### -------------------------------------------------------------------------
###
### Reproducibly builds the TxDb SQLite database distributed through
### AnnotationHub from the Ensembl Plants release 63 GFF3 annotation and
### the corresponding TAIR10 reference FASTA.
###
### Both source files are versioned, documented, and downloaded from the
### Ensembl Plants release 63 FTP archive. Run this script manually from
### the package root (it is not run during package build/check).
###

suppressPackageStartupMessages({
    library(Biostrings)
    library(GenomicFeatures)
    library(GenomeInfoDb)
    library(txdbmaker)
})

# ----------------------------------------------------------------------
# 1. Source files and provenance
# ----------------------------------------------------------------------

gff_url <- paste0(
    "https://ftp.ensemblgenomes.ebi.ac.uk/pub/plants/release-63/",
    "gff3/arabidopsis_thaliana/",
    "Arabidopsis_thaliana.TAIR10.63.gff3.gz"
)

fasta_url <- paste0(
    "https://ftp.ensemblgenomes.ebi.ac.uk/pub/plants/release-63/",
    "fasta/arabidopsis_thaliana/dna/",
    "Arabidopsis_thaliana.TAIR10.dna.toplevel.fa.gz"
)

gff_file <- basename(gff_url)
fasta_file <- basename(fasta_url)
output_sqlite <- "TxDb.Athaliana.Ensembl.TAIR10.sqlite"

organism_name <- "Arabidopsis thaliana"
taxonomy_id <- 3702L
genome_assembly <- "TAIR10"

# Download the exact inputs used to build this TxDb.
if (!file.exists(gff_file)) {
    download.file(gff_url, destfile = gff_file, mode = "wb")
}
if (!file.exists(fasta_file)) {
    download.file(fasta_url, destfile = fasta_file, mode = "wb")
}

stopifnot(file.exists(gff_file), file.exists(fasta_file))

# ----------------------------------------------------------------------
# 2. Derive sequence lengths from the reference FASTA
# ----------------------------------------------------------------------

genome_fasta <- readDNAStringSet(fasta_file)

if (is.null(names(genome_fasta)) || anyDuplicated(names(genome_fasta))) {
    stop("FASTA sequence names must be present and unique.")
}

# Use every sequence in the supplied toplevel FASTA. Do not replace this
# table with a manually restricted chromosome list: doing so would discard
# unplaced/unlocalized sequences present in the reference FASTA.
chrominfo <- data.frame(
    chrom = names(genome_fasta),
    length = as.numeric(width(genome_fasta)),
    is_circular = names(genome_fasta) %in% c("Mt", "Pt"),
    stringsAsFactors = FALSE
)

# Confirm that the expected TAIR10 chromosomes and organellar sequences
# are present before constructing the database.
expected_sequences <- c("1", "2", "3", "4", "5", "Mt", "Pt")
missing_sequences <- setdiff(expected_sequences, chrominfo$chrom)
if (length(missing_sequences)) {
    stop(
        "The reference FASTA is missing expected TAIR10 sequences: ",
        paste(missing_sequences, collapse = ", ")
    )
}

# ----------------------------------------------------------------------
# 3. Build TxDb from the Ensembl Plants GFF3 annotation
# ----------------------------------------------------------------------

txdb <- makeTxDbFromGFF(
    file = gff_file,
    format = "gff3",
    dataSource = "Ensembl Plants release 63",
    organism = organism_name,
    taxonomyId = taxonomy_id,
    chrominfo = chrominfo
)

# Set the genome assembly on all sequences in the TxDb.
GenomeInfoDb::genome(GenomeInfoDb::seqinfo(txdb)) <- genome_assembly

# Validate the key sequence metadata before writing the SQLite file.
si <- GenomeInfoDb::seqinfo(txdb)
if (!all(GenomeInfoDb::genome(si) == genome_assembly)) {
    stop("Genome assembly label was not assigned correctly to every sequence.")
}
if (!all(expected_sequences %in% GenomeInfoDb::seqlevels(si))) {
    stop("One or more expected TAIR10 sequences are absent from the TxDb.")
}
if (!all(GenomeInfoDb::isCircular(si)[match(c("Mt", "Pt"),
                                           GenomeInfoDb::seqlevels(si))])) {
    stop("Mt and Pt must be marked as circular.")
}

# ----------------------------------------------------------------------
# 4. Save and report
# ----------------------------------------------------------------------

saveDb(txdb, output_sqlite)

message("TxDb saved to: ", normalizePath(output_sqlite))
message("Number of TxDb sequences: ", length(GenomeInfoDb::seqlevels(si)))
message("Number of transcripts: ", length(transcripts(txdb)))
message("Number of exons: ", length(exons(txdb)))
message("Number of genes: ", length(genes(txdb)))

# Optional final check after reloading the SQLite database:
txdb_check <- loadDb(output_sqlite)
print(GenomeInfoDb::seqinfo(txdb_check))
stopifnot(all(GenomeInfoDb::genome(GenomeInfoDb::seqinfo(txdb_check)) ==
              genome_assembly))
