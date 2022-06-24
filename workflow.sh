#HiC-Pro, genarate chromosome interacion matrix file
#HiC-Pro requires an input file to be downloaded befor running
#cd ./lib/HiC-Pro
#sh run_HiC-Pro.sh
#cd ..

#Juicer indentify TADs, infer loops
cd ./lib/Juicer
sh juicer_findTAD_loop.sh
cd ../..

#TADLib, indentify TADs
cd ./lib/TADLib
sh TADLib_findTAD.sh 
cd ../..

#Fit-Hi-C, infer loops
cd ./lib/Fit-Hi-C
sh FitHiC_findLoop.sh
cd ../..

#FitHiChIP, infer loops
#input/FitHiChIP_input_data/chr21.allValidPairs need to decompression
cd ./lib/FitHiChIP
sh FitHiChIP_findloop.sh
cd ..


#hichipper
#Befor running HiC-Pro you need to download the input file and run HiC-Pro
#cd ./lib/hichipper
#sh run_hichipper.sh
#cd ..
