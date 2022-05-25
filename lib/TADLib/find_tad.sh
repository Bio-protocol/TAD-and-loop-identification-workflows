bin_f=$1
mtx_f=$2
outname=${3}

## split chr
python hicproTocool.py -b ${bin_f} -m ${mtx_f} -o ./intramtx -YN N

## to cool
cp ../dataset ./
cp ../chrom_Gb.sizes ./ 
toCooler -O ${outname}.cool -d dataset --chromsizes-file  chrom_Gb.sizes --no-balance

## findtad
cp ../meta_file ./
sed -i "s/name/${outname}/g" meta_file
hitad -O ${outname}.bed -d meta_file --logFile hitad.log -p 20 -W RAW --maxsize 2000000 

