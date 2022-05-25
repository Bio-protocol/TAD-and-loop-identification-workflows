#HiC-Pro, genarate chromosome interacion matrix file
cd ./lib/HiC-Pro/
sh run_HiC-Pro.sh
cd ../..
#Juicer, genarate .hic file, indentify TADs, infer loops
cd ./lib/Juicer
sh ./lib/run_Juicer.sh
cd ../..
#TADLib, indentify TADs
cd ./lib/TADLib/
sh run_TADLib.sh
cd ../..
#Fit-Hi-C, infer loops
cd ./lib/Fit-Hi-C/
sh run_Fit-Hi-C.sh
cd ../..
#FitHiChIP, infer loops
cd ./lib/FitHiChIP
sh run_FitHiChIP.sh
cd ../..
#hichipper
cd ./lib/hichipper
sh run_hichipper.sh
cd ../..
