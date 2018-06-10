#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Nov  9 15:07:06 2017

@author: jackie
"""
import sys
import os
import pandas as pd

os.chdir('/home/jackie/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/NullSequences/allSequences/ComparedWithEqtls/StampResults')
#group = sys.argv[1]
group = "null"


namelist = [group + 'Motif',  'Frequency', 'BestHomerProb', 'BestBammProb', 'BestDremeProb']
data = pd.read_table(group + "MotifsSorted.csv", sep=' ', names = ['C1', 'C2', 'C3', 'C4','C5'])
frequencies = pd.read_table(group + "MotifsWithFrequencies.csv", sep=' ', names = namelist)
freq=pd.DataFrame(columns=["tf", "freq", "HomMotifs", "BestHomMatch","BammMotifs", "BestBammMatch", "DremeMotifs", "BestDremeMatch"])
freq["tf"] = frequencies[group + "Motif"]
freq["freq"] = frequencies["Frequency"]
homerFreq =[]
bammFreq=[]
dremeFreq=[]

for i in range(len(frequencies)):
    HomerProbs = [1]
    BammProbs = [1]
    dremeProbs = [1]

    motif = frequencies.loc[i, group + "Motif"]
    
    for j in range(len(data)):
        if data.loc[j, "C1"] == motif: 
            if "Hom" in str(data.loc[j, "C5"]):
                HomerProbs += [data.loc[j, "C2"]]
                
            if "Bamm" in str(data.loc[j, "C5"]):
                BammProbs += [data.loc[j, "C2"]]
                
            elif "Hom" not in str(data.loc[j, "C5"]) and "Bamm" not in str(data.loc[j, "C5"]): 
                dremeProbs += [data.loc[j, "C2"]]
                
        else:
            continue
    
    homerFreq.append(len(HomerProbs)-1)
    bammFreq.append(len(BammProbs)-1)
    dremeFreq.append(len(dremeProbs)-1)
    
    if len(HomerProbs)-1 != 0:
        frequencies.loc[i, "BestHomerProb"] = str(min(HomerProbs))
    else:
        frequencies.loc[i, "BestHomerProb"] = "NoMotifFound"

    if len(BammProbs)-1 != 0:
        frequencies.loc[i, "BestBammProb"] = str(min(BammProbs))
    else:
        frequencies.loc[i, "BestBammProb"] = "NoMotifFound"
        
    if len(dremeProbs)-1 != 0:
        frequencies.loc[i, "BestDremeProb"] = str(min(dremeProbs))
    else:
        frequencies.loc[i, "BestDremeProb"] = "NoMotifFound"    
        
freq["BestHomMatch"]=frequencies["BestHomerProb"]
freq["BestBammMatch"]=frequencies["BestBammProb"]
freq["BestDremeMatch"]=frequencies["BestDremeProb"]
freq["HomMotifs"]=homerFreq
freq["BammMotifs"]=bammFreq
freq["DremeMotifs"]=dremeFreq
freq.to_csv("tfsWithMotifFrequenciesAndMatchProbabilities.csv", sep=" ", index=None)
    
frequencies.to_csv(group+"MotifFrequenciesAndProbabilities.csv", index=None, sep=" ") 


