#!/bin/bash
echo This script will create a list of eQTL motifs associated with transcription factors and provides the relative enrichment value of each motif
echo It will also create a list, called unMatchedMotifs.csv of motifs that have no matching transcription factor. 
echo What is the name of the Bamm folder used with this analysis?
read bammFile


echo Gathering the relevant files...
seqGroup="HomerAndBamm"
cd "/home/jackie/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/AlgorithmResultsAllSequences/StampResults/HomerAndBamm"
SourceFile="/home/jackie/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/AlgorithmResultsAllSequences/1kb/$bammFile/1kbCisEQTLSequences_Pvals.txt"
cp $SourceFile "1kbSequences_Pvals.txt"
#This program extracts the sequences for each numbered Bamm motif and saves them into a file:
'/home/jackie/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/AlgorithmResultsAllSequences/StampResults/HomerAndBamm/ExtractingMotifSequence.py'
# This file needs to be formatted to remove extra spaces etc
# create simple name:
eqtlFile="eQTL_1kb_BammOriginalMotifs.txt"
sed -i.bak 's/ //g' $eqtlFile
sed -i.bak $'s/\t/ /g' $eqtlFile
sed -i.bak 's/:/ /g' $eqtlFile
sed -i.bak 's/Motif/BammMotif/g' $eqtlFile
cut -d ' ' -f1,2,4 $eqtlFile > "BammEQTLMotifSequences.csv" 
# Now modify the "motifsSorted" file 
motifsSorted=$seqGroup
motifsSorted+="MotifsSorted.csv"
modifiedFile=$seqGroup
modifiedFile+="MotifsWithSequences.csv"

cut -d ' ' -f1,2,5 $motifsSorted > $modifiedFile

echo "Now adding the sequences and enrichment values..."
# The following program adds the simple motif sequence and probability or eValue to each line 
"/home/jackie/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/AlgorithmResultsAllSequences/StampResults/HomerAndBamm/addingEValuesToAllSequences.py"
echo "Now isolating the unmatched motifs..."
# The following program returns the motifs which have no matched transcription factor
"/home/jackie/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/AlgorithmResultsAllSequences/StampResults/HomerAndBamm/motifsWithoutTFs.py"
