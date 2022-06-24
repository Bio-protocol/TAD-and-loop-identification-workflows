## identify TAD
java -jar scripts/juicer_tools.jar arrowhead -m 2000 -r 20000 -k KR --threads 15 ../../input/juicer_input_data/chr1.hic ../../output/Juicer/TAD

## identify loops
java -jar scripts/juicer_tools.jar hiccups --cpu -r 5000,10000 -f 0.1,0.1 -p 4,2 -i 7,5 -d 20000,20000 -t 0.02,1.5,1.75,2 -k KR --threads 10 ../../input/juicer_input_data/chr1.hic ../../output/Juicer/loop
