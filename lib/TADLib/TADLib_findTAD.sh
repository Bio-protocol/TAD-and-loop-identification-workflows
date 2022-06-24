# produce cool file
#cp ../../input/HiC-Pro_result_matrix_chr5_chr6/20Kb/chr5.matrix ../../input/TADLib_input_data/1_1.txt
#cp ../../input/HiC-Pro_result_matrix_chr5_chr6/20Kb/chr6.matrix ../../input/TADLib_input_data/2_2.txt
# toCooler from HiCPeaks
#toCooler -O ../../input/TADLib_input_data/chr5_chr6.cool -d ./chr5_chr6_dataset --chromsizes-file ./chr5_chr6.chromsizes --nproc 2 --no-balance

# indetifiy TAD
hitad -O ../../output/TAD_Lib/cotton_chr5_chr6_TADLib_TAD.bed -d meta_file --logFile hitad.log -p 2 -W RAW 
