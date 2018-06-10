setwd("~/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/Overlaps")
library(dplyr)
library(naturalsort)
library(ggplot2)
db <- read.table("1kbSequencesWithOverlaps.csv", sep='', header = TRUE)
# This code creates a frequency table of all overlaps (irrespective of size)
db$overlap[db$overlap>0] <- 1
db$chr <- factor(db$chr)
# the following code creates a table with frequencies of overlap/no overlap by chromosome
db.out <- db %>% # this means that the %>% stands for the data that is being used 
  group_by(chr, overlap) %>%
  tally() %>%
  group_by(chr) %>%
  mutate(percent=n/sum(n))
db.out <- db.out[naturalorder(db.out$chr),]
write.table(db.out, "1kbFrequenciesOfOverlap")

# Need to check this table to make sure it is formatted correctly

db <- read.table("1kbFrequenciesOfOverlap.csv", sep=',', header = TRUE)
db.Overlaps <- filter(db, overlap==1)
db.NoOverlaps <- filter(db, overlap==0)
countPercent <- round(db.Overlaps$count / (db.Overlaps$count + db.NoOverlaps$count) * 100)
chr <- db.Overlaps$chr
countPercents <- data_frame(chr, countPercent)
countPercents$chr <- factor(gsub("chr", "",  countPercents$chr))

countPercents$chr <- factor(countPercents$chr, levels=c(seq(1,22)))
ggplot(countPercents, aes(chr, countPercent)) + geom_col()

# This code creates a histogram of overlaps that are greater than some% of the sequence:
db <- read.table("5kbSequencesWith25PercentOverlaps.csv", sep='', header = TRUE)

db$chr <- factor(db$chr)
# the following code creates a table with frequencies of overlap/no overlap by chromosome
db.SomePercent <- db %>% # this means that the %>% stands for the data that is being used 
  group_by(chr, overlap) %>%
  tally() %>%
  group_by(chr) %>%
  mutate(percent=n/sum(n))
db.SomePercent <- db.SomePercent[naturalorder(db.out$chr),]
write.table(db.SomePercent, "1kbFrequenciesOf_25Percent_Overlap")

# Need to check this table to make sure it is formatted correctly

db <- read.table("1kbFrequenciesOf_25Percent_Overlap", sep=' ', header = TRUE)
db.Overlaps <- filter(db, overlap==1)
db.NoOverlaps <- filter(db, overlap==0)
countPercent <- round(db.Overlaps$count / (db.Overlaps$count + db.NoOverlaps$count) * 100)
chr <- db.Overlaps$chr
countPercents <- data_frame(chr, countPercent)
countPercents$chr <- factor(gsub("chr", "",  countPercents$chr))

countPercents$chr <- factor(countPercents$chr, levels=c(seq(1,22)))
ggplot(countPercents, aes(chr, countPercent)) + geom_col() + labs(y="Percentage with overlapping sequences", x="Chromosome")
