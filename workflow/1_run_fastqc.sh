#!/bin/sh

# normalize your dir to the root level of the repo
normalDir="`cd "${..}";pwd`"
echo "${normalDir}"

fastqc -o output/ -f fastq -t 1 input/reads1.fastq input/reads1.fastq > output/run.log