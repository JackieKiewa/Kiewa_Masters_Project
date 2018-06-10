#!/bin/bash


answer="yes"

 
while [ $answer == "yes" ]
do

   echo Enter the name of the folder that contains the Homer or Bamm or Dreme textfile you wish to format without the full filepath
   read algorithm
   echo And is it a Homer or a Bamm or a Dreme textfile that will be formatted?
   read textfile
   filepath="/home/jackie/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/AlgorithmResultsAllSequences/1kb/"
   filepath+=$algorithm
   cd $filepath
   
   Homer="homerSubstring"
   Bamm="bammSubstring"
   echo $algorithm | grep -c Bamm 
   
   echo $? 
  
   
   if echo $textfile | grep -q "Homer";
   	then	
		sourceFile="homerMotifs.all.motifs"
		echo "Formatting the Homer file"
		shortAlgorithm="Homer"
		cp $sourceFile "homer.txt"
		filename="homer.txt"
		sed -i.bak 's/>/finish\n&/g' $filename

   if echo $textfile | grep -q "Dreme";
        then
                filename="dremeMotifFiles"
		echo "Formatting the Dreme file"
		shortAlgorithm="dreme"
		cp $filename "dreme.txt"
		
		
   
   if echo $textfile | grep -q "Bamm";
        then
		filename="BammMotifFiles"
		echo "Formatting the Bamm file"
		shortAlgorithm="Bamm"
		cp $filename "bamm.txt"
		
   fi
   
   
   cd "/home/jackie/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/AlgorithmResultsAllSequences"
   
   cp 1kb/$algorithm/$filename fileForFormatting
   

   echo "Opening python formatting file..."

   

   '/home/jackie/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/AlgorithmResultsAllSequences/FormattingAlgorithmResultsWithCulledHomer.py' $shortAlgorithm

   echo Do you wish to run another algorithm? Enter yes or no. Use small caps.

   read answer

done
echo "Exiting"




