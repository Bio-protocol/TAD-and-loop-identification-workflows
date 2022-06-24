## Transform of HiC-Pro result file to Fit-Hi-C input file
python hicpro2fithic.py -i ../../input/HiC-Pro_result_matrix_chr5_chr6/5Kb/chr5.matrix -b ../../input/HiC-Pro_result_matrix_chr5_chr6/5Kb/chr5_abs.bed -r 5000 -o ../../input/fithic_input_data -n chr5 
python hicpro2fithic.py -i ../../input/HiC-Pro_result_matrix_chr5_chr6/5Kb/chr6.matrix -b ../../input/HiC-Pro_result_matrix_chr5_chr6/5Kb/chr6_abs.bed -r 5000 -o ../../input/fithic_input_data -n chr6 

## indentify the loops
fithic -f ../../input/fithic_input/input_data/chr5.fithic.fragmentMappability.gz -i ../../input/fithic_input_data/chr5.fithic.interactionCounts.gz -r 5000 -L 10000 -U 3000000 -p 2 -b 200 -o ../../output/Fit-Hi-C -l chr5
fithic -f ../../input/fithic_input/input_data/chr6.fithic.fragmentMappability.gz -i ../../input/fithic_input_data/chr6.fithic.interactionCounts.gz -r 5000 -L 10000 -U 3000000 -p 2 -b 200 -o ../../output/Fit-Hi-C -l chr6
