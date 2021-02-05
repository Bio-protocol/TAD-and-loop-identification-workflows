IN=gisaid_cov20200329_highcoverage_seq.fasta

mafft_cmd="mafft --anysymbol --auto --quiet --thread 40"
trimal_cmd="trimal -fasta -gappyout " #"ln -fs " #do not trim, just link the original files for next step
raxml_cmd="/beegfs/group_dv/software/source/standard-RAxML-8.2.9/raxmlHPC-PTHREADS-AVX2 -T 1 -f a -p 767 -x 23333 -#100 -m PROTGAMMAJTTX"
fasttree_cmd="fasttree -nt"
Al2Phylo_cmd="python2 /beegfs/group_dv/software/source/UPhO/Al2Phylo.py -m 20000 -p 0.80 -t 2"


 $mafft_cmd $IN > in.al 2>mafft.log 
 $trimal_cmd -in in.al  -out aln.fa > trimal.log 2>&1
 $Al2Phylo_cmd -in aln.fa > Al2Phylo.log 2>&1
