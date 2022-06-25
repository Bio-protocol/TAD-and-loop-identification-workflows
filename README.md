# TAD-and-loop-identification-workflows
The repository contains the code to identify TAD and loop from Hi-C and HiChIP library
# The flowchart
![image](workflow/workflow.png)
# Pipeline
sh workflow.sh
# Rawdata
The input/rawdata.txt record the download adderss of rawdata
# HiC-Pro, Juicer, TADLib, Fit-Hi-C, FitHiChIP, hichipper, 
These folder contains Scripts required to run these software
## HiC-Pro, need to download rawdata, the detail can be find in ./lib/HiC-Pro/run_HiC-Pro.sh
```shell
## Enzyme fragments
python ./annotation/digest_genome.py ../Rawdata/Gbar.fa -r dpnii -o ./annotation/Gbar_dpnii.bed

## Chromosome size
cd annotation
samtools faidx Gbar.fa
awk -v OFS="\t" '{print $1,$2}' Gbar.fa.fai > ./annotation/chrom_Gb.sizes
cd ..

## Bowtie2
cd Bowtie2
ln -s ../annotation/Gbar.fa
bowtie2-build -f Gbar.fa Gbar
cd ..


## Personal computer
HiC-Pro -c HiC-Pro.config -i ../Rawdata -o result 

## High performance computing
HiC-Pro -c HiC-Pro.config -i ../Rawdata -o result -p
cd result
sh HiCPro_step1.sh
sh HiCPro_step2.sh
```
## Juicer, identifies TADs and infers loops
``` shell
## identifies TADs
java -jar scripts/juicer_tools.jar arrowhead -m 2000 -r 20000 -k KR --threads 15 ../../input/juicer_input_data/chr1.hic ../../output/Juicer/TAD

## infers loops
java -jar scripts/juicer_tools.jar hiccups --cpu -r 5000,10000 -f 0.1,0.1 -p 4,2 -i 7,5 -d 20000,20000 -t 0.02,1.5,1.75,2 -k KR --threads 10 ../../input/juicer_input_data/chr1.hic ../../output/Juicer/loop
```

## TADLib
```
# Produce cool file
cp ../../input/HiC-Pro_result_matrix_chr5_chr6/20Kb/chr5.matrix ../../input/TADLib_input_data/1_1.txt
cp ../../input/HiC-Pro_result_matrix_chr5_chr6/20Kb/chr6.matrix ../../input/TADLib_input_data/2_2.txt
# toCooler from HiCPeaks
toCooler -O ../../input/TADLib_input_data/chr5_chr6.cool -d ./chr5_chr6_dataset --chromsizes-file ./chr5_chr6.chromsizes --nproc 2 --no-balance

# Identifies TADs
hitad -O ../../output/TAD_Lib/cotton_chr5_chr6_TADLib_TAD.bed -d meta_file --logFile hitad.log -p 2 -W RAW 
```
## Fit-Hi-C
```
## Convert the result file produce by HiC-Pro to the input file of Fit-Hi-C
python hicpro2fithic.py -i ../../input/HiC-Pro_result_matrix_chr5_chr6/5Kb/chr5.matrix -b ../../input/HiC-Pro_result_matrix_chr5_chr6/5Kb/chr5_abs.bed -r 5000 -o ../../input/fithic_input_data -n chr5 
python hicpro2fithic.py -i ../../input/HiC-Pro_result_matrix_chr5_chr6/5Kb/chr6.matrix -b ../../input/HiC-Pro_result_matrix_chr5_chr6/5Kb/chr6_abs.bed -r 5000 -o ../../input/fithic_input_data -n chr6 

## Infers loops
fithic -f ../../input/fithic_input/input_data/chr5.fithic.fragmentMappability.gz -i ../../input/fithic_input_data/chr5.fithic.interactionCounts.gz -r 5000 -L 10000 -U 3000000 -p 2 -b 200 -o ../../output/Fit-Hi-C -l chr5
fithic -f ../../input/fithic_input/input_data/chr6.fithic.fragmentMappability.gz -i ../../input/fithic_input_data/chr6.fithic.interactionCounts.gz -r 5000 -L 10000 -U 3000000 -p 2 -b 200 -o ../../output/Fit-Hi-C -l chr6
```
## FitHiChIP
```
# Infers loops
bash FitHiChIP_HiCPro.sh -C configfile_BiasCorrection_CoverageBias_chr21 
```
## hichipper
```
#run HiC-Pro

## Enzyme fragments
python ./annotation/digest_genome.py ../Rawdata/GRCh38.fa -r dpnii -o ./annotation/GRCh38_dpnii.bed

## Chromosome size
cd annotation
samtools faidx GRCh38.fa
awk -v OFS="\t" '{print $1,$2}' GRCh38.fa.fai > GRCh38_sizes.txt
cd ..

## Bowtie2
cd Bowtie2
ln -s ../annotation/GRCh38.fa
bowtie2-build -f GRCh38.fa GRCh38
cd ..

## Personal computer
HiC-Pro -c HiC-Pro.config -i ../Rawdata -o result 

## High performance computing
HiC-Pro -c HiC-Pro.config -i ../Rawdata -o result -p
cd result
sh HiCPro_step1.sh
sh HiCPro_step2.sh

# runn hichipper
hichipper --out result two.yaml --macs2-string "-q 0.1" --macs2-genome "hs"
```
# output
The folder contains the results of TADs and loops from Hi-C and HiChIP library
# result visualisation
![image](graphs/result.png)
# workflow.sh
The script record the run commands of theses tools
