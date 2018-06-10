library(dplyr)
library('BSgenome.Hsapiens.UCSC.hg19')

setwd("~/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles")

# load data and extract cojo data
db <- src_sqlite('cage.sqlite', create = FALSE)
eqtl <- as.data.frame(collect(tbl(db, "eqtl_cojo"), n = Inf))

# filter for perfect quality probes 
cojo.db <- dplyr::filter(eqtl, PROBE_QUALITY != "Bad" & PROBE_QUALITY != "NA")

# to use the "getSeq" function the chromosome needs to be of the form "chr__"
cojo.db$CHR <- paste("chr", cojo.db$CHR, sep = "")

# write to file:
write.table(cojo.db, "cojo_db_table")



# extract sequences for each SNP
Chr <- vector()
Snp <- vector()
BP <- vector()
for (i in 1:nrow(cojo.db)){
  if (cojo.db[i, 3] > 100000) {
    Chr <- c(Chr, cojo.db[i, 1])
    Snp <- c(Snp, cojo.db[i, 2])
    BP <- c(BP, cojo.db[i, 3])
    sequence <- getSeq(Hsapiens, cojo.db$CHR, cojo.db$BP - 100000, cojo.db$BP + 100000)
  }
}


sequence <- getSeq(Hsapiens, cojo.db$CHR, cojo.db$BP - 100000, cojo.db$BP + 100000)

# turn each DNAStringSet into a string
SEQUENCE <- sapply(sequence, function(x) toString(x))

# attach the sequence vector to the cojo dataframe as a final column
sequence.set <- cbind(cojo.db, SEQUENCE)

# write to file
write.table(sequence.set, "cojo_db_50kb_sequences")
