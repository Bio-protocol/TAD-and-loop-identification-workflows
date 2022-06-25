## Downloading Gbarbadense_genome.fa from http://cotton.hzau.edu.cn/EN/data/download/Garboreum_genome_HAU_v1.0.tar.gz
## You can find details of downloading HiC data from Rawdata/README 
 

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
