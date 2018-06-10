setwd("~/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/AlgorithmResultsAllSequences/StampResults/HomerAndBamm")
library(RColorBrewer)
library(gplots)

data <- read.csv('TFsAllMotifsWithDreme.csv', sep = ' ', header = TRUE)


finalCol <- ncol(data)
db <- data[ ,3:finalCol]

dbTranspose <-t(db)
db_matrix <- data.matrix(dbTranspose)
lmat = rbind(4:3,2:1)
lwid=c(1.5,4)
lhei=c(1.5,8)
heatmap.2(db_matrix, trace="none", lmat=lmat, lwid=lwid, lhei=lhei, dendrogram="none",Rowv= "NA", col=greenred(10),cexCol=1.2, key.par = list(cex=0.5), margins=c(2, 8))

pdf("allSequences_heatmap1.pdf", height=10, width=10)
heatmap.2(db_matrix, trace="none", dendrogram="none", Rowv= "NA", col=greenred(10),cexCol=1.2, key.par=list(cex=0.5), margins=c(2, 8))
dev.off()


