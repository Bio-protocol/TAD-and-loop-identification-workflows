# TAD-and-loop-identification-workflows
The repository contains the code to identify TAD and loop from Hi-C and HiChIP library
# The flowchart
![image](workflow/workflow.png)
# Rawdata
The rawdata.txt file in this folder records the original file download address, as github uploads cannot exceed 100 Mb.
# HiC-Pro, Juicer, TADLib, Fit-Hi-C, FitHiChIP, hichipper, 
These folder contains Scripts required to run these software
## Fit-Hi-C
```shell
HiC-Pro -c HiC-Pro.config -i ../Rawdata -o result -p
cd result
sh HiCPro_step1.sh
sh HiCPro_step2.sh
```
## Juicer
``` shell
#Generate .hic file
juicer.sh -z references/Gbarbadense_genome.fa -g Gbarbadense_genome -p references/Ghirsutum_genome.sizes -y restriction_sites/Ghirsutum_genome_DpnII.txt -d ../Rawdata -D ./ -t 50
#indentify TADs human
java -jar scripts/juicer_tools.jar arrowhead -m 2000 -r 50000 -k KR --threads 15 ../Rawdata/GM12878.hic ./
#infer loops human
java -jar scripts/juicer_tools.jar hiccups --cpu -r 5000,10000 -f 0.1,0.1 -p 4,2 -i 7,5 -d 20000,20000 -t 0.02,1.5,1.75,2 -k KR --threads 10 ../Rawdata/GM12878.hic all_hiccups_loop
```
## TADLib
```
#!/bin/bash
config_f=$1
bin_f='../HiC-Pro/result/hic_results/matrix/fiber_20DPA/raw/20000/fiber_20DPA_20000_abs.bed'
mtx_f='../HiC-Pro/result/hic_results/matrix/fiber_20DPA/raw/20000/fiber_20DPA_20000.matrix'
outdir='TAD_result'
mkdir ${outdir}
cp find_tad.sh ${outdir}
cd ${outdir}
mkdir intramtx
sh find_tad.sh ${bin_f} ${mtx_f} ${outdir}
```
## Fit-Hi-C
```
#!/bin/bash
bin_f='../HiC-pro/result/hic_results/matrix/fiber_20DPA/raw/5000/fiber_20DPA_5000_abs.bed'
mtx_f='../HiC-pro/result/hic_results/matrix/fiber_20DPA/raw/5000/fiber_20DPA_5000.matrix'
outdir='./loop_result'
if [ ! -d ${outdir} ]; then
   mkdir ${outdir}
 fi
cp find_loop.sh ${outdir}
cd ${outdir}
if [ ! -d input_f ]; then
  mkdir input_f
fi
if [ ! -d output_f ]; then
  mkdir output_f
fi 
sh find_loop.sh ${bin_f} ${mtx_f}
```
## FitHiChIP
```
bash FitHiChIP_HiCPro.sh -C configfile_BiasCorrection_CoverageBias
```
## hichipper
```
python digest_genome.py ../Rawdata/Gh38.fa -r dpnii -o Gh38_dpnii.bed
hichipper --out result two.yaml --macs2-string "-q 0.1" --macs2-genome "hs"
```
# output
The folder contains the results of TADs and loops from Hi-C and HiChIP library
# result visualisation
![image](graphs/result.png)
# workflow.sh
The script record the run commands of theses tools
