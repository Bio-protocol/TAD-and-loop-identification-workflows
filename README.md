# TAD-and-loop-identification-workflows
The repository contains the code to identify TADs and loops from Hi-C and HiChIP library
# The flowchart
![image](workflow/workflow.png)
# The complete process of identifying TADs and loops by multiple software
# By running "sh workflow.sh",users can directly identify TADs through TADLib and Juicer, identify loops through Fit-Hi-C, Juicer and FitHiChIP.
The test data of TADLib is ./input/TADLib_input_data/chr5_chr6.cool.gz. The test data need to decompress before runing  
The test data of Juicer is ./input/juicer_input_data/chr1.hic.gz. The test data need to decompress before runing  
The test data of FitHiC is in ./input/fithic_input_data  
The test data of FitHiChIP is ./input/FitHiChIP_input_data/chr21.allValidPairs.gz. The test data need to decompress before running  
# Limited by file size of github, the rawdata of HiC-Pro and hichipper need to be downloaded by user
The running methods of HiC-Pro and hichipper are shown in workflow.sh  
The downloading detail of HiC-Pro rawdata is shown in lib/HiC-Pro/Rawdata/README  
The downloading detail of hichipper rawdata is shown in lib/hichipper/HiC-Pro/Rawdata/README  
```shell
sh workflow.sh
```
# Rawdata
The input/rawdata.txt includes the download adderss of rawdata used in this pipeline
# Detailed steps of HiC-Pro, Juicer, TADLib, Fit-Hi-C, FitHiChIP, hichipper
Lib folder contains some scripts required to run this pipeline
## HiC-Pro needs downloaded rawdata, and the detail can be find in ./lib/HiC-Pro/run_HiC-Pro.sh and ./lib/HiC-Pro/Rawdata/README
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
More parameter details of HiC-Pro can be find in https://nservant.github.io/HiC-Pro/


## Juicer, identifies TADs and infers loops
``` shell
## identifies TADs
java -jar scripts/juicer_tools.jar arrowhead -m 2000 -r 20000 -k KR --threads 15 ../../input/juicer_input_data/chr1.hic ../../output/Juicer/TAD

## infers loops
java -jar scripts/juicer_tools.jar hiccups --cpu -r 5000,10000 -f 0.1,0.1 -p 4,2 -i 7,5 -d 20000,20000 -t 0.02,1.5,1.75,2 -k KR --threads 10 ../../input/juicer_input_data/chr1.hic ../../output/Juicer/loop
```
More parameter details of Juicer can be find in https://github.com/aidenlab/juicer/wiki


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
More parameter details of TADLib can be find in https://xiaotaowang.github.io/TADLib/hitad_api.html


## Fit-Hi-C
```
## Convert the result file produce by HiC-Pro to the input file of Fit-Hi-C
python hicpro2fithic.py -i ../../input/HiC-Pro_result_matrix_chr5_chr6/5Kb/chr5.matrix -b ../../input/HiC-Pro_result_matrix_chr5_chr6/5Kb/chr5_abs.bed -r 5000 -o ../../input/fithic_input_data -n chr5 
python hicpro2fithic.py -i ../../input/HiC-Pro_result_matrix_chr5_chr6/5Kb/chr6.matrix -b ../../input/HiC-Pro_result_matrix_chr5_chr6/5Kb/chr6_abs.bed -r 5000 -o ../../input/fithic_input_data -n chr6 

## Infers loops
fithic -f ../../input/fithic_input/input_data/chr5.fithic.fragmentMappability.gz -i ../../input/fithic_input_data/chr5.fithic.interactionCounts.gz -r 5000 -L 10000 -U 3000000 -p 2 -b 200 -o ../../output/Fit-Hi-C -l chr5
fithic -f ../../input/fithic_input/input_data/chr6.fithic.fragmentMappability.gz -i ../../input/fithic_input_data/chr6.fithic.interactionCounts.gz -r 5000 -L 10000 -U 3000000 -p 2 -b 200 -o ../../output/Fit-Hi-C -l chr6
```
More parameter details of Fit-Hi-C can be find in https://github.com/ay-lab/fithic


## FitHiChIP
```
# Infers loops
bash FitHiChIP_HiCPro.sh -C configfile_BiasCorrection_CoverageBias_chr21 
```
More parameter details of FitHiChIP can be find in https://ay-lab.github.io/FitHiChIP/


## hichipper needs output file produced by HiC-Pro
## HiC-Pro needs download rawdata. The details can be find in hichipper/HiC-Pro/annotation/README and hichipper/HiC-Pro/Rawdata/README 

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
More parameter details of hichipper can be find in https://hichipper.readthedocs.io/en/latest/

# output
The folder contains the results of TADs and loops from Hi-C and HiChIP library
# result visualisation
![image](graphs/result.png)
# workflow.sh
The script records the commands for running theses tools
