## You can find detail of downloading genome data from annotation/README
## You can find detail of downloading HiC data from Rawdata/README 
 

## Enzyme fragments
python ./annotation/digest_genome.py ./Rawdata/GRCh38.fa -r dpnii -o ./annotation/GRCh38_dpnii.bed

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
