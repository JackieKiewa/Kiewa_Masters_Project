# this graph is of the eQTL motif files looking at the eqtl sequences TF motifs only.


setwd("/home/jackie/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/AlgorithmResultsAllSequences")
# Start with Homer data
db <- read.table('1kb/HomerCis/annotation/graphDataNineTFs.csv', sep = '\t', header = TRUE)
values <- db$Distance.from.Center[2:20]
width=dim(db)[2]
# Create a list of column numbers to be used to subset the dataframe for each motif plot (values plus every third column)
width=width-6
numbers <- 0:width
i <- 2
list <- c(numbers[2:(i+2)==(i+2)])

# initialise dataframe
motif <- data.frame(values)
k=1
for (i in list){
  motif[ ,k] <- db[2:20,i]
  k=k+1
}

# Next the Bamm data (which is in separate files)

# import the list of numbers to be used to identify the histogram for each motif plot 
bammNumbers <- c('1', '3', '7', '13', '15')

for (i in bammNumbers){
  db1 <- read.table(paste('1kb/BammCis/Annotations/motifPlots/histogram',i,sep=""), sep = '\t', header = TRUE)
  distance <- db1[2:20, 2]
  motif[ ,k] <- distance
  k=k+1
}


# Next the Dreme data - which is in different files. Once again the data is added to the main file (motif)

# Create a list of numbers to be used to identify the histogram for each motif plot 

dremeNumbers <- c('26', '19')
for (i in dremeNumbers){
  db2 <- read.table(paste('1kb/dreme/Annotations/motifPlots/histogram',i,sep=""), sep = '\t', header = TRUE)
  distance <- db2[2:20, 2]
  motif[ ,k] <- distance
  k=k+1
}
# the motif dataframe now has many columns, one for each motif sequence with the frequencies of the sequence distance from the centre.
# find the mean distances for each bin
meanData <- apply(motif, 1, mean)
meanPlot <- data.frame(values, meanData)

# this next graph is of the eQTL motif files again, looking at the null sequences.
# the idea is to check whether eqtls might be impacting strongly on the motifs by being close in distance to them.

setwd("/home/jackie/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/AlgorithmResultsAllSequences")
# Start with Homer data
db4 <- read.table('1kb/HomerCis/annotation/graphDataNineTFsNullSequences.csv', sep = '\t', header = TRUE)
values <- db4$Distance.from.Center[2:20]
width=dim(db4)[2]
# Create a list of column numbers to be used to subset the dataframe for each motif plot (values plus every third column)
width=width-6
numbers <- 0:width
i <- 2
list <- c(numbers[2:(i+2)==(i+2)])

# initialise dataframe
motif2 <- data.frame(values)
k=1
for (i in list){
  motif2[ ,k] <- db4[2:20,i]
  k=k+1
}

# Next the Bamm data (which is in separate files)

# import the list of numbers to be used to identify the histogram for each motif plot 
bammNumbers <- c('1', '3', '7', '13', '15')


for (i in bammNumbers){
  db5 <- read.table(paste('1kb/BammCis/Annotations/motifPlotsNullSequences/histogram',i,sep=""), sep = '\t', header = TRUE)
  distance <- db5[2:20, 2]
  motif2[ ,k] <- distance
  k=k+1
}


# Next the Dreme data - which is in different files. Once again the data is added to the main file (motif)

# Create a list of numbers to be used to identify the histogram for each motif plot 

dremeNumbers <- c('26', '19')
for (i in dremeNumbers){
  db6 <- read.table(paste('1kb/dreme/Annotations/motifPlotsNullSequences/histogram',i,sep=""), sep = '\t', header = TRUE)
  distance <- db6[2:20, 2]
  motif2[ ,k] <- distance
  k=k+1
}
# the motif1 dataframe now has many columns, one for each motif sequence with the frequencies of the sequence distance from the centre.
# find the mean distances for each bin
meanData2 <- apply(motif2, 1, mean)
meanPlot2 <- data.frame(values, meanData2)

plot(values, meanData, ylim=range(c(meanData, meanData2)), col="green", type="l", lwd=2.5,xlab="Distance from centre", ylab="Sequence frequency")
par(new=TRUE)
plot(values, meanData2, ylim=range(c(meanData, meanData2)), col="coral1", type="l", lwd=2.5, axes=FALSE, xlab="Distance from centre", ylab="Sequence frequency")
legend(300,0.0021, c("eQTL seqs", "null seqs"), lty=c(1,1), lwd=c(2.5,2.5), col=c("green", "coral1"))





