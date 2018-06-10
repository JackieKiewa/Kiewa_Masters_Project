#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon May  7 11:56:44 2018

@author: jackie
"""

import os
import pandas as pd

os.chdir('/home/jackie/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/AlgorithmResultsAllSequences/StampResults/HomerAndBamm')

allMotifs = pd.read_table("allMotifList", names=["C1"])
data1 = pd.read_table("AmeBammSequences.csv", sep = " ", names=["motif", "sequence", "eValue"])
db = pd.read_table("HomerAndBammMotifsSorted.csv", sep = " ", names=["TF","MatchScore","Seq1","Seq2", "Motif"])
data2 = pd.read_table("dremeMotifSequenceAndEValue.csv", sep=" ", names=["motifID", "sequence", "eValue"])
#allMotifs = []


        
allMotifs = set(allMotifs["C1"])       
motifsWithTFs = set(db["Motif"])
motifsWithoutTFs = list(allMotifs - motifsWithTFs)

db1 = pd.DataFrame(columns = ["Motif", "sequence"])
db1["Motif"] = motifsWithoutTFs

for j in range(len(db1)):
    motif = str(db1.loc[j, "Motif"])
    if "Hom" in motif:
        homSequence = motif.split("_")[4]
        db1.loc[j, "sequence"] = str(homSequence)
    if "bamm" in motif:
        for k in range(len(data1)):
            bammMotif = str(data1.loc[k, "motif"])
            bammSequence = str(data1.loc[k, "sequence"])
            if motif == bammMotif:
                db1.loc[j, "sequence"] = bammSequence
    if "Hom" not in motif and "bamm" not in motif:
        dremeSequence = motif
        db1.loc[j, "sequence"] = dremeSequence
        for i in range(len(data2)):
            if dremeSequence == str(data2.loc[i, "sequence"]):
                db1.loc[j, "Motif"] = str(data2.loc[i, "motifID"])
                
db1.to_csv("unMatchedMotifs.csv", sep=" ", index=None, header=None)                
                       
               