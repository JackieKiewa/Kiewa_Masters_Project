#!/usr/bin/env Rscript
library(dplyr)
# args = commandArgs(trailingOnly=TRUE)
args = "HomerAndBamm"
setwd("~/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/AlgorithmResultsAllSequences/StampResults/HomerAndBamm")

db <- read.table(paste(args, '_formatted_match_pairs.csv', sep=''), fill=TRUE)
db <- db[-grep(">", db$V1), ]
# read in dreme sequences
dreme <- read.table("dremeMotifSequenceAndEValue.csv", sep=" ", header=FALSE)
dremeSequences <- dreme$V2
dremeRep <- rep(dremeSequences, each=5)
dremeRep <- as.vector(dremeRep)
# read in Bamm sequences
db1 <- read.table("AmeBammSequences.csv", sep=" ", header = FALSE)
BammSequences <- db1$V1
BammRep <- rep(BammSequences, each=5)
BammRep <- as.vector(BammRep)
# this table has the full Homer sequences, not the truncated ones:
db2 <- read.table("Homer_Formatted", sep="\t", header = FALSE, fill=TRUE)
db2 <- db2[grep(">", db2$V1), ]
motif <- db2$V1
#format the text to agree with the match_pairs text
motif <- gsub(">_", "", motif)
motif <- gsub(">", "", motif)
motifRep <- rep(motif, each=5)
motifRep <- as.vector(motifRep)
# join the column of homer and bamm and dreme information:
motifColumn <- c(motifRep, BammRep, dremeRep)
db$V5 = motifColumn
# sort the motifs alphabetically
db <- db[order(db$V1), ]
# remove any rows with match values < 0.00003
db$V2 <- as.numeric(as.character(db$V2)) # the column is a factor and needs to become numeric - has to become a character first
db <- filter(db, db$V2<0.00005)
# save this sorted table
write.table(db, paste(args, "MotifsSorted.csv", sep=""), quote=FALSE, sep=" ", row.names=FALSE, col.names=FALSE)

# Extract the first two columns to find motifs with highest frequency
db <- db[, c(1,2)]
# use the table command to find the frequency, and then sort them from highest to lowest
frequencies<-as.data.frame(table(db$V1))
frequencies <- frequencies[order(-frequencies$Freq), ]
frequencies <- filter(frequencies, frequencies$Freq > 0)
write.table(frequencies, paste(args, "MotifsWithFrequencies.csv", sep=""), quote=FALSE, sep=" ", row.names=FALSE, col.names=FALSE)

# save the complete list of motifs
BammSequences <- as.vector(BammSequences)
HomerSequences <- as.vector(motif)
dremeSequences <- as.vector(dremeSequences)
allMotifs <- c(HomerSequences, BammSequences, dremeSequences)
#save this list of motifs
write.table(allMotifs, "allMotifList", quote=FALSE, sep=" ", row.names=FALSE, col.names=FALSE)

