#Generates .hic file
juicer.sh -z references/Gbarbadense_genome.fa -g Gbarbadense_genome -p references/Ghirsutum_genome.sizes -y restriction_sites/Ghirsutum_genome_DpnII.txt -d ../Rawdata -D ./ -t 50

#identifies TADs
java -jar scripts/juicer_tools.jar arrowhead -m 2000 -r 50000 -k KR --threads 15 ../Rawdata/GM12878.hic ./
#infers loops
java -jar scripts/juicer_tools.jar hiccups --cpu -r 5000,10000 -f 0.1,0.1 -p 4,2 -i 7,5 -d 20000,20000 -t 0.02,1.5,1.75,2 -k KR --threads 10 ../Rawdata/GM12878.hic all_hiccups_loop
