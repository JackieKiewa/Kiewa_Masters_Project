#!/bin/bash

cd /home/jackie/stamp

algorithm=HomerAndBamm

inputFile=HomerAndBamm_Formatted
outFile=$algorithm

stamp -tf $inputFile -sd ScoreDists/JaspRand_PCC_SWU.scores -cc PCC -align SWU -ma IR -printpairwise -match jaspar.motifs -out $outFile

echo "Completed the Stamp algorithm - now processing the files..."
filePath="/home/jackie/stamp/"
filePath+=$algorithm

firstFile=$filePath
firstFile+=.tree
secondFile=$filePath
secondFile+=FBP.txt
thirdFile=$filePath
thirdFile+=_matched.transfac

fileForFormatting=$filePath
fileForFormatting+=_match_pairs.txt

resultsPath="/home/jackie/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/AlgorithmResultsAllSequences/StampResults/"
resultsPath+=$algorithm


cd $resultsPath

mv $firstFile .
mv $secondFile .
mv $thirdFile .
mv $fileForFormatting .
cp "/home/jackie/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/AlgorithmResultsAllSequences/FormattedResults/Homer_Formatted" .


'/home/jackie/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/AlgorithmResultsAllSequences/StampResults/HomerAndBamm/FormattingStampResults.py' $algorithm
Rscript '/home/jackie/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/AlgorithmResultsAllSequences/StampResults/HomerAndBamm/ExtractAllMotifs.R' $algorithm
#'/home/jackie/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/AlgorithmResultsAllSequences/StampResults/HomerAndBamm/includingProbabilities.py' $algorithm
'/home/jackie/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/AlgorithmResultsAllSequences/StampResults/HomerAndBamm/includingProbabilitiesAndMotifFrequenciesWithDreme.py'

