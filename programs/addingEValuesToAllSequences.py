#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Mar 14 11:44:22 2018

@author: jackie
"""
import os
import sys
import pandas as pd
os.chdir('/home/jackie/Documents/BIOC7002ResearchProject/Data/ResearchProjectRFiles/AlgorithmResultsAllSequences/StampResults/HomerAndBamm')
#group = sys.argv[1]
group = "HomerAndBamm"

data = pd.read_table(group + "MotifsSorted.csv", sep=" ", names=["TF", "Match", "Seq1", "Seq2", "MotifID"])
db = pd.DataFrame(columns=["TF", "Match", "MotifId", "Sequence", "EValue"])

# the following table contains the enrichment probabilities for Homer Sequences
HomerProbs = pd.read_table("ameHomerSequence.csv", sep=" ", names=["id", "Sequence", "EValue"])
db["TF"] = data["TF"]
db["Match"] = data["Match"]
db["MotifId"] = data["MotifID"]
# create a for loop to add the Homer sequences and EValues to db
for i in range(len(db)):
    motif = str(db.loc[i, "MotifId"])
    if "Hom" in motif:
        motif = motif.split("_")[4]
        db.loc[i, "Sequence"] = motif
        for j in range(len(HomerProbs)):
            evalue = str(HomerProbs.loc[j, "EValue"])
            sequence = str(HomerProbs.loc[j, "Sequence"])
            if sequence == motif:
                db.loc[i, "EValue"] = evalue
            

            
# The following tables contain the sequences and enrichment values for the Bamm motifs 
AmeEValues = pd.read_table("AmeBammSequences.csv", sep=" ", names = ["Motif", "Sequence", "EValue"])
# Create a for loop to add the sequences and EValue to db
for i in range(len(db)):
    motif = str(db.loc[i, "MotifId"])
    for j in range(len(AmeEValues)):
        sequence = str(AmeEValues.loc[j, "Sequence"])
        eValue = float(AmeEValues.loc[j, "EValue"])
        if str(AmeEValues.loc[j, "Motif"]) == motif:
            db.loc[i, "Sequence"] = sequence
            db.loc[i, "EValue"] = eValue

# the following table contains the sequences and enrichment values for the Dreme motifs
dremeSeq = pd.read_table("dremeMotifSequenceAndEValue.csv", sep=" ", names=["motif", "seq", "eValue"])                    
for i in range(len(db)):
    motif = str(db.loc[i, "MotifId"])
    for j in range(len(dremeSeq)):
        sequence = str(dremeSeq.loc[j, "seq"])
        if motif == sequence:
            db.loc[i, "MotifId"] = str(dremeSeq.loc[j, "motif"])
            db.loc[i, "Sequence"] = motif
            db.loc[i, "EValue"] = str(dremeSeq.loc[j, "eValue"])
                    

            
db.to_csv("eQTLMotifsWithSequencesAndAllEValues.csv", index=False, sep=" ", header=0)

