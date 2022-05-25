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
