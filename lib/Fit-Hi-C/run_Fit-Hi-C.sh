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
