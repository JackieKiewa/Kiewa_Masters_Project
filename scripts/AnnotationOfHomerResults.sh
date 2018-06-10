#!/bin/bash
cd /home/jackie/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/AlgorithmResultsAllSequences/1kb/HomerCis

# the following directories and files are needed to store the annotation data supplied by the Homer program

mkdir -p annotation
cd annotation
mkdir -p GOResults
mkdir -p motifPlots

touch motifResults.csv
touch graphData.csv

echo First access the GO data to store information about the closest tss to each eQTL

annotatePeaks.pl '/home/jackie/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/allSequences/1kbCisSequences.bed' hg19 -genomeOntology '/home/jackie/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/AlgorithmResultsAllSequences/1kb/HomerCis/annotation/GOResults' 

echo Next store information about the location of each motif

# rename the formatted file which contains motif number information 

cp /home/jackie/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/AlgorithmResultsAllSequences/FormattedResults/Homer_Formatted  /home/jackie/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/AlgorithmResultsAllSequences/FormattedResults/homerMotifs.all.motifs

annotatePeaks.pl "/home/jackie/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/allSequences/1kbCisSequences.bed" hg19 -m "/home/jackie/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/AlgorithmResultsAllSequences/FormattedResults/homerMotifs.all.motifs" > "/home/jackie/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/AlgorithmResultsAllSequences/1kb/HomerCis/annotation/motifResults.csv" -nmotifs -mdist -noann

echo Next provide data about the average distance of each motif from the eQTL. This data can be used to create plots of average motif distance.

annotatePeaks.pl '/home/jackie/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/allSequences/1kbCisSequences.bed' hg19 -m '/home/jackie/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/AlgorithmResultsAllSequences/FormattedResults/homerMotifs.all.motifs'  > '/home/jackie/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/AlgorithmResultsAllSequences/1kb/HomerCis/annotation/graphData.csv' -hist 100 -noann

#echo Now each motif will be transformed into a plot.
Rscript "/home/jackie/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/AlgorithmResultsAllSequences/1kb/HomerCisUniqueFasta/Annotation/createPlots.R"
