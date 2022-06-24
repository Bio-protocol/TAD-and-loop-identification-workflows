## Downloading Gbarbadense_genome.fa from http://cotton.hzau.edu.cn/EN/data/download/Garboreum_genome_HAU_v1.0.tar.gz

## Enzyme fragments
python ./annotation/digest_genome.py ../Rawdata/Gbarbadense_genome.fa -r dpnii -o ./annotation/Gbar_dpnii.bed

## personal computer
HiC-Pro -c HiC-Pro.config -i ../Rawdata -o result 
## High Performance Computing
HiC-Pro -c HiC-Pro.config -i ../Rawdata -o result -p

cd result
sh HiCPro_step1.sh
sh HiCPro_step2.sh
