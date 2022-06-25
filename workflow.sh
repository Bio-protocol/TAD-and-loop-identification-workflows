#HiC-Pro, generates chromosome interaction matrix file
#HiC-Pro requires an input file to be downloaded before running, the detail can be find in ./lib/HiC-Pro/run_HiC-Pro.sh 
#cd ./lib/HiC-Pro
#sh run_HiC-Pro.sh
#cd ../..

#Juicer identifies TADs, infers loops
#input/juicer_input_data/chr1.hic.gz need decompression
cd ./lib/Juicer
sh juicer_findTAD_loop.sh
cd ../..

#TADLib, identifies TADs
#input/HiC-Pro_result_matrix_chr5_chr6/20Kb/chr6.matrix.gz need decompression
cd ./lib/TADLib
sh TADLib_findTAD.sh 
cd ../..

#Fit-Hi-C, infers loops
#input/HiC-Pro_result_matrix_chr5_chr6/5Kb/chr5.matrix.gz need decompression
#input/HiC-Pro_result_matrix_chr5_chr6/5Kb/chr6.matrix.gz need decompression
cd ./lib/Fit-Hi-C
sh FitHiC_findLoop.sh
cd ../..

#FitHiChIP, infers loops
#input/FitHiChIP_input_data/chr21.allValidPairs need decompression
cd ./lib/FitHiChIP
sh FitHiChIP_findloop.sh
cd ..


#hichipper
#Before running hichipper, you need to download the input file and run HiC-Pro, the detail can be find in ./lib/hichipper/HiC-Pro/run_HiC-Pro.sh
#cd ./lib/hichipper/HiC-Pro/
#sh run_HiC-Pro.sh
#cd ..
#sh run_hichipper.sh
#cd ../..
