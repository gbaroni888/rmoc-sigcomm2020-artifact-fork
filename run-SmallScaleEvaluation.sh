#!/bin/bash

echo 
echo "----- Small-Scale Evaluation -----"
echo 

echo "(1) Generate Networks Datasets from Rocketfuel Topologies."
#python3 Scripts/NetworkDataSets.py
python3 Scripts/GenerateRandomDataSet.py

mkdir -p OutputDataSets/Rocketfuel/AS3967/HopsLength/ProductOrderHopsLengths
mkdir -p OutputDataSets/Rocketfuel/AS3967/WidthHops/ProductOrderWidthHops
mkdir -p OutputDataSets/Rocketfuel/AS3967/WidthLength/ProductOrderWidthLengths
mkdir -p OutputDataSets/Rocketfuel/AS3967/WidthHopsLength/ProductOrderWidthHopsLengths

mkdir -p OutputDataSets/Rocketfuel/AS3967/WidthLength/WidestShortestOrder
mkdir -p OutputDataSets/Rocketfuel/AS3967/WidthLength/ShortestWidestOrder

echo "(2) Execute Simulation of Dominant-Paths Vectoring Protocols."
echo

echo -e "\t+ Compiling and Linking Programs"
make -C Simulator clean all > /dev/null 

./Simulator/Executables/SimulateNonRestartingProtocol -n Rocketfuel/AS3967/HopsLength      	-o ProductOrderHopsLengths      -r 3
./Simulator/Executables/SimulateNonRestartingProtocol -n Rocketfuel/AS3967/WidthHops       	-o ProductOrderWidthHops        -r 3
./Simulator/Executables/SimulateNonRestartingProtocol -n Rocketfuel/AS3967/WidthLength     	-o ProductOrderWidthLengths     -r 3
./Simulator/Executables/SimulateNonRestartingProtocol -n Rocketfuel/AS3967/WidthHopsLength 	-o ProductOrderWidthHopsLengths -r 3
./Simulator/Executables/SimulateNonRestartingProtocol -n Rocketfuel/AS3967/WidthLength 	   	-o ShortestWidestOrder          -r 3
./Simulator/Executables/SimulateNonRestartingProtocol -n Rocketfuel/AS3967/WidthLength     	-o WidestShortestOrder          -r 3

./Simulator/Executables/SimulateRestartingProtocol 	  -n Rocketfuel/AS3967/HopsLength       -o ProductOrderHopsLengths      -r 3
./Simulator/Executables/SimulateRestartingProtocol 	  -n Rocketfuel/AS3967/WidthHops        -o ProductOrderWidthHops        -r 3
./Simulator/Executables/SimulateRestartingProtocol 	  -n Rocketfuel/AS3967/WidthLength      -o ProductOrderWidthLengths     -r 3
./Simulator/Executables/SimulateRestartingProtocol 	  -n Rocketfuel/AS3967/WidthHopsLength  -o ProductOrderWidthHopsLengths -r 3 

echo 
echo "(3) Produce Plots with CCDFs of Number of Dominant Attributes and Termination Times."

python3 Scripts/PlotNumberDominantAttributes.py
python3 Scripts/PlotTerminationTimes.py

echo "-----"
echo