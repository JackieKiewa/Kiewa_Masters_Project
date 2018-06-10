#!/bin/bash
echo This process will extract E-values or probabilities from the Homer and Bamm algorithms.
echo enter the name of the folder containing the original motif pwms that were used to create the formatted files. This might be AME.
read algorithm

seqGroup=HomerAndBamm

filepath="/home/jackie/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/AlgorithmResultsAllSequences/StampResults/HomerAndBamm"
cd $filepath
resultsPath="/home/jackie/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/AlgorithmResults2/StampResults/"
resultsPath+=$seqGroup
cp "/home/jackie/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/AlgorithmResultsAllSequences/FormattedResults/Homer_Formatted"  .

# The following python program creates files of motifs with matching algorithm references (called [seqGroup]Motifs.txt). This will be used to add a target/background ratio and algorithm EValues to the motif.
'/home/jackie/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/AlgorithmResultsAllSequences/StampResults/HomerAndBamm/creatingMotifLists.py' $seqGroup



echo Doing the Bamm motifs:
cp "/home/jackie/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/AlgorithmResultsAllSequences/1kb/AME/BammAllMotifs.csv" .
bammEValues=$seqGroup
bammEValues+="BammEValues.txt"
cat /home/jackie/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/AlgorithmResultsAllSequences/1kb/$algorithm/bamm.txt | grep -e MOTIF -e letter-probability | sed 's\letter-probability matrix: alength= [0-9]* w= [0-9]* nsites= [0-9]* E= \\' | sed 's\MOTIF \BammMotif\' > $bammEValues

echo The Bamm enrichment evalues have been added to the motifs in a file called BammEValues.txt

echo adding these algorithm eValues to the larger file...

# Use the above files to run the python program which will create a dataframe of Homer details and Bamm eValues
'/home/jackie/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/AlgorithmResultsAllSequences/StampResults/HomerAndBamm/addingEValues.py' $seqGroup



echo "Finished!"            


